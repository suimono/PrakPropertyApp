import 'package:get/get.dart';

class ProfilController extends GetxController {
  // Pastikan variabel ini di-observe dengan .obs
  Rx<String> username = ''.obs;
  Rx<String> email = ''.obs;
  Rx<String> phoneNumber = ''.obs;
  RxBool isLoggedIn = false.obs;
}
