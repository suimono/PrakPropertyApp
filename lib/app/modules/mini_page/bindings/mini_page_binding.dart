import 'package:get/get.dart';
import 'package:mobileapp/app/modules/mini_page/controllers/mini_page_controller.dart';



class MiniPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniPageController>(
      () => MiniPageController(),
    );
  }
}
