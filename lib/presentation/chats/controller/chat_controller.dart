import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';

class ChatController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();

  final rxRequestStatus = Rx<Status>(Status.success);
  var getAboutDetails = [].obs;
  var getOurTeamDetails = [].obs;
  var firstName = TextEditingController();
  var pageKey = 1;
  var perPage = 10;
}
