// ignore_for_file: unnecessary_overrides
import 'dart:convert';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/custom_widget/time_formate_method.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/register/model/register_model.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/widgets/image_picker.dart';
import '../../../core/app_export.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final userTypeController = TextEditingController().obs;
  final userNameController = TextEditingController().obs;
  final imagePathController = TextEditingController().obs;
  final dateOfBirth = TextEditingController().obs;
  final rxRequestStatus = Status.success.obs;
  var isPasswordVisible = true.obs;
  final usersList = RegisterModel().obs;
  final isEdit = true.obs;

  Rx<bool> agreementText = false.obs;
  String? gender;
  String? genderType;
  String? subscriptionType;
  String? subscriptionTypeValue;
  String? status;
  String? statusValue;
  togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    super.onClose();
  }

  clearInputField() {
    firstNameController.value.clear();
    lastNameController.value.clear();
    emailController.value.clear();
    phoneController.value.clear();
    passwordController.value.clear();
    addressController.value.clear();
    userTypeController.value.clear();
    userNameController.value.clear();
    imagePathController.value.clear();
    dateOfBirth.value.clear();
    statusValue = null;
    status = null;
    gender = null;
    genderType = null;
    subscriptionType = null;
    subscriptionTypeValue = null;
  }

  register(String imageUrl) async {
    rxRequestStatus.value = Status.loading;
    var payload = {
      "firstName": firstNameController.value.text,
      "lastName": lastNameController.value.text,
      "emailAddress": emailController.value.text,
      "password": passwordController.value.text,
      "userType": userTypeController.value.text,
      "username": userNameController.value.text,
      "phone": phoneController.value.text,
      "address": addressController.value.text,
      "imagePath": imageUrl,
      "gender": gender.toString(),
      "role": {"id": "1"},
      "subscriptionType": subscriptionType.toString(),
      "dateOfBirth": dateOfBirth.value.text,
      "status": status.toString()
    };
    print("$payload, checking payload data");
    try {
      var response =
          await api.post(ApiNetwork.addUser, jsonEncode(payload), true);
      if (response['status'] == "success") {
        rxRequestStatus.value = Status.success;
        Get.offAllNamed(AppRoutes.loginScreen);
        customFlutterToast(
            backgroundColor: Colors.green, msg: "User Registered Successfully");
      } else {
        print("Response Null");
      }
    } catch (e) {
      customFlutterToast(
          backgroundColor: Colors.red, msg: "Please Fill The Form");
      rxRequestStatus.value = Status.error;
    }
  }

  //UPDATE USER DETAILS/REGISTER USER EDIT

  // GET USER DETAILS
  updateUserDetails(String imageUrl, String id) async {
    print("hjhhhhhhhhhhhhhhhhhsafsdgdg xvcb xgvcvb xvcb,$id");
    var dateOfMarriageFormatted;

    if (dateOfBirth.value.text != "") {
      dateOfMarriageFormatted = TimeFormateMethod().getTimeFormate(
          formate: "yyyy-MM-ddTHH:mm:ss.SSSSSSZ+0000",
          time: dateOfBirth.value.text);
    } else {
      dateOfMarriageFormatted = null;
    }
    rxRequestStatus.value = Status.loading;
    print("hjhhhhhhhhhhhhhhhhh,$id");

    var url = Uri.parse(ApiNetwork.updateUserDetails + id);
    var body = {
      "firstName": firstNameController.value.text,
      "lastName": lastNameController.value.text,
      "emailAddress": emailController.value.text,
      "password": passwordController.value.text,
      "userType": userTypeController.value.text,
      "username": userNameController.value.text,
      "phone": phoneController.value.text,
      "address": addressController.value.text,
      "imagePath": imageUrl,
      "resetOtp": null,
      "gender": gender.toString(),
      "role": {"id": "1"},
      "subscriptionType": subscriptionType.toString(),
      "dateOfBirth": dateOfMarriageFormatted,
      "status": status.toString()
    };

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      'Authorization': 'Bearer ${SessionManager.getToken()}',
      "Cookie": "jwtToken=${SessionManager.getToken()}",
    };

    print("Payload: $body");

    try {
      var value = await http.put(
        url,
        body: jsonEncode(body),
        headers: headers,
      );

      print("Response Status Code: ${value.statusCode}");

      if (value.statusCode == 200) {
        var response = json.decode(value.body);
        print("Payload: $response");

        rxRequestStatus.value = Status.success;
        // var jsonData = response["payload"];
        // await SessionManager.setUser(json.encode(jsonData));
        Get.offAndToNamed(AppRoutes.profileScreen);
        customFlutterToast(msg: "User Updated Successfully");
      } else {
        var response = json.decode(value.body);
        print("Error: ${response['message']}");

        rxRequestStatus.value = Status.error;
        customFlutterToast(
            backgroundColor: Colors.red, msg: "${response['message']}");
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      print("Error: $e");
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
    }
  }
}
