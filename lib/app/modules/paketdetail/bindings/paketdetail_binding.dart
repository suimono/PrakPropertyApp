import 'package:get/get.dart';

import '../controllers/paketdetail_controller.dart';

class PaketdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaketdetailController>(
      () => PaketdetailController(),
    );
  }
}
