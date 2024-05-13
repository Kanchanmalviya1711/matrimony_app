import 'dart:convert';
import 'package:intl/intl.dart';
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
// Date Of Birth
  final dateOfBirth = TextEditingController().obs;
  final gender = TextEditingController().obs;

  // filter field
  final minWeightController = TextEditingController().obs;
  final maxWeightController = TextEditingController().obs;
  final minHeightController = TextEditingController().obs;
  final maxHeightController = TextEditingController().obs;
  final minIncomeController = TextEditingController().obs;
  final maxIncomeController = TextEditingController().obs;
  final minAgeController = TextEditingController().obs;
  final maxAgeController = TextEditingController().obs;
  final casteFilter = TextEditingController().obs;
  final minAnnualIncomeController = TextEditingController().obs;
  final maxAnnualIncomeController = TextEditingController().obs;

  var allProfiles;
  var singleProfiles = [];
  String? haveChildren;
  String? haveChildrenValue;
  var meritalStatus = "1".obs;
  String? meritalStatusValue;
  final rxRequestStatus = Rx<Status>(Status.success);
  final firstName = TextEditingController().obs;
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
    meritalStatus.value = "1";
    meritalStatusValue = null;
    dateOfBirth.value.clear();
    gender.value.clear();
    selectedCheckBoxValue.clear();
  }

  //Api call allLanguages
  final languageList = [].obs;
  final selectedCheckBoxValue = [].obs;
  getAllLanguages({int? page, int? perPageRecord, String? searchTerm}) async {
    var url = Uri.parse(ApiNetwork.allLanguagesList);
    var payload = {
      "page": page ?? pageKey,
      "per_page_record": perPageRecord ?? "10"
    };
    try {
      var response = await http.post(
        url,
        body: jsonEncode(payload),
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          'Authorization': 'Bearer ${SessionManager.getToken()}',
          "Cookie": "jwtToken=${SessionManager.getToken()}",
        },
      );
      if (response.statusCode == 200) {
        rxRequestStatus.value = Status.success;
        var responseData = json.decode(response.body);
        var data = responseData["payload"]["data"];
        languageList.value = data;
      } else {
        throw Exception('Failed to load cities data');
      }
    } catch (e) {
      print('Error fetching cities: $e');
      throw Exception('Failed to load cities: $e');
    }
  }

  // Interested City
  final cityList = [].obs;
  final cityValue = [].obs;
  getAllCity({int? page, int? perPageRecord, String? searchTerm}) async {
    var url = Uri.parse(ApiNetwork.allCityList);
    var payload = {
      "page": page ?? pageKey,
      "per_page_record": perPageRecord ?? "10"
    };
    try {
      var response = await http.post(
        url,
        body: jsonEncode(payload),
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          'Authorization': 'Bearer ${SessionManager.getToken()}',
          "Cookie": "jwtToken=${SessionManager.getToken()}",
        },
      );
      if (response.statusCode == 200) {
        rxRequestStatus.value = Status.success;
        var responseData = json.decode(response.body);
        var data = responseData["payload"]["data"];
        cityList.value = data;
      } else {
        throw Exception('Failed to load cities data');
      }
    } catch (e) {
      print('Error fetching cities: $e');
      throw Exception('Failed to load cities: $e');
    }
  }

  // All Profile List Api__________________________________________________________

  getAllProfiles({int? page, int? perPageRecord, String? searchTerm}) async {
    var payload = {
      "id": null,
      "gender": SessionManager.getInterestedGender() == "3"
          ? null
          : SessionManager.getInterestedGender(),
      "caste": casteFilter.value.text == ""
          ? null
          : placeOfBirthController.value.text != "" &&
                  casteFilter.value.text != ""
              ? casteFilter.value.text
              : placeOfBirthController.value.text != ""
                  ? null
                  : casteFilter.value.text,
      "religion": religionController.value.text == ""
          ? null
          : placeOfBirthController.value.text != "" &&
                  religionController.value.text != ""
              ? religionController.value.text
              : placeOfBirthController.value.text != ""
                  ? null
                  : religionController.value.text,
      "minAge": minAgeController.value.text == ""
          ? null
          : minAgeController.value.text,
      "maxAge": maxAgeController.value.text == ""
          ? null
          : maxAgeController.value.text,
      "minHeight": minHeightController.value.text == ""
          ? null
          : minHeightController.value.text,
      "maxHeight": maxHeightController.value.text == ""
          ? null
          : maxHeightController.value.text,
      "minWeight": minWeightController.value.text == ""
          ? null
          : minWeightController.value.text,
      "maxWeight": maxWeightController.value.text == ""
          ? null
          : maxWeightController.value.text,
      "minAnnualIncome": minAnnualIncomeController.value.text == ""
          ? null
          : minAnnualIncomeController.value.text,
      "maxAnnualIncome": maxAnnualIncomeController.value.text == ""
          ? null
          : maxAnnualIncomeController.value.text,
      "languageSelectedList":
          selectedCheckBoxValue.isEmpty ? null : selectedCheckBoxValue,
      "citySelectedList": cityValue.isEmpty ? null : cityValue,
      "page": page ?? pageKey,
      "per_page_record": perPageRecord ?? "10"
    };
    print('payload $payload');
    try {
      var value = await api.post(
          ApiNetwork.allProfilesList, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        var singleProfiles = value['payload']['data'];
        print("allprofiles, $singleProfiles");
        return singleProfiles;
      } else {
        customFlutterToast(
            backgroundColor: Colors.red, msg: "Failed to fetch users");
        rxRequestStatus.value = Status.error;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("the error display, $e");
    }
  }

  createProfile(
    String imageUrl1,
    String imageUrl2,
    String imageUrl3,
  ) async {
    var userId = await jsonDecode(SessionManager.getUserId().toString());
    // Select time of birth
    DateTime now = DateTime.now();
    String timeString = timeOfBirth.value.text;
    // Combine the date and time
    DateTime dateTime = DateFormat.Hm().parse(timeString);
    DateTime combinedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      dateTime.hour,
      dateTime.minute,
    );
    // select date of marriage;
    var dateOfMarriageFormatted;
    if (dateOfMarriage.value.text != "") {
      dateOfMarriageFormatted = TimeFormateMethod().getTimeFormate(
          formate: "yyyy-MM-ddTHH:mm:ss.SSSSSSZ+0000",
          time: dateOfMarriage.value.text);
    }
    var payload = {
      "createdBy": "1",
      "maritalStatus": meritalStatus == null ? "2" : meritalStatus.toString(),
      "haveChildren": haveChildren == null ? "2" : haveChildren.toString(),
      "numberOfChildren": numberOfChildrenController.value.text == ""
          ? '0'
          : numberOfChildrenController.value.text,
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
      "numberOfBrother": numberOfBrothersController.value.text == ""
          ? null
          : numberOfBrothersController.value.text,
      "numberOfSister": numberOfSistersController.value.text == ""
          ? null
          : numberOfSistersController.value.text,
      "contactPersonPhoneNumber": contactPersonPhoneNumber.value.text,
      "contactPersonName": contactPersonNameController.value.text,
      "contactPersonRelationShip": relationshipController.value.text,
      "convenientCallTime": timeToCallController.value.text,
      "placeOfBirth": placeOfBirthController.value.text,
      "timeOFBirth": TimeFormateMethod()
          .getTimeFormate(formate: "HH:mm", time: combinedDateTime.toString()),
      "nickName": nickNameController.value.text,
      "hobbies": hobbiesController.value.text,
      "interests": interestsController.value.text,
      "favoriteReads": favoriteReadsController.value.text,
      "preferredMovies": preferredMoviesController.value.text,
      "sports": sportsController.value.text,
      "favoriteCuisine": favoriteCuisineController.value.text,
      "language": selectedCheckBoxValue,
      "interestedCities": cityValue,
      "rasi": moonSignController.value.text,
      "nakshatra": nakshatraController.value.text,
      "astroprofile": astroprofileController.value.text,
      "photo1": imageUrl1 == "" ? null : imageUrl1,
      "photo2": imageUrl2 == "" ? null : imageUrl2,
      "photo3": imageUrl3 == "" ? null : imageUrl3,
      "motherName": motherNameController.value.text,
      "fatherName": fatherNameController.value.text,
      "facebookUrl": facebookLinkController.value.text,
      "linkedinUrl": linkedinUrlController.value.text,
      "whatsappUrl": watsappNumberController.value.text,
      "user": {"id": userId}
    };
    print("payload data show $payload");

    rxRequestStatus.value = Status.loading;
    try {
      var value = await api.post(
          ApiNetwork.createProfile, jsonEncode(payload), true,
          isCookie: true);
      print("$value , api data checking");
      if (value['status'] == "success") {
        rxRequestStatus.value = Status.success;
        Get.offAllNamed(AppRoutes.profileScreen);
        var jsonData = value["payload"];
        print("jaon Data , $jsonData");
        await SessionManager.setUserProfileData(json.encode(jsonData));
        customFlutterToast(msg: value['message']);
      } else {
        rxRequestStatus.value = Status.error;
        print("Error , $value ");
        customFlutterToast(
            backgroundColor: Colors.green, msg: "Profile created successfully");
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      print("Error error error , $e ");
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      customFlutterToast(
          backgroundColor: Colors.red, msg: "Please Upload Image");
    }
  }

  updateProfile(
      String imageUrl1, String imageUrl2, String imageUrl3, String id) async {
    DateTime now = DateTime.now();
    String timeString = timeOfBirth.value.text;
    // Combine the date and time
    DateTime dateTime = DateFormat.Hm().parse(timeString);
    DateTime combinedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      dateTime.hour,
      dateTime.minute,
    );
    // print("hjhhhhhhhhhhhhhhhhh");
    var userId = await jsonDecode(SessionManager.getUserId().toString());
    var dateOfMarriageFormatted;

    if (dateOfMarriage.value.text != "") {
      dateOfMarriageFormatted = TimeFormateMethod().getTimeFormate(
          formate: "yyyy-MM-ddTHH:mm:ss.SSSSSSZ+0000",
          time: dateOfMarriage.value.text);
    }
    // Construct language payload
    List<Map<String, String>> languages = [];
    for (var languageId in languageList) {
      // Ensure languageId is a map with "id" key
      if (languageId is Map && languageId.containsKey("id")) {
        var langObj = {"id": languageId["id"].toString()};
        languages.add(langObj);
        // print("$languages, languages");
        // print("$langObj, langObj");
      }
    }
    // Construct language payload
    List<Map<String, String>> cities = [];
    for (var cityId in cityList) {
      // Ensure languageId is a map with "id" key
      if (cityId is Map && cityId.containsKey("id")) {
        var cityObj = {"id": cityId["id"].toString()};
        cities.add(cityObj);
      }
    }
    var url = Uri.parse(ApiNetwork.updateProfile + id);
    var value = await http.put(
      url,
      body: jsonEncode({
        "createdBy": "1",
        "maritalStatus": meritalStatus == null ? "2" : meritalStatus.toString(),
        "haveChildren": haveChildren == null ? "2" : haveChildren.toString(),
        "numberOfChildren": numberOfChildrenController.value.text == ""
            ? '0'
            : numberOfChildrenController.value.text,
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
        "numberOfBrother": numberOfBrothersController.value.text == ""
            ? null
            : numberOfBrothersController.value.text,
        "numberOfSister": numberOfSistersController.value.text == ""
            ? null
            : numberOfSistersController.value.text,
        "contactPersonPhoneNumber": contactPersonPhoneNumber.value.text,
        "contactPersonName": contactPersonNameController.value.text,
        "contactPersonRelationShip": relationshipController.value.text,
        "convenientCallTime": timeToCallController.value.text,
        "placeOfBirth": placeOfBirthController.value.text,
        "timeOFBirth": TimeFormateMethod().getTimeFormate(
            formate: "HH:mm", time: combinedDateTime.toString()),
        "hobbies": hobbiesController.value.text,
        "whatsappUrl": watsappNumberController.value.text,
        "interests": interestsController.value.text,
        "favoriteReads": favoriteReadsController.value.text,
        "preferredMovies": preferredMoviesController.value.text,
        "sports": sportsController.value.text,
        "favoriteCuisine": favoriteCuisineController.value.text,
        "language": selectedCheckBoxValue,
        "interestedCities": cityValue,
        "rasi": moonSignController.value.text,
        "nakshatra": nakshatraController.value.text,
        "astroprofile": astroprofileController.value.text,
        "photo1": imageUrl1 == "" ? null : imageUrl1,
        "photo2": imageUrl2 == "" ? null : imageUrl2,
        "photo3": imageUrl3 == "" ? null : imageUrl3,
        "motherName": motherNameController.value.text,
        "fatherName": fatherNameController.value.text,
        "facebookUrl": facebookLinkController.value.text,
        "linkedinUrl": linkedinUrlController.value.text,
        "user": {"id": userId}
      }),
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        'Authorization': 'Bearer ${SessionManager.getToken()}',
        "Cookie": "jwtToken=${SessionManager.getToken()}",
      },
    );
    var response = jsonDecode(value.body.toString());
    print("$response, body");
    rxRequestStatus.value = Status.loading;
    try {
      if (value.statusCode == 200) {
        rxRequestStatus.value = Status.success;
        Get.offNamed(AppRoutes.profileScreen);
        var jsonData = response["payload"];
        await SessionManager.setUserProfileData(json.encode(jsonData));
        print("object $jsonData");
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
