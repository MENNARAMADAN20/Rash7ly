import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rash7ly/components/formfields/new_rec_field.dart';
import 'package:rash7ly/core/utilis/app_colors.dart';
import '../../Bloc/add_rec_bloc.dart';
import '../../Bloc/add_rec_events.dart';
import '../../Bloc/add_rec_state.dart';
import 'image_picker_widget.dart';

class AddRecFormBody extends StatefulWidget {
  const AddRecFormBody({super.key});

  @override
  State<AddRecFormBody> createState() => _AddRecFormBodyState();
}

class _AddRecFormBodyState extends State<AddRecFormBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String? _selectedCategory;
  List<File> _images = [];
  bool _isLoading = false;
  double _uploadProgress = 0.0;

  final List<String> _categories = [
    "Beaches",
    "Cafes",
    "Mountains",
    "Cities",
    "Natural Park",
    "Historical Places",
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be signed in to submit')),
      );
      return;
    }

    context.read<AddRecBloc>().add(
          AddRecSubmitted(
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            location: _locationController.text.trim(),
            category: _selectedCategory ?? '',
            userId: user.uid,
            images: _images,
          ),
        );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          if (context.mounted) {
            Navigator.of(context).pop(true);
          }
        });
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Recommendation Added Successfully!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blueColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddRecBloc, AddRecState>(
      listener: (context, state) {
        if (state is AddRecSuccess) {
          setState(() {
            _isLoading = false;
            _uploadProgress = 0.0;
          });
          Navigator.of(context).pop(); // close bottom sheet
          _showSuccessDialog();
        } else if (state is AddRecFailure) {
          setState(() {
            _isLoading = false;
            _uploadProgress = 0.0;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        } else if (state is AddRecLoading) {
          setState(() {
            _isLoading = true;
            _uploadProgress = 0.0;
          });
        } else if (state is AddRecProgress) {
          setState(() {
            _isLoading = true;
            _uploadProgress = state.progress;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 25,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Recommend a New Place",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Image Picker Section
                FormField<List<File>>(
                  initialValue: _images,
                  validator: (imgs) {
                    if (_images.isEmpty) {
                      return 'Please add at least one image';
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImagePickerWidget(
                          initialImages: _images,
                          onChanged: (files) {
                            setState(() {
                              _images = files;
                            });
                            field.didChange(files);
                          },
                        ),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                            child: Text(
                              field.errorText ?? '',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),
                NewRecField(
                  text: 'Place Name...',
                  controller: _nameController,
                  validator: (value) =>
                      value?.trim().isEmpty == true ? 'Required' : null,
                ),
                const SizedBox(height: 20),
                NewRecField(
                  controller: _descriptionController,
                  text: 'Description...',
                  maxLines: 3,
                  validator: (value) =>
                      value?.trim().isEmpty == true ? 'Required' : null,
                ),
                const SizedBox(height: 20),

                // Category Dropdown
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300, width: 1.2),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      hint: const Text("Select Category"),
                      validator: (val) =>
                          val == null ? 'Please select a category' : null,
                      items: _categories.map((cat) {
                        return DropdownMenuItem(value: cat, child: Text(cat));
                      }).toList(),
                      onChanged: (value) => setState(() {
                        _selectedCategory = value;
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                NewRecField(
                  controller: _locationController,
                  text: 'Location...',
                  validator: (value) =>
                      value?.trim().isEmpty == true ? 'Required' : null,
                ),
                const SizedBox(height: 25),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: _isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Uploading...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        : const Text(
                            "Submit Recommendation",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
