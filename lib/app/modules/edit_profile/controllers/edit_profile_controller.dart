
import 'package:get/get.dart';
import 'package:mobileapp/app/controllers/auth_controller.dart';

class EditProfileController extends GetxController {
  final AuthController authC = Get.find<AuthController>();
  var userName = ''.obs;
  var imagePath = ''.obs;

  get phone => null;

  get email => null; // Menyimpan URL gambar profil



  @override
  void onInit() {
    super.onInit();
    userName.value =
        authC.userName.value; // Mengambil nama pengguna dari AuthController
    imagePath.value =
        authC.imagePath.value; // Mengambil imagePath dari AuthController
  }

  // Fungsi untuk memperbarui nama pengguna
  Future<void> updateUserName(String newName) async {
    if (newName.isNotEmpty) {
      await authC.updateUserName(
          newName); // Menggunakan AuthController untuk memperbarui nama
      Get.snackbar('Update Profil', 'Nama pengguna berhasil diperbarui.');
    } else {
      Get.snackbar('Update Profil', 'Nama pengguna tidak boleh kosong.');
    }
  }

  void updateProfile({required String userName}) {}
}
