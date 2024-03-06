import 'dart:convert';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class MyConnectionsController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  final rxRequestStatus = Rx<Status>(Status.success);
  var allConnectionsList; // allConnectionsList
  var firstName = TextEditingController();
  var pageKey = 1;
  var perPage = 10;

  getConnectionsList({page, perPageRecord}) async {
    print("get blogs hjhhhhhhhhhhhhhhhhh");

    try {
      var payload = {
        "userId": json.decode(SessionManager.getMyConnections().toString()),
        "status": "1", //accepted
        "page": pageKey.toString(),
        "per_page_record": perPage.toString()
      };
      var value = await api.post(
          ApiNetwork.connectionList, jsonEncode(payload), true,
          isCookie: true);

      print("get blogs ${value['payload']['data']}");
      allConnectionsList = value['payload']['data'];
      print("object");
      print("fgdfgfdgdfg fdg $allConnectionsList");
      return allConnectionsList;

      // if (value['status'] == "success") {
      //   print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
      //   allBlogs = value['payload']['data'];
      //   print("object");
      //   print("fgdfgfdgdfg fdg $allBlogs");
      //   return allBlogs;
      // }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error , $e ");
    }
  }
}
