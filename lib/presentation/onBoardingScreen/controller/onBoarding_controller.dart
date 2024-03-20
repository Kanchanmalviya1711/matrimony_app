// ignore_for_file: unnecessary_overrides
import 'dart:convert';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/widgets/image_picker.dart';
import '../../../core/app_export.dart';

class OnBoardingController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
}
