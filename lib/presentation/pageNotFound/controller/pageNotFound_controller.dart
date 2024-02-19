import 'dart:convert';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class PageNotFoundController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  final rxRequestStatus = Status.success.obs;
  var usersList = [];
  var firstName = TextEditingController().obs;
  var pageKey = 1;
  var perPage = 20;

  getServices({page, perPageRecord}) async {
    print("get blogs hjhhhhhhhhhhhhhhhhh ");
    var payload = {"page": "1", "per_page_record": perPage.toString()};
    try {
      var value = await api.post(
          ApiNetwork.getOurServices, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        usersList = value['payload']['data'];
        print("object our services");
        print("fgdfgfdgdfg fdg our services $usersList");

        return usersList;
      } else {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        usersList = value['payload']['data'];
        print("object our services");
        print("fgdfgfdgdfg fdg our services $usersList");

        return usersList;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
    }
  }
}
