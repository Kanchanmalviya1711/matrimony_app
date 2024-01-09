import 'package:get/get.dart';

import '../controller/ourServices_controller.dart';

class OurServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OurServicesController>(() => OurServicesController());
  }
}
