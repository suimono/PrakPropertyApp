import 'package:get/get.dart';

import '../controllers/admin_gallery_controller.dart';

class AdminGalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminGalleryController>(
      () => AdminGalleryController(),
    );
  }
}
