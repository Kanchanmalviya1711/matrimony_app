// ignore_for_file: unnecessary_overrides
import 'dart:convert';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/register/model/register_model.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/widgets/image_picker.dart';
import '../../../core/app_export.dart';

class NotificationsController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController userTypeController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController imagePathController = TextEditingController();
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
}
