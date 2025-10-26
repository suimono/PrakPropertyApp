import 'package:get/get.dart';
import 'package:mobileapp/app/modules/profil/controllers/profil_controller.dart';


class ProfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilController>(
      () => ProfilController(),
    );
  }
}
