import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merhab/controllers/store_controller.dart';
import 'package:merhab/theme/themes.dart';

class AddSouvenirStore extends StatefulWidget {
  const AddSouvenirStore({super.key});

  @override
  State<AddSouvenirStore> createState() => _AddSouvenirStoreState();
}

class _AddSouvenirStoreState extends State<AddSouvenirStore> {
  bool isValidWebsite(String input) {
    final pattern = r'^www\.[a-zA-Z0-9\-]+\.(com)$';
    return RegExp(pattern).hasMatch(input);
  }

  ImagePicker imagePicker = ImagePicker();
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _websiteUrlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Souvenir Store'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _storeNameController,
              decoration: InputDecoration(
                labelText: 'Store Name',
                border: OutlineInputBorder(),
                prefixIcon:
                    const Icon(Icons.store, color: AppTheme.primaryGreenColor),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _websiteUrlController,
              decoration: InputDecoration(
                labelText: 'Website URL',
                border: OutlineInputBorder(),
                prefixIcon:
                    const Icon(Icons.link, color: AppTheme.primaryGreenColor),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.description,
                    color: AppTheme.primaryGreenColor),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side:
                      BorderSide(color: AppTheme.primaryGreenColor, width: 2.0),
                ),
                onPressed: () {
                  imagePicker
                      .pickImage(source: ImageSource.gallery)
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        image = File(value.path);
                      });
                    }
                  });
                },
                child: Text("Add Image")),
            const SizedBox(height: 16),
            image != null
                ? Image.file(image!, height: 200, width: 200, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                    return const Text("Error loading image");
                  })
                : Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLavenderColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text("No Image Selected"),
                    ),
                  ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Obx(
                  () => SizedBox(
                    width: Get.width,
                    child: Get.find<StoreController>().isAddingStore.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (_storeNameController.text.isNotEmpty &&
                                  _websiteUrlController.text.isNotEmpty &&
                                  _descriptionController.text.isNotEmpty &&
                                  image != null) {
                                if (!isValidWebsite(
                                    _websiteUrlController.text)) {
                                  Get.snackbar('Error',
                                      'Please enter a valid website URL.\nExample: www.example.com',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white);
                                  return;
                                }
                                // Call your upload function here
                                Get.find<StoreController>().uploadStore(
                                  name: _storeNameController.text,
                                  website: _websiteUrlController.text,
                                  description: _descriptionController.text,
                                  imageFile: image!,
                                );
                              } else {
                                Get.snackbar('Error', 'Please fill all fields',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              }
                            },
                            child: const Text('Add Store'),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
