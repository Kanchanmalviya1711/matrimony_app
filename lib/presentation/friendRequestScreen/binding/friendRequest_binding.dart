import 'package:get/get.dart';
import '../controller/friendRequest_controller.dart';

class FriendRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendRequestController>(() => FriendRequestController());
  }
}
