import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/ui/profileLists_screen.dart';
import 'package:matrimony_app/presentation/home/homepage/homepage.dart';
import 'package:matrimony_app/core/app_export.dart';

class HomeController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  final count = 0.obs;
  Rx<bool> agreementText = false.obs;
  final rxRequestStatus = Status.success.obs;

  final pagesList = [
    const HomePage(),
    const ProfileListsScreen(),
  ];

  getProfileDetails(profileId) async {
    // print("profileId $profileId");
    // rxRequestStatus.value = Status.loading;
    // try {
    //   var response = await api.get(ApiNetwork.getProfile);
    //   if (response['status'] == "success") {
    //     customFlutterToast(
    //         backgroundColor: Colors.green, msg: response["message"]);
    //   } else {
    //     print("Response Null");
    //   }
    // } catch (e) {
    //   print("checking error, $e");
    //   customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
    //   rxRequestStatus.value = Status.error;
    // }
  }
}
