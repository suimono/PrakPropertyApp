import 'package:get/get.dart';
import 'package:mobileapp/app/modules/medium_page/controllers/medium_page_controller.dart';


class MediumPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MediumPageController>(
      () => MediumPageController(),
    );
  }
}
