import 'package:dio/dio.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class PlansAndPricingController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  final rxRequestStatus = Rx<Status>(Status.success);
  var slidersList = [].obs;
  var firstName = TextEditingController();
  var pageKey = 1;
  var perPage = 20;
  // Dio instance for making HTTP requests
  Dio dio = Dio();

  // API endpoint URL
  String apiUrl = ApiNetwork.testimonyList;

  Future<void> getTestimonials() async {
    print("Checking if the API is working getTestimonials");
    rxRequestStatus.value = Status.loading;

    try {
      // Make the POST request using Dio
      var value = await dio.post(
        apiUrl,
        data: {"page": pageKey, "per_page_record": perPage},
        options: Options(headers: {
          "Content-Type": "application/json",
          'Cookie': 'jwtToken=${SessionManager.getToken()}',
        }),
      );
      if (value.data['status'] == "success") {
        print("Data: ${value.data['payload']['data']}");
        slidersList.assignAll(value.data['payload']['data']);
        print("Updated slidersList: $slidersList");
        rxRequestStatus.value = Status.success;
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
