import 'package:get/get.dart';
import '../controller/pageNotFound_controller.dart';

class PageNotFoundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PageNotFoundController>(() => PageNotFoundController());
  }
}
