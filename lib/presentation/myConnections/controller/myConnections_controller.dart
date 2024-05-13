import 'dart:convert';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/routes/app_routes.dart';

class MyConnectionsController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  final rxRequestStatus = Rx<Status>(Status.success);
  var allConnectionsList; // allConnectionsList
  var firstName = TextEditingController();
  var allRequestList;
  var pageKey = 1;
  var perPage = 10;

  getConnectionsList({page, perPageRecord}) async {
    print("get blogs hjhhhhhhhhhhhhhhhhh");
    try {
      var payload = {"page": pageKey, "per_page_record": perPage};
      print("payload $payload");
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

  removeRequest(String senderId, String removeId, String receiverId) async {
    print("object Friend Request, $senderId, $removeId, $receiverId");

    try {
      var payload = {
        "sender_id": {"id": removeId}, //71
        "receiver_id": {"id": receiverId}, //70
        "status": 3 //rejected
      };
      print("object $payload");
      var value = await api.put(ApiNetwork.acceptFriendRequest + senderId,
          jsonEncode(payload), true, //61
          isCookie: true);
      if (value['status'] == "success") {
        rxRequestStatus.value = Status.success;
        allRequestList = value['payload'];
        customFlutterToast(
            backgroundColor: Colors.red, msg: "Connection Removed");
        Get.offAllNamed(AppRoutes.homeScreen);
        print("$value, value print");
        return allRequestList;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error message, $e ");
    }
  }
}
