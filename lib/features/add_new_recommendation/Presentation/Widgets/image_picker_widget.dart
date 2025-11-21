import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ImagePickerWidget extends StatefulWidget {
  final List<File> initialImages;
  final ValueChanged<List<File>> onChanged;

  const ImagePickerWidget({
    super.key,
    required this.initialImages,
    required this.onChanged,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();
  late List<File> _images;

  @override
  void initState() {
    super.initState();
    _images = List.from(widget.initialImages);
  }

  // Helper to compress to temp file
  Future<File> _compressToTemp(File input) async {
    try {
      final tmpDir = await getTemporaryDirectory();
      final outPath = p.join(
        tmpDir.path,
        '${DateTime.now().millisecondsSinceEpoch}_${p.basename(input.path)}',
      );
      final result = await FlutterImageCompress.compressAndGetFile(
        input.path,
        outPath,
        quality: 65,
        minWidth: 800,
        minHeight: 600,
      );
      if (result == null) return input;
      return File(result.path);
    } catch (_) {
      return input;
    }
  }

  // Helper to pick multiple images from gallery
  Future<void> _pickFromGallery() async {
    try {
      final List<XFile>? picked = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1600,
        maxHeight: 1600,
      );
      if (picked != null && picked.isNotEmpty) {
        for (final x in picked) {
          final compressed = await _compressToTemp(File(x.path));
          setState(() {
            _images.add(compressed);
          });
        }
        widget.onChanged(_images);
      }
    } catch (e) {
      // ignore error
    }
  }

  // Helper to take a photo
  Future<void> _pickFromCamera() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1600,
        maxHeight: 1600,
      );
      if (picked != null) {
        final compressed = await _compressToTemp(File(picked.path));
        setState(() {
          _images.add(compressed);
        });
        widget.onChanged(_images);
      }
    } catch (e) {
      // ignore error
    }
  }

  // Show option sheet for picking
  Future<void> _showImageSourceAction() async {
    await showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _pickFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _pickFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _showImageSourceAction,
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300, width: 1.2),
            ),
            child: _images.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tap to upload place image",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _images.asMap().entries.map<Widget>((entry) {
                          final idx = entry.key;
                          final file = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    file,
                                    width: 140,
                                    height: 160,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _images.removeAt(idx);
                                      });
                                      widget.onChanged(_images);
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList()
                          ..add(
                            // "Add more" button
                            GestureDetector(
                              onTap: _showImageSourceAction,
                              child: Container(
                                width: 140,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 28,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
