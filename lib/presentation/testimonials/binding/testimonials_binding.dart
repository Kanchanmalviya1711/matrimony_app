import 'package:get/get.dart';
import '../controller/testimonials_controller.dart';

class TestimonialsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestimonialsController>(() => TestimonialsController());
  }
}
