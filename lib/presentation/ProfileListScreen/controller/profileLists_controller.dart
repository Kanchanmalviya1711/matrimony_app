import 'dart:convert';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class ProfileListController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  final name = TextEditingController().obs;
  final remarks = TextEditingController().obs;
  final date = TextEditingController().obs;
  final timeIn = TextEditingController().obs;
  final timeOut = TextEditingController().obs;
  String? status;
  String? statusValue;

  clearInputField() {
    remarks.value.clear();
    statusValue = null;
    status = null;
    date.value.clear();
    timeIn.value.clear();
    timeOut.value.clear();
  }

  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );

  final rxRequestStatus = Status.success.obs;
  var usersList = [];
  var firstName = TextEditingController().obs;
  var pageKey = 1;
  var perPage = 20;

  getUsers({page, perPageRecord}) async {
    var payload = {
      "page": pageKey,
      "per_page_record": perPage,
      "gender": SessionManager.getGender() == "1" ? "2" : "1",
      "userId": json.decode(SessionManager.getUserId().toString())
    };

    try {
      var value =
          await api.post(ApiNetwork.usersList, jsonEncode(payload), true);
      if (value['status'] == "success") {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        usersList = value['payload']['data'];
        print("object");
        print("fgdfgfdgdfg fdg $usersList");
        return usersList;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
    }
  }

// Friend Request Api Call

  sendFriendRequest(String userId, String status) async {
    var payload = {
      "sender_id": {"id": json.decode(SessionManager.getUserId().toString())},
      "receiver_id": {"id": userId},
      "status": status,
    };
    print("payload $payload");
    rxRequestStatus.value = Status.loading;
    try {
      var value = await api.post(
        ApiNetwork.friendRequest,
        jsonEncode(payload),
        true,
        isCookie: true,
      );
      if (value['success'] == true) {
        rxRequestStatus.value = Status.success;
        print('Friend request sent successfully');
        customFlutterToast(
            backgroundColor: Colors.green, msg: value['message']);
      } else {
        rxRequestStatus.value = Status.error;
        print("Error , $value ");
        customFlutterToast(
          backgroundColor: Colors.black,
          msg: value['message'],
        );
      }
      // Don't navigate to home screen immediately after sending request
    } catch (e) {
      rxRequestStatus.value = Status.error;
      print("Error , $e ");
      customFlutterToast(
          backgroundColor: Colors.red, msg: "Interest request already sent");
    }
  }
}
