import 'dart:convert';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class SlidersController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  final rxRequestStatus = Rx<Status>(Status.success);
  var allBlogs;
  var firstName = TextEditingController();
  var pageKey = 1;
  var perPage = 10;

  getBlogs({page, perPageRecord}) async {
    print("get blogs hjhhhhhhhhhhhhhhhhh");

    try {
      var payload = {
        "page": pageKey.toString(),
        "per_page_record": perPage.toString()
      };
      var value = await api.post(
          ApiNetwork.blogsList, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        allBlogs = value['payload']['data'];

        print("object");
        print("fgdfgfdgdfg fdg $allBlogs");

        return allBlogs;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error , $e ");
    }
  }
}
