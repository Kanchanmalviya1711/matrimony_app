import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class ContactController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  final rxRequestStatus = Rx<Status>(Status.success);
  var allProfiles = [].obs;

  var firstName = TextEditingController();
  var pageKey = 1;
  var perPage = 10;

  Dio dio = Dio();

  String apiUrl = ApiNetwork.allProfilesList;

  Future<void> getAllContact() async {
    print("all profiles Checking if the API is working ");
    rxRequestStatus.value = Status.loading;
    // Prepare the request parameters
    var params = {
      "page": pageKey.toString(),
      "per_page_record": perPage.toString(),
    };
    print("$params,cheking payload");
    try {
      var value = await dio.post(
        apiUrl,
        data: jsonEncode(params),
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${SessionManager.getToken()}',
          "Cookie": 'jwtToken=${SessionManager.getToken()}',
        }),
      );

      if (value.statusCode == 403) {
        // Handle 403 status code (Forbidden)
        rxRequestStatus.value = Status.error;
        customFlutterToast(
          msg: "Access forbidden. Please check your permissions.",
          backgroundColor: Colors.red,
        );
      } else if (value.data['status'] == "success") {
        print("Data: ${value.data['payload']['data']}");
      } else {
        rxRequestStatus.value = Status.error;
        customFlutterToast(
          msg: value.data['message'],
          backgroundColor: Colors.red,
        );
      }
    } catch (error) {
      print("Error message: $error");
      rxRequestStatus.value = Status.error;
    } finally {
      // Reset status
      rxRequestStatus.value = Status.success;
    }
  }
}
