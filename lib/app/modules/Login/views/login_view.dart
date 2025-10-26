// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/controllers/auth_controller.dart';
import 'package:mobileapp/app/modules/Login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Get.back(); 
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png', // Replace with your logo path
                      height: 80,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Amanah dan Profesional",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
        
              // Email input field
              TextField(
                controller: controller.emailController,
                onChanged: controller.validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email atau Nomor HP",
                  border: OutlineInputBorder(),
                  errorText: controller.isEmailValid.value ? null : "Invalid email",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20),
        
              // Password input field
              TextField(
                controller: controller.passwordController,
                onChanged: controller.validatePassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
        
              // Login button
              ElevatedButton(
                onPressed: () => controller.emailController.text == "admin@gmail.com" && controller.passwordController.text == "admin123" ? authC.loginAdmin() : authC.login(controller.emailController.text, controller.passwordController.text)  ,
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("LOGIN"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                ),
              ),
        
              SizedBox(height: 10),
        
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to signup page
                    Get.toNamed('/signup');
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Belum mempunyai akun? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Daftar",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
