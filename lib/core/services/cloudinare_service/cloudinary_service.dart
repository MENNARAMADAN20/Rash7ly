import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';

class CloudinaryService {
  final Dio _dio = Dio();
  final String cloudName;
  final String unsignedUploadPreset;

  CloudinaryService({
    this.cloudName = 'dynayt1a6',
    this.unsignedUploadPreset = 'Rasha7ly_upload',
  }) {
    // Configure basic timeouts
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
  }

  Future<File> _compress(File file) async {
    try {
      final tmp = await getTemporaryDirectory();
      final outPath = p.join(
        tmp.path,
        '${p.basenameWithoutExtension(file.path)}_cmp${p.extension(file.path)}',
      );
      final result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        outPath,
        quality: 75,
      );

      if (result == null) return file;
      return File(result.path);
    } catch (e) {
      print('Compression failed: $e');
      return file;
    }
  }

  Future<String> uploadFile(
    File file, {
    void Function(int sent, int total)? onProgress,
  }) async {
    if (!file.existsSync()) {
      throw Exception('File does not exist: ${file.path}');
    }

    final fileToUpload = await _compress(file);
    if (!fileToUpload.existsSync() || fileToUpload.lengthSync() == 0) {
      throw Exception('Compressed file invalid or empty');
    }

    final uploadUrl = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
    final preset = unsignedUploadPreset;

    print('=== Cloudinary Upload Debug ===');
    print('URL: $uploadUrl');
    print('Preset: $preset');
    print('File: ${fileToUpload.path} (${fileToUpload.lengthSync()} bytes)');

    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          fileToUpload.path,
          filename: p.basename(fileToUpload.path),
          contentType: MediaType('image', 'jpeg'),
        ),
        'upload_preset': preset,
      });

      final response = await _dio.post(
        uploadUrl,
        data: formData,
        onSendProgress: onProgress,
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final secureUrl = response.data['secure_url'];
        if (secureUrl != null) {
          print('✓ Upload successful: $secureUrl');
          return secureUrl as String;
        }
      }

      throw Exception('Invalid response or missing secure_url');
    } on DioException catch (e) {
      print('✗ Dio error: ${e.type}');
      print('  Message: ${e.message}');
      print('  Error: ${e.error}');
      print('  Status: ${e.response?.statusCode}');
      print('  Body: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('✗ Unexpected error: $e');
      rethrow;
    }
  }

  Future<List<String>> uploadFiles(
    List<File> files, {
    void Function(double)? onOverallProgress,
  }) async {
    final total = files.length;
    final urls = <String>[];

    for (var i = 0; i < total; i++) {
      final url = await uploadFile(
        files[i],
        onProgress: (sent, totalBytes) {
          final fraction = totalBytes > 0 ? sent / totalBytes : 0.0;
          final overall = ((i + fraction) / total).clamp(0.0, 1.0);
          onOverallProgress?.call(overall);
        },
      );
      urls.add(url);
      onOverallProgress?.call(((i + 1) / total).clamp(0.0, 1.0));
    }

    return urls;
  }
}
