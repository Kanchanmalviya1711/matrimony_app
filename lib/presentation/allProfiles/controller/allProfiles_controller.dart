import 'dart:convert';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_snackbar.dart';
import 'package:matrimony_app/data/apiClient/api_client.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/register/model/register_model.dart';
import 'package:matrimony_app/routes/app_routes.dart';

class AllProfilesListController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  TextEditingController numberOfChildrenController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bodyTypeController = TextEditingController();
  TextEditingController complexionController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController specialCasesController = TextEditingController();
  TextEditingController motherTongueController = TextEditingController();
  TextEditingController casteController = TextEditingController();
  TextEditingController subCasteController = TextEditingController();
  TextEditingController manglikController = TextEditingController();
  TextEditingController familyValuesController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController dieatryHabitsController = TextEditingController();
  TextEditingController aboutYourselfController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController annualIncomeController = TextEditingController();
  TextEditingController numberOfBrothersController = TextEditingController();
  TextEditingController numberOfSistersController = TextEditingController();
  TextEditingController contactPersonNameController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController timeToCallController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController timeOFBirthController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();
  TextEditingController interestsController = TextEditingController();
  TextEditingController favoriteReadsController = TextEditingController();
  TextEditingController preferredMoviesController = TextEditingController();
  TextEditingController sportsController = TextEditingController();
  TextEditingController favoriteCuisineController = TextEditingController();
  TextEditingController spokenLanguagesController = TextEditingController();
  TextEditingController moonSignController = TextEditingController();
  TextEditingController nakshatraController = TextEditingController();
  TextEditingController astroprofileController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController facebookLinkController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController linkedinUrlController = TextEditingController();
  TextEditingController watsappNumberController = TextEditingController();
  final dateOfMarriage = TextEditingController().obs;
  String? haveChildren;
  String? haveChildrenValue;
  String? meritalStatus;
  String? meritalStatusValue;
  final rxRequestStatus = Rx<Status>(Status.success);
  var allProfiles;
  var firstName = TextEditingController();
  var pageKey = 1;
  var perPage = 10;
  final usersList = RegisterModel().obs;
  final usersList2 = RegisterModel().obs;
  final usersList3 = RegisterModel().obs;

  getAllProfiles({page, perPageRecord}) async {
    print("hjhhhhhhhhhhhhhhhhh");

    try {
      var payload = {"page": "", "per_page_record": "20"};
      var value = await api.post(
          ApiNetwork.allProfilesList, jsonEncode(payload), true,
          isCookie: true);
      if (value['status'] == "success") {
        print("fsdfdsf pradhufjsdf ${value['payload']['data']}");
        allProfiles = value['payload']['data'];

        print("object");
        print("fgdfgfdgdfg fdg $allProfiles");

        return allProfiles;
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
      print("Error , $e ");
    }
  }

  createProfile(String imageUrl) async {
    var payload = {
      "createdBy": "1",
      "maritalStatus":
          meritalStatus.toString() == null ? "1" : "2", //problem //corrcetion
      "haveChildren":
          haveChildren.toString() == null ? "1" : "2", //problem  //corrcetion
      "numberOfChildren": numberOfChildrenController.value.text,
      "weight": weightController.value.text,
      "height": heightController.value.text,
      "bodyType": bodyTypeController.value.text,
      "complexion": complexionController.value.text,
      "religion": religionController.value.text,
      "specialCases": specialCasesController.value.text,
      "motherTongue": motherTongueController.value.text,
      "dateOfMarriage": "2020-10-19T18:30:00.000000+0000", //corrcetion
      "caste": casteController.value.text,
      "subCaste": subCasteController.value.text,
      "manglik": manglikController.value.text,
      "familyValues": familyValuesController.value.text,
      "education": educationController.value.text,
      "profession": professionController.value.text,
      "diet": dieatryHabitsController.value.text,
      "aboutYourself": aboutYourselfController.value.text,
      "bloodGroup": bloodGroupController.value.text,
      "annualIncome": annualIncomeController.value.text,
      "numberOfBrother": numberOfBrothersController.value.text,
      "numberOfSister": numberOfSistersController.value.text,
      "contactPersonName": contactPersonNameController.value.text,
      "contactPersonRelationShip": relationshipController.value.text,
      "convenientCallTime": timeToCallController.value.text,
      "placeOfBirth": placeOfBirthController.value.text,
      "timeOFBirth": "2020-10-19T18:30:00.000000+0000", //corrcetion
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
      "photo1": "jkhkjh.png", //corrcetion
      "photo2": "kkjlksafdj.pgds", //corrcetion
      "photo3": "jhnkh.png", //corrcetion
      "motherName": motherNameController.value.text,
      "fatherName": fatherNameController.value.text,
      "facebookUrl": facebookLinkController.value.text,
      "linkedinUrl": linkedinUrlController.value.text,
      "whatsappUrl": watsappNumberController.value.text,
      "user": {"id": "3"} //corrcetion
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
}
