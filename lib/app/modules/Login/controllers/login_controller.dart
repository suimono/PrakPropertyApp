// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // TextEditingControllers for email and password fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observables for form validation and loading state
  var isLoading = false.obs;
  var isEmailValid = false.obs;
  var isPasswordValid = false.obs;

  // Function to validate email
  void validateEmail(String value) {
    isEmailValid.value = GetUtils.isEmail(value);
  }

  // Function to validate password (at least 6 characters)
  void validatePassword(String value) {
    isPasswordValid.value = value.length >= 6;
  }

  // Function to handle login logic
  Future<void> login() async {
    // Validate email and password before proceeding
    if (!isEmailValid.value || !isPasswordValid.value) {
      Get.snackbar("Error", "Please enter a valid email and password.");
      return;
    }

    // Start loading
    isLoading.value = true;

    try {
      // Simulate login request
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay

      
      bool loginSuccess = true; // Set this based on API response

      if (loginSuccess) {
        // If login is successful, navigate to the profile or home page
        Get.offAllNamed("/profile"); // Adjust the route accordingly
      }
    } catch (e) {
      // Handle any exceptions during login
      Get.snackbar("Error", "An error occurred. Please try again later.");
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Dispose of controllers when not needed
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
