import 'package:get/get.dart';
import '../controller/sliders_controller.dart';

class SlidersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SlidersController>(() => SlidersController());
  }
}
