// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobileapp/app/routes/app_pages.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3C2A98),
      appBar: AppBar(
        toolbarHeight: 60,
        title: Image.asset(
          'assets/logo.png',
          width: 100,
          height: 100,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Admin Menu',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.card_travel_rounded, color: Colors.black),
                        title: Text("Menu Paket"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Get.toNamed(Routes.ADMIN_PAKET); // Navigate to edit profile page
                        },
                      ),
                      // Change Password
                      ListTile(
                        leading: Icon(Icons.photo, color: Colors.black),
                        title: Text("Menu Galeri"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Get.toNamed(
                              Routes.ADMIN_GALLERY); // Navigate to change password page
                        },
                      ),
                      // Logout
                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.black),
                        title: Text("Logout"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {Get.offAllNamed(Routes.HOME);},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
