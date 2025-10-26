// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // TextEditingControllers for name, email, and password fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observables for form validation and loading state
  var isLoading = false.obs;
  var isNameValid = false.obs;
  var isEmailValid = false.obs;
  var isPasswordValid = false.obs;

  // Function to validate name (not empty)
  void validateName(String value) {
    isNameValid.value = value.isNotEmpty;
  }

  // Function to validate email
  void validateEmail(String value) {
    isEmailValid.value = GetUtils.isEmail(value);
  }

  // Function to validate password (at least 6 characters)
  void validatePassword(String value) {
    isPasswordValid.value = value.length >= 6;
  }

  // Function to handle signup logic
  Future<void> signUp() async {
    // Validate all fields before proceeding
    if (!isNameValid.value || !isEmailValid.value || !isPasswordValid.value) {
      Get.snackbar("Error", "Please fill all fields with valid information.");
      return;
    }

    // Start loading
    isLoading.value = true;

    try {
      // Simulate sign-up request
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay

      // Replace this with actual API call and response handling
      bool signUpSuccess = true; // Set this based on API response

      if (signUpSuccess) {
        // If sign-up is successful, navigate to the login page
        Get.offAllNamed("/login");
      }
    } catch (e) {
      // Handle any exceptions during sign-up
      Get.snackbar("Error", "An error occurred. Please try again later.");
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Dispose of controllers when not needed
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
