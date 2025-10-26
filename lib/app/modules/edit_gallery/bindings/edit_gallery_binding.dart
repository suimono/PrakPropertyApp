import 'package:get/get.dart';

import '../controllers/edit_gallery_controller.dart';

class EditGalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditGalleryController>(
      () => EditGalleryController(),
    );
  }
}
