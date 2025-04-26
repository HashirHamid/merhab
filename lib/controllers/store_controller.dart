import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/models/store_model.dart';
import 'package:path/path.dart';
import '../services/supabase_service.dart';

class StoreController extends GetxController {
  final SupabaseService _supabase = SupabaseService();

  final isAddingStore = false.obs;
  final isLoadingStores = false.obs;
  List<StoreModel> stores = [];

  Future<void> uploadStore({
    required String name,
    required String website,
    required String description,
    required File imageFile,
  }) async {
    isAddingStore.value = true;
    try {
      final fileExt = extension(imageFile.path);
      final fileName = '${DateTime.now().millisecondsSinceEpoch}$fileExt';
      final storagePath = 'stores/$fileName';

      // Upload to Supabase Storage
      await _supabase.uploadFile('images', storagePath, imageFile);

      // Get public URL
      final publicUrl = await _supabase.getPublicUrl('images', storagePath);

      // Insert into `stores` table
      await _supabase.insertData('stores', {
        'name': name,
        'website': website,
        'description': description,
        'image_url': publicUrl,
        'user_id': _supabase.currentUser?.id,
      }).then((_) {
        Get.back();
        Get.snackbar('Success', 'Store uploaded successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      });
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isAddingStore.value = false;
    }
  }

  Future<void> getStores() async {
    try {
      isLoadingStores.value = true;
      final stores = await _supabase.getData('stores');
      if (stores != []) {
        // Process the stores data as needed
        this.stores = stores.map((store) => StoreModel.fromMap(store)).toList();
      } else {
        Get.snackbar('Error', 'No stores found',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoadingStores.value = false;
    }
  }
}
