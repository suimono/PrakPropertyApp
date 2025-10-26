import 'package:get/get.dart';

import '../controllers/admin_paket_controller.dart';

class AdminPaketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPaketController>(
      () => AdminPaketController(),
    );
  }
}
