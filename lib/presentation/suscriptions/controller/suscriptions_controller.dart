import 'dart:convert';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class SuscriptionsController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  final rxRequestStatus = Rx<Status>(Status.success);
  var getSuscriptionsDetails = [].obs;
  var pageKey = 1;
  var perPage = 10;

  getSuscriptions() async {
    print("get suscription pageeee");
    rxRequestStatus.value = Status.loading;
    try {
      var payload = {"page": pageKey, "per_page_record": perPage};
      var value = await api.post(
          ApiNetwork.plansAndPricing, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        getSuscriptionsDetails.value = value['payload']['data'];
        rxRequestStatus.value = Status.success;
        print("object");
        print("new data fetch suscriptions $getSuscriptionsDetails");
        return getSuscriptionsDetails;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error suscriptions , $e");
    }
  }
}
