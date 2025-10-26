import 'package:get/get.dart';
import '../controllers/experiment_controller.dart';

class ExperimentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExperimentController>(() => ExperimentController());
  }
}
