import 'dart:convert';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
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
  var attendanceList = [];
  var firstName = TextEditingController().obs;
  var pageKey = 1;
  var perPage = 20;

  getUsers({page, perPageRecord}) async {
    var payload = {"page": pageKey, "per_page_record": perPage};

    try {
      var value =
          await api.post(ApiNetwork.usersList, jsonEncode(payload), true);
      if (value['status'] == "success") {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        attendanceList = value['payload']['data'];
        print("object");
        print("fgdfgfdgdfg fdg $attendanceList");

        return attendanceList;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
    }
  }
}
