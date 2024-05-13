import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/routes/app_routes.dart';

class FriendRequestController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  final rxRequestStatus = Rx<Status>(Status.success);
  var allRequestList;
  var pageKey = 1;
  var perPage = 10;

  getRequestList({page, perPageRecord}) async {
    print("object Friend Request");
    try {
      var payload = {
        "page": pageKey.toString(),
        "per_page_record": perPage.toString(),
        "userIdForFriendRequestReceived":
            json.decode(SessionManager.getUserId().toString())
      };
      var value = await api.post(
          ApiNetwork.getFriendRequest, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        allRequestList = value['payload']['data'];
        print("object");
        return allRequestList;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error message, $e ");
    }
  }

  acceptRequest(String id, String userId) async {
    print("object Friend Request, $id, $userId");
    var receiverId = await jsonDecode(SessionManager.getUserId().toString());
    try {
      var payload = {
        "sender_id": {"id": id},
        "receiver_id": {"id": receiverId},
        "status": 1 //accepted
      };
      if (kDebugMode) {
        print("object $payload");
      }
      var value = await api.put(
          ApiNetwork.acceptFriendRequest + userId, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        rxRequestStatus.value = Status.success;
        Get.offAndToNamed(AppRoutes.homeScreen);
        customFlutterToast(
          backgroundColor: Colors.green,
          msg: (payload['firstName'] != null && payload['lastName'] != null)
              ? '${payload['firstName']} ${payload['lastName']} added to your friend list'
              : 'Request Accepted',
        );
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        allRequestList = value['payload']['data'];
        print("object");
        return allRequestList;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error message, $e ");
    }
  }

  rejectRequest(String id, String userId) async {
    print("object Friend Request, $id, $userId");
    var receiverId = await jsonDecode(SessionManager.getUserId().toString());
    try {
      var payload = {
        "sender_id": {"id": id},
        "receiver_id": {"id": receiverId},
        "status": 3 //rejected
      };
      print("object $payload");
      var value = await api.put(
          ApiNetwork.acceptFriendRequest + userId, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        rxRequestStatus.value = Status.success;
        allRequestList = value['payload'];
        customFlutterToast(
            backgroundColor: Colors.red, msg: "Request Rejected");
        Get.offAllNamed(AppRoutes.homeScreen);
        return allRequestList;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error message, $e ");
    }
  }
}
