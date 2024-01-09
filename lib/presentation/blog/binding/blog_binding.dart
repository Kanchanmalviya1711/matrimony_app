import 'package:get/get.dart';
import '../controller/blog_controller.dart';

class BlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogController>(() => BlogController());
  }
}
