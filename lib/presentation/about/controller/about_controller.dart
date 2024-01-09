import 'dart:convert';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class AboutController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  final rxRequestStatus = Rx<Status>(Status.success);
  var getAboutDetails = [].obs;
  var getOurTeamDetails = [].obs;
  var firstName = TextEditingController();
  var pageKey = 1;
  var perPage = 10;

  getAbout({page, perPageRecord}) async {
    print("get about pageeee");

    try {
      var payload = {"page": "", "per_page_record": "10"};
      var value = await api.post(
          ApiNetwork.getAboutDetails, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        getAboutDetails.value = value['payload']['data'];

        print("object");
        print("fgdfgfdgdfg fdg $getAboutDetails");

        return getAboutDetails;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error About , $e ");
    }
  }

// Our Team Api
  getOurTeam({page, perPageRecord}) async {
    print("get our team pageeee");
    try {
      var payload = {"page": "", "per_page_record": "10"};
      var value = await api.post(
          ApiNetwork.getOurTeamDetails, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        getOurTeamDetails.value = value['payload']['data'];

        print("fgdfgfdgdfg fdg $getOurTeamDetails");

        return getOurTeamDetails;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error Our team , $e ");
    }
  }
}
