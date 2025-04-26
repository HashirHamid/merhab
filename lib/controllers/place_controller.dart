import 'dart:io';
import 'package:flutter/material.dart';
import 'package:merhab/models/place_model.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:merhab/services/supabase_service.dart';

class PlaceController extends GetxController {
  final SupabaseService _supabase = SupabaseService();
  final isAddingPlace = false.obs;
  final isLoadingPlaces = false.obs;
  List<PlaceModel> places = [];

  Future<void> uploadPlace({
    required String name,
    required String description,
    required double latitude,
    required double longitude,
    required List<File> images, // Up to 3 images
    required String startTime, // Format: HH:mm
    required String endTime, // Format: HH:mm
    required double priceStart,
    required double priceEnd,
  }) async {
    isAddingPlace.value = true;

    try {
      List<String> imageUrls = [];

      // Upload each image and get public URLs
      for (int i = 0; i < images.length && i < 3; i++) {
        final image = images[i];
        final fileExt = extension(image.path);
        final fileName = '${DateTime.now().millisecondsSinceEpoch}_$i$fileExt';
        final storagePath = 'places/$fileName';

        await _supabase.uploadFile('images', storagePath, image);
        final publicUrl = await _supabase.getPublicUrl('images', storagePath);

        imageUrls.add(publicUrl);
      }

      // Insert into `places` table
      await _supabase.insertData('places', {
        'name': name,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'images': imageUrls, // Assuming column is type text[] or jsonb
        'start_time': startTime,
        'end_time': endTime,
        'price_start': priceStart,
        'price_end': priceEnd,
        'user_id': _supabase.currentUser?.id,
      }).then((_) {
        Get.back();
        Get.snackbar('Success', 'Place uploaded successfully',
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
      isAddingPlace.value = false;
    }
  }

  Future<void> getPlaces() async {
    try {
      isLoadingPlaces.value = true;
      final places = await _supabase.getData('places');
      if (places != []) {
        // Process the stores data as needed
        this.places = places.map((place) => PlaceModel.fromMap(place)).toList();
      } else {
        Get.snackbar('Error', 'No places found',
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
      isLoadingPlaces.value = false;
    }
  }
}
