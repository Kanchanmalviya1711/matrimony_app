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
  var reserOTP = TextEditingController().obs;
  var newPassword = TextEditingController().obs;

  Rx<bool> agreementText = false.obs;
  final rxRequestStatus = Status.success.obs;
  var isPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;
  togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
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
        rxRequestStatus.value = Status.success;
        response["payload"]["profile"] == null
            ? Get.offNamed(AppRoutes.createProfileScreen,
                arguments: [response["payload"]["profile"]])
            : Get.offNamed(AppRoutes.homeScreen);
        // Get.offNamed(AppRoutes.homeScreen);
        await SessionManager.setToken(response["payload"]["userToken"]);
        var jsonData = response["payload"]["profile"];
        await SessionManager.setUser(json.encode(jsonData));
        var jsonProfileData = response["payload"]["user"];
        await SessionManager.setUserProfileData(json.encode(jsonProfileData));
        await SessionManager.setGender(
            response["payload"]["user"]["gender"].toString());
        var userId = response["payload"]["user"]["id"];
        await SessionManager.setUserId(json.encode(userId));
        customFlutterToast(
            backgroundColor: Colors.green, msg: "Login Successfully");
      } else {
        print("Response Null");
        rxRequestStatus.value = Status.success;
      }
    } catch (e) {
      print("checking error, $e");
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
    }
  }

  resetPassword() async {
    var payload = {
      "email": emailController.value.text,
    };
    print("payload $payload");
    rxRequestStatus.value = Status.loading;
    try {
      var response = await api.post(
          ApiNetwork.resetPassword, jsonEncode(payload), true,
          isCookie: false);
      if (response['status'] == "success") {
        rxRequestStatus.value = Status.success;
        Get.offNamed(AppRoutes.verifyOtpScreen);
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

  verifyOtp() async {
    var payload = {
      "resetOtp": reserOTP.value.text,
      "password": passwordController.value.text,
      "passwordConfirm": newPassword.value.text,
    };
    print("payload $payload");
    rxRequestStatus.value = Status.loading;
    try {
      var response = await api.post(
          ApiNetwork.verifyOtp, jsonEncode(payload), true,
          isCookie: false);
      if (response['status'] == "success") {
        rxRequestStatus.value = Status.success;
        Get.offNamed(AppRoutes.loginScreen);
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
