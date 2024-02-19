import 'package:get/get.dart';
import '../controller/plans_controller.dart';

class PlansAndPricingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlansAndPricingController>(() => PlansAndPricingController());
  }
}
