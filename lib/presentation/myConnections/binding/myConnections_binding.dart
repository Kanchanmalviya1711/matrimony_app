import 'package:get/get.dart';
import '../controller/myConnections_controller.dart';

class MyConnectionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyConnectionsController>(() => MyConnectionsController());
  }
}
