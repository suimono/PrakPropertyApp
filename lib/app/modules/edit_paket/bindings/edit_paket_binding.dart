import 'package:get/get.dart';

import '../controllers/edit_paket_controller.dart';

class EditPaketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPaketController>(
      () => EditPaketController(),
    );
  }
}
