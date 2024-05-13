import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class HomepageController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  final rxRequestStatus = Rx<Status>(Status.success);
  var slidersList = [].obs;
  var menusList = [].obs;
  var getAppSettingsDetails = [].obs;
  var firstName = TextEditingController();
  var pageKey = 1;
  var perPage = 20;
  // Dio instance for making HTTP requests
  Dio dio = Dio();

  // API endpoint URL Sliders
  String apiUrl = ApiNetwork.slidersList;

  Future<void> getSliders() async {
    // print("Checking if the API is working slider");
    rxRequestStatus.value = Status.loading;
    try {
      // Make the POST request using Dio
      var value = await dio.post(
        apiUrl,
        data: {"page": pageKey, "per_page_record": perPage},
        options: Options(headers: {
          "Content-Type": "application/json",
          'Cookie': 'jwtToken=${SessionManager.getToken()}',
        }),
      );
      if (value.data['status'] == "success") {
        // print("Data: ${value.data['payload']['data']}");
        slidersList.assignAll(value.data['payload']['data']);
        // print("Updated slidersList: $slidersList");
        rxRequestStatus.value = Status.success;
      } else {
        rxRequestStatus.value = Status.error;
        customFlutterToast(
          msg: value.data['message'],
          backgroundColor: Colors.red,
        );
      }
    } catch (error) {
      //print("Error message: $error");
      rxRequestStatus.value = Status.error;
    } finally {
      // Reset status
      rxRequestStatus.value = Status.success;
    }
  }

// -------------------------------------------------------------------------

// Menus Items api calling
// API endpoint URL Menus
  String apiMenuUrl = ApiNetwork.menusList;

  Future<void> getMenus() async {
    // print("Checking if the API is working Menus");
    rxRequestStatus.value = Status.loading;
    try {
      // Make the POST request using Dio
      var value = await dio.post(
        apiMenuUrl,
        data: {
          // "id": "15",
          // "name": "about",
          "page": pageKey,
          "per_page_record": perPage
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          'Cookie': 'jwtToken=${SessionManager.getToken()}',
        }),
      );
      if (value.data['status'] == "success") {
        // print("Data: ${value.data['payload']['data']}");
        menusList.assignAll(value.data['payload']['data']);
        // print("Updated Menus: $slidersList");
        rxRequestStatus.value = Status.success;
      } else {
        rxRequestStatus.value = Status.error;
        customFlutterToast(
          msg: value.data['message'],
          backgroundColor: Colors.red,
        );
      }
    } catch (error) {
      //print("Error message: $error");
      rxRequestStatus.value = Status.error;
    } finally {
      // Reset status
      rxRequestStatus.value = Status.success;
    }
  }

  //AppSettings Api Calling

  getAppSettings({page, perPageRecord}) async {
    //print("get about pageeee");
    try {
      var payload = {"page": "1", "per_page_record": "10"};
      var value = await api.post(
          ApiNetwork.getAppSettings, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        //   print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        getAppSettingsDetails.value = value['payload']['data'];
        // print("object");
        //  print("fgdfgfdgdfg fdg $getAppSettingsDetails");
        return getAppSettingsDetails;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      //   print("Error Appsettings , $e ");
    }
  }
}
