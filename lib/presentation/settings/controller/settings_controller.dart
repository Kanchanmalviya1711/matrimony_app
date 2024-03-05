// ignore_for_file: unnecessary_overrides
import 'dart:convert';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/register/model/register_model.dart';
import 'package:matrimony_app/widgets/image_picker.dart';
import '../../../core/app_export.dart';

class SettingsController extends GetxController {
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
  var allProfiles;
  Rx<bool> agreementText = false.obs;
  String? gender;
  String? genderType;
  String? subscriptionType;
  String? subscriptionTypeValue;
  String? status;
  String? statusValue;
  var pageKey = 1;
  var perPage = 10;
  togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAllNotification({page, perPageRecord}) async {
    try {
      var payload = {
        "page": "",
        "per_page_record": "20",
      };
      var value = await api.post(
          ApiNetwork.getNotificationList, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        allProfiles = value['payload']['data'];
        print("object $allProfiles");
        return allProfiles;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error , $e ");
    }
  }
}
