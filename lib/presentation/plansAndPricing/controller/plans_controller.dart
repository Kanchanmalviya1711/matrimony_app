import 'dart:convert';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class PlansAndPricingController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  final rxRequestStatus = Rx<Status>(Status.success);
  var allPlans = [].obs;
  var getAppSettingsDetails = [].obs;
  var pageKey = 1;
  var perPage = 10;

  getPlansAndPricing({page, perPageRecord}) async {
    print("object getPlansAndPricing");
    try {
      var payload = {
        "page": pageKey.toString(),
        "per_page_record": perPage.toString(),
      };
      var value = await api.post(
          ApiNetwork.plansAndPricing, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        allPlans.value = value['payload']['data'];
        print("object");
        print("fgdfgfdgdfg fdg $allPlans");
        return allPlans;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error message, $e");
    }
  }
}
