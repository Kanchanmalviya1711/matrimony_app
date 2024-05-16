import 'dart:convert';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/utils/fcmHandler.dart';
import '../../../core/app_export.dart';

class LoginController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var reserOTP = TextEditingController().obs;
  var newPassword = TextEditingController().obs;
  // forgot password email controller
  var forgotEmailController = TextEditingController().obs;

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

  clearFields() {
    // login credentials
    emailController.value.clear();
    passwordController.value.clear();
    // reset password
    forgotEmailController.value.clear();
  }

  login() async {
    var payload = {
      "fcmToken":
          "cfOEg74WQQqQ2RggJ-_-xt:APA91bF2fEpCFsRugqQx0_68U7ctBabF7eEGtdoJRARCaLmmBikTRR0x05ewkcyq5KM_O5KGN8TsueNhmiwuMQmfj4T9AfWHHK9eIlcsgHqukKnD0CEhkrv9i_oSAgndn2hddNRAX88t",
      "email": emailController.value.text,
      "password": passwordController.value.text,
    };
    print("Login Payload : $payload");
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
        await SessionManager.setToken(response["payload"]["userToken"]);
        var jsonData = response["payload"]["user"];
        await SessionManager.setUser(json.encode(jsonData));
        var jsonProfileData = response["payload"]["profile"];
        await SessionManager.setLoginUserProfileData(
            json.encode(jsonProfileData));
        print("sfglogin json data, $jsonProfileData");
        // Registered Gender
        await SessionManager.setGender(
            response["payload"]["user"]["gender"].toString());
        // interested Gender
        await SessionManager.setInterestedGender(
            response["payload"]["user"]["genderIntrest"].toString());
        var userId = response["payload"]["user"]["id"];
        await SessionManager.setUserId(json.encode(userId));
        customFlutterToast(
            backgroundColor: Colors.green, msg: "Login Successfully");
        clearFields();
      } else {
        print("Response Null");
        customFlutterToast(
            backgroundColor: Colors.red,
            msg: "Login Failed Invalid Credential or User Not Found");
        rxRequestStatus.value = Status.error;
        clearFields();
      }
      rxRequestStatus.value = Status.error;
    } catch (e) {
      print("checking error login credentials, $e");
      customFlutterToast(
          backgroundColor: Colors.red, msg: "Login Failed Invalid Credential");
      rxRequestStatus.value = Status.error;
    }
  }

  resetPassword() async {
    var payload = {
      "email": forgotEmailController.value.text,
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
      clearFields();
    } catch (e) {
      print("checking error, $e");
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      clearFields();
    }
  }
}
