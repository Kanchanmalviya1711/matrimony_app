import 'package:get/get.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    jumpToHome();
    super.onReady();
  }

  jumpToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(SessionManager.getToken() == null
          ? AppRoutes.loginScreen
          : AppRoutes.homeScreen);
    });
  }
}
