import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../core/app_export.dart';
import '../core/constants/api_network.dart';
import '../data/apiClient/api_client.dart';
import '../data/apiClient/http_response.dart';

class ImagePickerController extends GetxController {
  static ImagePickerController get to => Get.find<ImagePickerController>();
  NetworkHttpServices api = NetworkHttpServices();

  final rxRequestStatus = Status.success.obs;

  File? result;
  String imageUrl = '';

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var res = File(image.path);
        result = res;
        imageUrl = await uploadFile(result!);

        update();
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future uploadFile(File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiNetwork.uploadFile),
      );
      request.files
          .add(await http.MultipartFile.fromPath('uploadFile', file.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        print("Checking data: $result");
        return result['downloadURL'];
      } else {
        print("Error: ${response.reasonPhrase}");
        return false;
      }
    } catch (e) {
      print("Error uploading file: $e");
      return false;
    }
  }
}
