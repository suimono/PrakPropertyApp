// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/controllers/auth_controller.dart';
import 'package:mobileapp/app/modules/SignUp/controllers/signup_controller.dart';

class SignUpView extends GetView<SignUpController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Sign Up"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  "assets/logo.png", // Ganti dengan path logo yang sesuai
                  height: 100,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.nameController,
                onChanged: controller.validateName,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controller.emailController,
                onChanged: controller.validateEmail,
                decoration: InputDecoration(
                  labelText: "Email Aktif",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controller.passwordController,
                onChanged: controller.validatePassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Obx(() => ElevatedButton(
                onPressed: () => authC.signup(controller.emailController.text, controller.passwordController.text, controller.nameController.text),
        
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text("SIGN UP"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  )),
              SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () => Get.toNamed("/login"),
                  child: Text(
                    "Sudah mempunyai akun? Masuk",
                    style: TextStyle(color: Colors.blue),
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
