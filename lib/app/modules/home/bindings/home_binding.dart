// File: home_binding.dart

import 'package:get/get.dart';
import 'package:mobileapp/app/modules/Login/controllers/login_controller.dart';
import 'package:mobileapp/app/modules/SignUp/controllers/signup_controller.dart';
import 'package:mobileapp/app/modules/pemesanan/controllers/pemesanan_controller.dart';
// 💡 Tambahkan import untuk GalleryController
import 'package:mobileapp/app/modules/Gallery/controllers/gallery_controller.dart'; 
// 💡 Tambahkan import untuk PaketController (asumsi lokasinya)
import 'package:mobileapp/app/services/paket_controller.dart'; 

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Controller utama untuk HomeView
    Get.lazyPut<HomeController>(() => HomeController());
    
    // 🔑 TAMBAHKAN: GalleryController 
    // Menggunakan Get.put() agar langsung tersedia saat binding ini dibuat
    Get.put(GalleryController()); 

    // 🔑 TAMBAHKAN: PaketController (Anda juga menggunakannya dengan Get.find() di HomeView)
    Get.put(PaketController());
    
    // Controller lain yang sudah ada
    Get.put(LoginController());
    Get.put(SignUpController());
    Get.put(PemesananController());
  }
}