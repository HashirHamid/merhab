import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/models/user_model.dart';
import 'package:merhab/screens/home_layout.dart';
import 'package:merhab/screens/login_screen.dart';
import 'package:merhab/screens/setup_profile_screen.dart';
import 'package:merhab/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  // Define your variables and methods here
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  var isLoadingProfile = false.obs;

  UserModel userData = UserModel();

  final SupabaseService _supabaseService = SupabaseService();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await _supabaseService.signIn(email, password);

      if (response.user != null) {
        _supabaseService.getUserById(response.user?.id ?? "").then((user) {
          if (user != null) {
            userData = UserModel.fromMap(user);
            Get.to(() => HomeLayout());
          } else {
            Get.snackbar('Login Error', 'User not found',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white);
          }
        });
      }
    } on AuthException catch (e) {
      log(e.toString());
      Get.snackbar('Login Error', e.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(String email, String password, String firstName,
      String lastName, String phoneNumber, String passportNumber) async {
    isLoading.value = true;
    try {
      if ((await _supabaseService.userExists(email))) {
        Get.snackbar('Login Error', 'User already exist',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }
      _supabaseService.signUp(email, password).then((response) {
        log(response.user?.id ?? "");
        if (response.user != null) {
          _supabaseService.insertData("users", {
            "email": email,
            "first_name": firstName,
            "last_name": lastName,
            "phone_number": phoneNumber,
            "passport_number": passportNumber,
            "user_id": response.user!.id,
          }).then((_) {
            _supabaseService.getUserById(response.user?.id ?? "").then((user) {
              if (user != null) {
                userData = UserModel.fromMap(user);
                Get.to(() => SetupProfileScreen());
              } else {
                Get.snackbar('Login Error', 'User not found',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white);
              }
            });

            Get.snackbar('Signup Success', 'User created successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white);
          }).catchError((error) {
            Get.snackbar('Database Error', '$error',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white);
            debugPrint(error.toString());
          });
        }
      });
    } on AuthException catch (e) {
      Get.snackbar('Signup Error', e.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setupProfile(String nationality, String gender, String age,
      String bloodType, String emergencyContact, String relative) async {
    userData.nationality = nationality;
    userData.gender = gender;
    userData.age = age;
    userData.bloodType = bloodType;
    userData.emergencyContact = emergencyContact;
    userData.relative = relative;
    try {
      isLoadingProfile.value = true;
      await _supabaseService.updateData(
          "users", userData.toMap(), "user_id", userData.userId);
      Get.snackbar('Setup Profile Success', 'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } on AuthException catch (c) {
      Get.snackbar('Setup Profile Error', c.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      debugPrint(c.toString());
    } finally {
      isLoadingProfile.value = false;
      Get.offAll(() => HomeLayout());
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await _supabaseService.signOut();
      userData = UserModel();
      isLoggedIn.value = false;
      Get.offAll(() => LoginScreen());
    } catch (e) {
      Get.snackbar('Logout Error', '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
