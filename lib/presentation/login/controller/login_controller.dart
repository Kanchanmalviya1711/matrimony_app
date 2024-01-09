import 'dart:convert';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import '../../../core/app_export.dart';

class LoginController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  Rx<bool> agreementText = false.obs;
  final rxRequestStatus = Status.success.obs;
  var isPasswordVisible = true.obs;

  togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    super.onClose();
    emailController.value.dispose();
    passwordController.value.dispose();
  }

  login() async {
    var payload = {
      "email": emailController.value.text,
      "password": passwordController.value.text,
    };
    rxRequestStatus.value = Status.loading;
    try {
      var response =
          await api.post(ApiNetwork.login, jsonEncode(payload), true);
      if (response['status'] == "success") {
        // User logged in, check if profile is created
        // if (SessionManager.isProfileCreated()) {
        //   // Profile created, navigate to home screen
        //   Get.offNamed(AppRoutes.homeScreen);
        // } else {
        //   // Profile not created, navigate to create profile screen
        //   Get.offNamed(AppRoutes.createProfileScreen);
        // }
        Get.offNamed(AppRoutes.homeScreen);
        await SessionManager.setToken(response["payload"]["userToken"]);
        var jsonData = response["payload"]["profile"];
        await SessionManager.setUser(json.encode(jsonData));
        await SessionManager.setGender(
            response["payload"]["user"]["gender"].toString());
        var userId = response["payload"]["user"]["id"];
        await SessionManager.setUserId(json.encode(userId));
        customFlutterToast(
            backgroundColor: Colors.green, msg: response["message"]);
      } else {
        print("Response Null");
      }
    } catch (e) {
      print("checking error, $e");
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
    }
  }
}
