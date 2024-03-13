import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/time_formate_method.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/allProfiles/controller/allProfiles_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_circuler_loader.dart';
import 'package:matrimony_app/widgets/custom_dropdown.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_text_form_field.dart';
import 'package:matrimony_app/widgets/datetime_controller.dart';
import 'package:matrimony_app/widgets/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);
  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  AllProfilesListController allProfilesListController =
      Get.put(AllProfilesListController());

  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  final data = Get.arguments;

  assignFieldData() {
    print("data ${data}");
    allProfilesListController.numberOfChildrenController.value.text =
        data[0]["numberOfChildren"].toString();
    allProfilesListController.weightController.value.text =
        data[0]["weight"].toString();
    allProfilesListController.heightController.value.text =
        data[0]["height"].toString();
    allProfilesListController.bodyTypeController.value.text =
        data[0]["bodyType"].toString();
    allProfilesListController.complexionController.value.text =
        data[0]["complexion"].toString();
    allProfilesListController.religionController.value.text =
        data[0]["religion"].toString();
    allProfilesListController.companyName.value.text =
        data[0]["companyName"].toString();
    allProfilesListController.specialCasesController.value.text =
        data[0]["specialCases"].toString();
    allProfilesListController.motherTongueController.value.text =
        data[0]["motherTongue"].toString();
    allProfilesListController.casteController.value.text =
        data[0]["caste"].toString();
    allProfilesListController.subCasteController.value.text =
        data[0]["subCaste"].toString();
    allProfilesListController.manglikController.value.text =
        data[0]["manglik"].toString();
    allProfilesListController.familyValuesController.value.text =
        data[0]["familyValues"].toString();
    allProfilesListController.educationController.value.text =
        data[0]["education"].toString();
    allProfilesListController.professionController.value.text =
        data[0]["profession"].toString();
    allProfilesListController.dieatryHabitsController.value.text =
        data[0]["diet"].toString();
    allProfilesListController.aboutYourselfController.value.text =
        data[0]["aboutYourself"].toString();
    allProfilesListController.dateOfMarriage.value.text =
        data[0]["dateOfMarriage"] == null
            ? ""
            : TimeFormateMethod().getTimeFormate(
                time: data[0]["dateOfMarriage"].toString(),
                formate: 'yyyy-MM-dd');

    allProfilesListController.bloodGroupController.value.text =
        data[0]["bloodGroup"].toString();
    allProfilesListController.annualIncomeController.value.text =
        data[0]["annualIncome"].toString();
    allProfilesListController.numberOfBrothersController.value.text =
        data[0]["numberOfBrother"].toString();
    allProfilesListController.numberOfSistersController.value.text =
        data[0]["numberOfSister"].toString();
    allProfilesListController.contactPersonNameController.value.text =
        data[0]["contactPersonName"].toString();
    allProfilesListController.relationshipController.value.text =
        data[0]["contactPersonRelationShip"];
    allProfilesListController.timeToCallController.value.text =
        data[0]["convenientCallTime"].toString();
    allProfilesListController.placeOfBirthController.value.text =
        data[0]["placeOfBirth"].toString();
    allProfilesListController.timeOfBirth.value.text =
        data[0]["timeOFBirth"].toString();
    allProfilesListController.hobbiesController.value.text =
        data[0]["hobbies"].toString();
    allProfilesListController.interestsController.value.text =
        data[0]["interests"].toString();
    allProfilesListController.favoriteReadsController.value.text =
        data[0]["favoriteReads"].toString();
    allProfilesListController.nickNameController.value.text =
        data[0]["nickName"] == null
            ? "No family name found"
            : data[0]["nickName"].toString();
    allProfilesListController.preferredMoviesController.value.text =
        data[0]["preferredMovies"].toString();
    allProfilesListController.sportsController.value.text =
        data[0]["sports"].toString();
    allProfilesListController.favoriteCuisineController.value.text =
        data[0]["favoriteCuisine"].toString();
    allProfilesListController.spokenLanguagesController.value.text =
        data[0]["spokenLanguages"].toString();
    allProfilesListController.meritalStatusValue =
        data[0]["maritalStatus"] == "1"
            ? "Married"
            : data[0]["maritalStatus"] == "2"
                ? "Unmarried"
                : data[0]["maritalStatus"] == "3"
                    ? "Divorced"
                    : data[0]["maritalStatus"] == "4"
                        ? "Widowed"
                        : "Marriage Date Not Found";
    allProfilesListController.meritalStatus =
        data[0]["maritalStatus"].toString();
    allProfilesListController.haveChildrenValue =
        data[0]["haveChildren"] == 1 ? "Yes" : "No";
    allProfilesListController.haveChildren = data[0]["haveChildren"].toString();
    allProfilesListController.moonSignController.value.text =
        data[0]["rasi"].toString();
    allProfilesListController.nakshatraController.value.text =
        data[0]["nakshatra"].toString();
    allProfilesListController.astroprofileController.value.text =
        data[0]["astroprofile"].toString();
    allProfilesListController.motherNameController.value.text =
        data[0]["motherName"].toString();
    allProfilesListController.fatherNameController.value.text =
        data[0]["fatherName"].toString();
    allProfilesListController.facebookLinkController.value.text =
        data[0]["facebookUrl"].toString();
    allProfilesListController.linkedinUrlController.value.text =
        data[0]["linkedinUrl"].toString();
    allProfilesListController.watsappNumberController.value.text =
        data[0]["whatsappUrl"].toString();
    allProfilesListController.contactPersonPhoneNumber.value.text =
        data[0]["contactPersonPhoneNumber"] == null
            ? ""
            : data[0]["contactPersonPhoneNumber"].toString();
    allProfilesListController.usersList.value.downloadURL =
        data[0]["photo1"].toString();
    allProfilesListController.usersList2.value.downloadURL =
        data[0]["photo2"].toString();
    allProfilesListController.usersList3.value.downloadURL =
        data[0]["photo3"].toString();
    imageUrl1 = data[0]["photo1"].toString();
    imageUrl2 = data[0]["photo2"].toString();
    imageUrl3 = data[0]["photo3"].toString();
  }

// haveChildren list
  var haveChildren = [
    {"id": "1", "title": "Yes"},
    {"id": "2", "title": "No"},
  ];
  // materialStatus list
  var materialStatus = [
    {"id": "1", "title": "Married"},
    {"id": "2", "title": "Unmarried"},
    {"id": "3", "title": "Divorced"},
    {"id": "4", "title": "Widowed"},
  ];

  @override
  void initState() {
    if (data[0] != null) assignFieldData();

    super.initState();
  }

  File? result1;
  File? result2;
  File? result3;
  String imageUrl1 = '';
  String imageUrl2 = '';
  String imageUrl3 = '';

  Future<void> pickImage(result) async {
    print("result $result");
    try {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var res = File(image.path);
        if (result == 1) {
          result1 = res;
          imageUrl1 = await uploadFile(result1!);
        } else if (result == 2) {
          result2 = res;
          imageUrl2 = await uploadFile(result2!);
        } else if (result == 3) {
          result3 = res;
          imageUrl3 = await uploadFile(result3!);
        }
        setState(() {});
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future uploadFile(File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiNetwork.uploadFile),
      );
      request.files
          .add(await http.MultipartFile.fromPath('uploadFile', file.path));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        print("Checking data: $result");
        return result['downloadURL'];
      } else {
        print("Error: ${response.reasonPhrase}");
        return false;
      }
    } catch (e) {
      print("Error uploading file: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        key: scaffoldKey,
        appBar: CustomAppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.face,
              color: appTheme.whiteA700,
            ),
          ),
          title: data[0] != null
              ? "UPDATE YOUR PROFILE".tr
              : "COMPLETE PROFILE".tr,
          actions: [
            data[0] != null
                ? Container()
                : PopupMenuButton(
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: appTheme.whiteA700),
                    ),
                    icon: Icon(
                      Icons.more_vert,
                      color: appTheme.whiteA700,
                    ),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.account_circle,
                                color: appTheme.black900, size: 20),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Skip Profile".tr,
                              style: CustomTextStyles.titleSmall_1,
                            ),
                          ],
                        ),
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.homeScreen,
                          );
                        },
                      ),
                    ],
                  )
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: CustomDropdown(
                      labelText: 'Marital Status',
                      listName: materialStatus
                          .map((e) => e['title'].toString())
                          .toList(),
                      selectedItem:
                          allProfilesListController.meritalStatusValue,
                      onChng: (value) {
                        for (var element in materialStatus) {
                          if (element['title'] == value) {
                            allProfilesListController.meritalStatus =
                                element['id'].toString();
                          }
                        }
                        print(
                            "meritalStatus ${allProfilesListController.meritalStatus}");
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      readOnly: true,
                      validator: (value) {
                        // if (value!.isEmpty) {
                        //   return "Please enter date of marriage";
                        // }
                        return null;
                      },
                      controller:
                          allProfilesListController.dateOfMarriage.value,
                      labelText: "Date Of Marriage",
                      onTap: () {
                        DateTimePickerController().selectDob1(
                          allProfilesListController.dateOfMarriage.value,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomDropdown(
                      labelText: 'Have Children',
                      listName: haveChildren
                          .map((e) => e['title'].toString())
                          .toList(),
                      selectedItem: allProfilesListController.haveChildrenValue,
                      onChng: (value) {
                        for (var element in haveChildren) {
                          if (element['title'] == value) {
                            allProfilesListController.haveChildren =
                                element['id'].toString();
                          }
                        }
                        print(
                            "have children ${allProfilesListController.meritalStatus}");
                      },
                    ),
                  ),
                  const SizedBox(height: 8),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.child_care,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .numberOfChildrenController.value,
                      labelText: "No. Of Children",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter number of children";
                        }
                        if (!RegExp(r'^[0-9]{1,}$').hasMatch(value)) {
                          return "Please enter a valid numeric data";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Divider(),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.line_weight,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.weightController.value,
                      labelText: "Weight",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter weight value";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.height,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.heightController.value,
                      labelText: "Height",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter height value";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.type_specimen,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.bodyTypeController.value,
                      labelText: "Body Type",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter body type";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.face,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.complexionController.value,
                      labelText: "Face Complexion",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter body complexion";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .specialCasesController.value,
                      labelText: "Special Cases",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter special cases (None / Physically Challenged / Mentally Challenged / Physically and Mentally Challenged / Others)";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.bloodtype,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.bloodGroupController.value,
                      labelText: "Blood Group",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter blood group (A+ / B+ / AB+ / O+ / A- / B- / AB- / O- ) ";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),

                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.food_bank,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .dieatryHabitsController.value,
                      labelText: "Dieatry Habits",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter dieatry habits (Veg / Non Veg / Eggetarian) ";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.recycling,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.religionController.value,
                      labelText: "Religion",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter religion";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.person_pin_circle_rounded,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .motherTongueController.value,
                      labelText: "Mother Tongue",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter mother tongue value";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.contacts_sharp,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.casteController.value,
                      labelText: "Caste",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter caste";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.subdirectory_arrow_left,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.subCasteController.value,
                      labelText: "Sub Caste",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter sub caste value";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.crisis_alert_sharp,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.manglikController.value,
                      labelText: "Are You Managalik ?",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter text";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.language,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .spokenLanguagesController.value,
                      labelText: "Spoken Languages",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter spoken languages (English / Hindi / Marathi / Other)";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.radar_sharp,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.moonSignController.value,
                      labelText: "Moonsign (Rashi)",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter moonsign (rashi)";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.star_sharp,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.nakshatraController.value,
                      labelText: "Nakshatra",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter nakshatra (star)";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.stars,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .astroprofileController.value,
                      labelText: "Astroprofile (Kundli)",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter astroprofile (kundli) (Yes / No / Don't Know)";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.cast_for_education,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.educationController.value,
                      labelText: "Education Qualification",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter education qualification ";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.business_center,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController.companyName.value,
                      labelText: "Company Name",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter company name";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.portrait_outlined,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.professionController.value,
                      labelText: "Profession",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter profession ";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.incomplete_circle,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .annualIncomeController.value,
                      labelText: "Annual Income",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter annual income";
                        }
                        if (!RegExp(r'^[0-9]{6,}$').hasMatch(value)) {
                          return "Please enter a valid numeric with at least 6 digits";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.face_6_sharp,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.nickNameController.value,
                      labelText: "Family Name (nickname)",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter family name";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.family_restroom,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .familyValuesController.value,
                      labelText: "Family Values",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter family value Good/Bad ";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.face_4,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.motherNameController.value,
                      labelText: "Mother's Name ",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter mother's name";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.tag_faces_sharp,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.fatherNameController.value,
                      labelText: "Father's Name ",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter father's name";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.format_list_numbered_rtl_rounded,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .numberOfBrothersController.value,
                      labelText: "No. Of Siblings (Brothers)",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter no. of siblings (brothers)";
                        }
                        if (!RegExp(r'^[0-9]{1}$').hasMatch(value)) {
                          return "Please enter a valid number";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.numbers,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .numberOfSistersController.value,
                      labelText: "No. Of Siblings (Sisters)",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter no. of siblings (sisters)";
                        }
                        if (!RegExp(r'^[0-9]{1}$').hasMatch(value)) {
                          return "Please enter a valid number";
                        }

                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.keyboard,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .contactPersonPhoneNumber.value,
                      labelText: "Contact Person Phone Number",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a contact person phone number";
                        }
                        // Check if the entered value is numeric and has exactly 10 digits
                        if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return "Please enter a 10-digit numeric phone number";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.contact_phone_rounded,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .contactPersonNameController.value,
                      labelText: "Contact Person Name",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter contact person name";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.real_estate_agent,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .relationshipController.value,
                      labelText: "Contact Person Relationship",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter contact person relationship with you (Father / Mother / Brother / Sister / Friend / Relative)";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.watch_later,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.timeToCallController.value,
                      labelText: "Convinient Time To Call",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter convinient time to call (Morning / Afternoon / Evening / Night)";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.place_outlined,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .placeOfBirthController.value,
                      labelText: "Place Of Birth (City & State)",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter place of birth (city & state)";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),

                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                      readOnly: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter time of birth";
                        }
                        return null;
                      },
                      controller: allProfilesListController.timeOfBirth.value,
                      labelText: "Time Of Birth(HH:MM)",
                      onTap: () {
                        DateTimePickerController().selectTime(
                            allProfilesListController.timeOfBirth.value);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.hot_tub_outlined,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.hobbiesController.value,
                      labelText: "Hobbies",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter hobbies";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.interpreter_mode_sharp,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.interestsController.value,
                      labelText: "Interests",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter interests";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.bookmark_added_sharp,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .favoriteReadsController.value,
                      labelText: "Favorite Reads",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter favorite reads";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.movie_sharp,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .preferredMoviesController.value,
                      labelText: "Preferred Movies",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter preferred movies";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.sports,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.sportsController.value,
                      labelText: "Sports",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter sports (Cricket / Football / Tennis / Badminton / Hockey / Chess / Carrom / Other)";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.food_bank_outlined,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .favoriteCuisineController.value,
                      labelText: "Favorite Cuisine",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter favorite cuisine (North Indian / South Indian / Chinese / Continental / Italian / Thai / Mexican / Other)";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                      ),
                    ),
                  ),

                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.link,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .facebookLinkController.value,
                      labelText: "Facebook Profile Link",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter facebook profile link";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.link_outlined,
                        color: Colors.black,
                      ),
                      controller:
                          allProfilesListController.linkedinUrlController.value,
                      labelText: "Linkedin Profile Link",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter linkedin profile link";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.wallet_membership_sharp,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .watsappNumberController.value,
                      labelText: "Watsapp Url",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter valid watsapp number";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Divider(),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: const Icon(
                        Icons.info,
                        color: Colors.black,
                      ),
                      controller: allProfilesListController
                          .aboutYourselfController.value,
                      labelText: "About Yourself",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter about yourself (min 50 words)";
                        } else if (value.trim().split(' ').length > 120) {
                          return "Please limit your about yourself to 120 words";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  const SizedBox(height: 10),
                  // 1 image picker
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 60.h,
                              height: 60.v,
                              child: result1 != null
                                  ? CircleAvatar(
                                      backgroundImage: FileImage(
                                        result1!,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        allProfilesListController.usersList
                                                    .value.downloadURL !=
                                                null
                                            ? ApiNetwork.imageUrl +
                                                allProfilesListController
                                                    .usersList
                                                    .value
                                                    .downloadURL!
                                            : ImageConstant.fakeProfile,
                                      ),
                                    )),
                          Padding(
                            padding: EdgeInsets.only(left: 10.h),
                            child: CustomElevatedButton(
                              // isDisabled:
                              //     allProfilesListController.isEdit.value,
                              text: 'Upload',
                              onTap: () {
                                pickImage(
                                  1,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // 2 image picker
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 60.h,
                              height: 60.v,
                              child: result2 != null
                                  ? CircleAvatar(
                                      backgroundImage: FileImage(
                                        result2!,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        allProfilesListController.usersList2
                                                    .value.downloadURL !=
                                                null
                                            ? ApiNetwork.imageUrl +
                                                allProfilesListController
                                                    .usersList2
                                                    .value
                                                    .downloadURL!
                                            : ImageConstant.fakeProfile,
                                      ),
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.h),
                              child: CustomElevatedButton(
                                // isDisabled:
                                //     allProfilesListController.isEdit.value,
                                text: 'Upload',
                                onTap: () {
                                  pickImage(2);
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 10),
                  // 3 image picker
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 60.h,
                                height: 60.v,
                                child: result3 != null
                                    ? CircleAvatar(
                                        backgroundImage: FileImage(
                                          result3!,
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          allProfilesListController.usersList3
                                                      .value.downloadURL !=
                                                  null
                                              ? ApiNetwork.imageUrl +
                                                  allProfilesListController
                                                      .usersList3
                                                      .value
                                                      .downloadURL!
                                              : ImageConstant.fakeProfile,
                                        ),
                                      )),
                            Padding(
                              padding: EdgeInsets.only(left: 10.h),
                              child: CustomElevatedButton(
                                // isDisabled:
                                //     allProfilesListController.isEdit.value,
                                text: 'Upload',
                                onTap: () {
                                  pickImage(3);
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 10),
                  _buildLoginButtonSection(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  // Section Widget
  Widget _buildLogoSection() {
    return SizedBox(
      height: 180.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 22.v,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.logowhite,
            width: 300,
            radius: BorderRadius.circular(
              14.h,
            ),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLoginButtonSection() {
    return GetBuilder(
        init: ImagePickerController(),
        builder: (context) {
          return Row(
            children: [
              Expanded(
                child: allProfilesListController.rxRequestStatus.value ==
                        Status.loading
                    ? CustomLoading(
                        color: appTheme.orange,
                        size: 30,
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          buttonStyle: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(appTheme.green600),
                          ),
                          text: data[0] != null
                              ? "Update Profile".tr
                              : "Submit".tr,
                          margin: EdgeInsets.only(
                            left: 10.h,
                            right: 10.h,
                            bottom: 20.v,
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                data[0] == null
                                    ? allProfilesListController.createProfile(
                                        imageUrl1, imageUrl2, imageUrl3)
                                    : allProfilesListController.updateProfile(
                                        imageUrl1,
                                        imageUrl2,
                                        imageUrl3,
                                        data[0]['id'].toString());
                              });
                            }
                          },
                        ),
                      ),
              ),
            ],
          );
        });
  }
}
