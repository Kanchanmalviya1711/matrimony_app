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
        Get.offAllNamed(AppRoutes.homeScreen);
        await SessionManager.setToken(response["payload"]["userToken"]);
        await SessionManager.setUserId(response["payload"]["id"].toString());
        customFlutterToast(
            backgroundColor: Colors.green, msg: response["message"]);
      } else {
        print("Response Null");
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
    }
  }
}
