import 'package:get/get.dart';

import '../controllers/large_page_controller.dart';

class LargePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LargePageController>(
      () => LargePageController(),
    );
  }
}
