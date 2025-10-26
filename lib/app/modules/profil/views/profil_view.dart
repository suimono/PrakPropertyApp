import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/controllers/auth_controller.dart';
import 'package:mobileapp/app/modules/profil/controllers/profil_controller.dart';
import 'package:mobileapp/app/routes/app_pages.dart';

class ProfilView extends GetView<ProfilController> {
  @override
  final ProfilController controller = Get.put(ProfilController());
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: authC.isLoggedIn.value
            ? _buildAfterLogin(context)
            : _buildBeforeLogin(context),
      ),
    );
  }

  Widget _buildBeforeLogin(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 280,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.login, color: Colors.black87),
                title: Text("Login", style: TextStyle(color: Colors.black87)),
                onTap: () {
                  Get.toNamed(Routes.LOGIN);
                },
              ),
              Divider(height: 1, color: Colors.grey[300]),
              ListTile(
                leading: Icon(Icons.person_add, color: Colors.black87),
                title: Text("SignUp", style: TextStyle(color: Colors.black87)),
                onTap: () {
                  Get.toNamed(Routes.SIGNUP);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAfterLogin(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 280,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SizedBox(height: 16),
              Obx(() {
                return Text(
                  authC.userName.value.isNotEmpty
                      ? authC.userName.value
                      : "Nama Pengguna",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                );
              }),
              Obx(() {
                return Text(
                  authC.emailC.value.isNotEmpty
                      ? authC.emailC.value
                      : "email@example.com",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                );
              }),
              SizedBox(height: 16),
              Divider(height: 1, color: Colors.grey[300]),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.black87),
                title: Text("Edit Profile", style: TextStyle(color: Colors.black87)),
                onTap: () {
                  Get.toNamed("/edit-profile");
                },
              ),
              Divider(height: 1, color: Colors.grey[300]),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.black87),
                title: Text("Logout", style: TextStyle(color: Colors.black87)),
                onTap: () {
                  authC.logout();
                  Get.offAllNamed(Routes.HOME);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
