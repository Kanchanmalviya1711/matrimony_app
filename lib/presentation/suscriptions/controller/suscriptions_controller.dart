import 'dart:convert';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class ContactUsController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  final rxRequestStatus = Rx<Status>(Status.success);
  var getContactUsDetails = [].obs;

  var firstName = TextEditingController();
  var pageKey = 1;
  var perPage = 10;

  getContact() async {
    print("get contact pageeee");
    rxRequestStatus.value = Status.loading;
    try {
      var payload = {"page": "", "per_page_record": "10"};
      var value = await api.post(
          ApiNetwork.getContactUsDetails, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        getContactUsDetails.value = value['payload']['data'];
        rxRequestStatus.value = Status.success;
        print("object");
        print("new data fetch contact $getContactUsDetails");

        return getContactUsDetails;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error contact , $e");
    }
  }
}
