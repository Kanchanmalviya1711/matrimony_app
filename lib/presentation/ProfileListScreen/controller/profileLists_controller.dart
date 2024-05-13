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

  String? status;
  String? statusValue;

  clearInputField() {
    name.value.clear();
    statusValue = null;
    status = null;
  }

  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  final rxRequestStatus = Status.success.obs;
  var usersLists = [];
  var pageKey = 1;
  var perPage = 20;

  getUsers({int? page, int? perPageRecord, String? searchTerm}) async {
    print(searchTerm);
    var payload = {
      "fullName": searchTerm,
      "gender": SessionManager.getInterestedGender() == "3"
          ? null
          : SessionManager.getInterestedGender(),
      "page": page ?? 1,
      "per_page_record": perPageRecord ?? 10
    };
    print('payload $payload');
    try {
      var value = await api.post(
          ApiNetwork.usersList, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        var usersLists = value['payload']['data'];
        print("usersLists, $usersLists");

        print(SessionManager.getUserId());
        // If user id exist in the list then remove it from the list
        usersLists.removeWhere((element) =>
            element["id"].toString() == SessionManager.getUserId().toString());
        return usersLists;
      } else {
        customFlutterToast(
            backgroundColor: Colors.red, msg: "Failed to fetch users");
        rxRequestStatus.value = Status.error;
        return [];
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print(" the error display,$e");
      return [];
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
            backgroundColor: Colors.green,
            msg: "Friend request sent successfully");
      } else {
        rxRequestStatus.value = Status.error;
        print("Error , $value ");
        customFlutterToast(
            backgroundColor: Colors.green,
            msg: "Friend request sent successfully");
      }
      // Don't navigate to home screen immediately after sending request
    } catch (e) {
      rxRequestStatus.value = Status.error;
      print("Error , $e ");
      customFlutterToast(
          backgroundColor: Colors.red, msg: "Interest request already sent");
    }
  }

  void reset() {}
}
