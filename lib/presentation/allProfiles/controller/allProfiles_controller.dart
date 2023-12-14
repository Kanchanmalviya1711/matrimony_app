import 'dart:convert';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class AllProfilesListController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  final rxRequestStatus = Rx<Status>(Status.success);
  var allProfiles;
  var firstName = TextEditingController();
  var pageKey = 1;
  var perPage = 10;

  getAllProfiles({page, perPageRecord}) async {
    print("hjhhhhhhhhhhhhhhhhh");

    try {
      var payload = {"page": "", "per_page_record": "20"};
      var value = await api.post(
          ApiNetwork.allProfilesList, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        allProfiles = value['payload']['data'];

        print("object");
        print("fgdfgfdgdfg fdg $allProfiles");

        return allProfiles;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error , $e ");
    }
  }
}
