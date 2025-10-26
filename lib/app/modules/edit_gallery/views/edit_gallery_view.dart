// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/modules/Gallery/controllers/gallery_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditGalleryView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final GalleryController controller = Get.find();
  File? selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final item = args?['item'];
    final index = args?['index'];

    // Fill in form data if in edit mode
    if (item != null && item['image'] != null) {
      selectedImage = File(item['image']);
      titleController.text = item['title'] ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item == null ? 'Tambah Item Gallery' : 'Edit Item Gallery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Judul'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul wajib diisi';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: selectedImage != null
                      ? Image.file(selectedImage!, fit: BoxFit.cover)
                      : Center(child: Text('Pilih Gambar')),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newItem = {
                      'title': titleController.text,
                      'image': selectedImage?.path ?? '',
                    };

                    if (item == null) {
                      controller.addGalleryItem(newItem);
                    } else {
                      controller.updateGalleryItem(index, newItem);
                    }

                    Get.back();
                  }
                },
                child: Text(item == null ? 'Simpan' : 'Perbarui'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
