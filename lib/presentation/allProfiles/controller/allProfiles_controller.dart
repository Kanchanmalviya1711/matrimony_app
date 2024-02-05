import 'dart:convert';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/custom_widget/time_formate_method.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/register/model/register_model.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:http/http.dart' as http;

class AllProfilesListController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  final numberOfChildrenController = TextEditingController().obs;
  final weightController = TextEditingController().obs;
  final heightController = TextEditingController().obs;
  final bodyTypeController = TextEditingController().obs;
  final complexionController = TextEditingController().obs;
  final religionController = TextEditingController().obs;
  final specialCasesController = TextEditingController().obs;
  final motherTongueController = TextEditingController().obs;
  final casteController = TextEditingController().obs;
  final subCasteController = TextEditingController().obs;
  final manglikController = TextEditingController().obs;
  final familyValuesController = TextEditingController().obs;
  final educationController = TextEditingController().obs;
  final professionController = TextEditingController().obs;
  final dieatryHabitsController = TextEditingController().obs;
  final aboutYourselfController = TextEditingController().obs;
  final bloodGroupController = TextEditingController().obs;
  final annualIncomeController = TextEditingController().obs;
  final companyName = TextEditingController().obs;
  final numberOfBrothersController = TextEditingController().obs;
  final numberOfSistersController = TextEditingController().obs;
  final contactPersonNameController = TextEditingController().obs;
  final contactPersonPhoneNumber = TextEditingController().obs;
  final relationshipController = TextEditingController().obs;
  final timeToCallController = TextEditingController().obs;
  final placeOfBirthController = TextEditingController().obs;
  final hobbiesController = TextEditingController().obs;
  final interestsController = TextEditingController().obs;
  final favoriteReadsController = TextEditingController().obs;
  final preferredMoviesController = TextEditingController().obs;
  final sportsController = TextEditingController().obs;
  final favoriteCuisineController = TextEditingController().obs;
  final spokenLanguagesController = TextEditingController().obs;
  final moonSignController = TextEditingController().obs;
  final nakshatraController = TextEditingController().obs;
  final astroprofileController = TextEditingController().obs;
  final motherNameController = TextEditingController().obs;
  final facebookLinkController = TextEditingController().obs;
  final fatherNameController = TextEditingController().obs;
  final linkedinUrlController = TextEditingController().obs;
  final watsappNumberController = TextEditingController().obs;
  final nickNameController = TextEditingController().obs;
  final dateOfMarriage = TextEditingController().obs;
  var allProfiles;
  String? haveChildren;
  String? haveChildrenValue;
  String? meritalStatus;
  String? meritalStatusValue;
  final rxRequestStatus = Rx<Status>(Status.success);
  var firstName = TextEditingController();
  var pageKey = 1;
  var perPage = 10;
  final usersList = RegisterModel().obs;
  final usersList2 = RegisterModel().obs;
  final usersList3 = RegisterModel().obs;
  final timeOfBirth = TextEditingController().obs;

  clearInputField() {
    numberOfChildrenController.value.clear();
    weightController.value.clear();
    heightController.value.clear();
    bodyTypeController.value.clear();
    complexionController.value.clear();
    religionController.value.clear();
    specialCasesController.value.clear();
    motherTongueController.value.clear();
    casteController.value.clear();
    subCasteController.value.clear();
    manglikController.value.clear();
    familyValuesController.value.clear();
    educationController.value.clear();
    professionController.value.clear();
    dieatryHabitsController.value.clear();
    aboutYourselfController.value.clear();
    bloodGroupController.value.clear();
    annualIncomeController.value.clear();
    companyName.value.clear();
    numberOfBrothersController.value.clear();
    numberOfSistersController.value.clear();
    contactPersonNameController.value.clear();
    contactPersonPhoneNumber.value.clear();
    relationshipController.value.clear();
    timeToCallController.value.clear();
    placeOfBirthController.value.clear();
    hobbiesController.value.clear();
    interestsController.value.clear();
    favoriteReadsController.value.clear();
    preferredMoviesController.value.clear();
    sportsController.value.clear();
    favoriteCuisineController.value.clear();
    spokenLanguagesController.value.clear();
    moonSignController.value.clear();
    nakshatraController.value.clear();
    astroprofileController.value.clear();
    motherNameController.value.clear();
    facebookLinkController.value.clear();
    fatherNameController.value.clear();
    linkedinUrlController.value.clear();
    watsappNumberController.value.clear();
    dateOfMarriage.value.clear();
    nickNameController.value.clear();
    timeOfBirth.value.clear();
    haveChildrenValue = null;
    haveChildren = null;
    meritalStatus = null;
    meritalStatusValue = null;
  }

  getAllProfiles({page, perPageRecord, searchTerm}) async {
    try {
      var payload = {
        "page": "",
        "per_page_record": "20",
        "caste": casteController.value.text
      };
      var value = await api.post(
          ApiNetwork.allProfilesList, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        allProfiles = value['payload']['data'];
        print("object $allProfiles");
        return allProfiles;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error , $e ");
    }
  }

  createProfile(String imageUrl1, String imageUrl2, String imageUrl3) async {
    var userId = await jsonDecode(SessionManager.getUserId().toString());

    var dateOfMarriageFormatted;

    if (dateOfMarriage.value.text != "") {
      dateOfMarriageFormatted = TimeFormateMethod().getTimeFormate(
          formate: "yyyy-MM-ddTHH:mm:ss.SSSSSSZ+0000",
          time: dateOfMarriage.value.text);
    }
    var timeOfBirthFormatted;
    if (timeOfBirth.value.text != "") {
      timeOfBirthFormatted = TimeFormateMethod()
          .getTimeFormate(formate: "HH:mm", time: timeOfBirth.value.text);
    }
    var payload = {
      "createdBy": "1",
      "maritalStatus": meritalStatus.toString(),
      "haveChildren": haveChildren.toString(),
      "numberOfChildren": numberOfChildrenController.value.text,
      "weight": weightController.value.text,
      "height": heightController.value.text,
      "bodyType": bodyTypeController.value.text,
      "complexion": complexionController.value.text,
      "religion": religionController.value.text,
      "specialCases": specialCasesController.value.text,
      "motherTongue": motherTongueController.value.text,
      "caste": casteController.value.text,
      "subCaste": subCasteController.value.text,
      "manglik": manglikController.value.text,
      "familyValues": familyValuesController.value.text,
      "education": educationController.value.text,
      "profession": professionController.value.text,
      "diet": dieatryHabitsController.value.text,
      "aboutYourself": aboutYourselfController.value.text,
      "dateOfMarriage": dateOfMarriageFormatted,
      "bloodGroup": bloodGroupController.value.text,
      "annualIncome": annualIncomeController.value.text,
      "companyName": companyName.value.text,
      "numberOfBrother": numberOfBrothersController.value.text,
      "numberOfSister": numberOfSistersController.value.text,
      "contactPersonNumber": contactPersonPhoneNumber.value.text,
      "contactPersonName": contactPersonNameController.value.text,
      "contactPersonRelationShip": relationshipController.value.text,
      "convenientCallTime": timeToCallController.value.text,
      "placeOfBirth": placeOfBirthController.value.text,
      "timeOFBirth": timeOfBirthFormatted,
      "nickName": nickNameController.value.text,
      "hobbies": hobbiesController.value.text,
      "interests": interestsController.value.text,
      "favoriteReads": favoriteReadsController.value.text,
      "preferredMovies": preferredMoviesController.value.text,
      "sports": sportsController.value.text,
      "favoriteCuisine": favoriteCuisineController.value.text,
      "spokenLanguages": spokenLanguagesController.value.text,
      "rasi": moonSignController.value.text,
      "nakshatra": nakshatraController.value.text,
      "astroprofile": astroprofileController.value.text,
      "photo1": imageUrl1,
      "photo2": imageUrl2,
      "photo3": imageUrl3,
      "motherName": motherNameController.value.text,
      "fatherName": fatherNameController.value.text,
      "facebookUrl": facebookLinkController.value.text,
      "linkedinUrl": linkedinUrlController.value.text,
      "whatsappUrl": watsappNumberController.value.text,
      "user": {"id": userId}
    };
    print("payload $payload");
    rxRequestStatus.value = Status.loading;
    try {
      var value = await api.post(
          ApiNetwork.createProfile, jsonEncode(payload), true,
          isCookie: true);
      if (value['success'] == true) {
        rxRequestStatus.value = Status.success;
        Get.offNamed(AppRoutes.homeScreen);
        customFlutterToast(msg: value['message']);
      } else {
        rxRequestStatus.value = Status.error;
        print("Error , $value ");
        customFlutterToast(
            backgroundColor: Colors.green, msg: value['message']);
      }
      Get.offNamed(AppRoutes.homeScreen);
    } catch (e) {
      rxRequestStatus.value = Status.error;
      print("Error , $e ");
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
    }
  }

  updateProfile(
      String imageUrl1, String imageUrl2, String imageUrl3, String id) async {
    print("hjhhhhhhhhhhhhhhhhh");
    var userId = await jsonDecode(SessionManager.getUserId().toString());

    var dateOfMarriageFormatted;

    if (dateOfMarriage.value.text != "") {
      dateOfMarriageFormatted = TimeFormateMethod().getTimeFormate(
          formate: "yyyy-MM-ddTHH:mm:ss.SSSSSSZ+0000",
          time: dateOfMarriage.value.text);
    }
    var timeOfBirthFormatted;

    if (timeOfBirth.value.text != "") {
      timeOfBirthFormatted = TimeFormateMethod()
          .getTimeFormate(formate: "HH:mm", time: timeOfBirth.value.text);
    }
    print("zhdxjfghdsjfgfjx $id");
    print("zhdxjfghdsjfgfjx $userId");
    var url = Uri.parse(ApiNetwork.updateProfile + id);
    var value = await http.put(
      url,
      body: jsonEncode({
        "createdBy": "1",
        "maritalStatus": meritalStatus.toString(),
        "haveChildren": haveChildren.toString(),
        "numberOfChildren": numberOfChildrenController.value.text,
        "weight": weightController.value.text,
        "height": heightController.value.text,
        "bodyType": bodyTypeController.value.text,
        "complexion": complexionController.value.text,
        "religion": religionController.value.text,
        "specialCases": specialCasesController.value.text,
        "motherTongue": motherTongueController.value.text,
        "caste": casteController.value.text,
        "subCaste": subCasteController.value.text,
        "manglik": manglikController.value.text,
        "familyValues": familyValuesController.value.text,
        "education": educationController.value.text,
        "profession": professionController.value.text,
        "diet": dieatryHabitsController.value.text,
        "aboutYourself": aboutYourselfController.value.text,
        "dateOfMarriage": dateOfMarriageFormatted,
        "bloodGroup": bloodGroupController.value.text,
        "annualIncome": annualIncomeController.value.text,
        "companyName": companyName.value.text,
        "nickName": nickNameController.value.text,
        "numberOfBrother": numberOfBrothersController.value.text,
        "numberOfSister": numberOfSistersController.value.text,
        "contactPersonNumber": contactPersonPhoneNumber.value.text,
        "contactPersonName": contactPersonNameController.value.text,
        "contactPersonRelationShip": relationshipController.value.text,
        "convenientCallTime": timeToCallController.value.text,
        "placeOfBirth": placeOfBirthController.value.text,
        "timeOFBirth": timeOfBirthFormatted,
        "hobbies": hobbiesController.value.text,
        "interests": interestsController.value.text,
        "favoriteReads": favoriteReadsController.value.text,
        "preferredMovies": preferredMoviesController.value.text,
        "sports": sportsController.value.text,
        "favoriteCuisine": favoriteCuisineController.value.text,
        "spokenLanguages": spokenLanguagesController.value.text,
        "rasi": moonSignController.value.text,
        "nakshatra": nakshatraController.value.text,
        "astroprofile": astroprofileController.value.text,
        "photo1": imageUrl1,
        "photo2": imageUrl2,
        "photo3": imageUrl3,
        "motherName": motherNameController.value.text,
        "fatherName": fatherNameController.value.text,
        "facebookUrl": facebookLinkController.value.text,
        "linkedinUrl": linkedinUrlController.value.text,
        "whatsappUrl": watsappNumberController.value.text,
        "user": {"id": userId}
      }),
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        'Authorization': 'Bearer ${SessionManager.getToken()}',
        "Cookie": "jwtToken=${SessionManager.getToken()}",
      },
    );
    print("payload ${value.body.toString()}");
    var response = jsonDecode(value.body.toString());
    print("payload ${response}");
    rxRequestStatus.value = Status.loading;
    try {
      if (value.statusCode == 200) {
        rxRequestStatus.value = Status.success;
        Get.offNamed(AppRoutes.homeScreen);
        print("object $response");
        customFlutterToast(msg: response['message']);
      } else {
        rxRequestStatus.value = Status.error;
        print("Error , ${response['message']} ");
        customFlutterToast(
            backgroundColor: Colors.red, msg: "${response['message']}");
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      print("Error , $e ");
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
    }
  }
}
