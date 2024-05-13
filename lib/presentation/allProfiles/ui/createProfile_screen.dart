import 'dart:async';
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
import 'package:matrimony_app/widgets/multiselect_dropdown.dart';

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
        data[0]["numberOfChildren"] == ""
            ? ""
            : allProfilesListController.numberOfChildrenController.value.text =
                data[0]["numberOfChildren"].toString();
    allProfilesListController.weightController.value.text =
        data[0]["weight"].toString();
    allProfilesListController.heightController.value.text =
        data[0]["height"].toString();
    allProfilesListController.bodyTypeController.value.text =
        data[0]["bodyType"] == ""
            ? ""
            : allProfilesListController.bodyTypeController.value.text =
                data[0]["bodyType"].toString();
    allProfilesListController.complexionController.value.text =
        data[0]["complexion"] == ""
            ? ""
            : allProfilesListController.complexionController.value.text =
                data[0]["complexion"].toString();
    allProfilesListController.religionController.value.text =
        data[0]["religion"] == ""
            ? ""
            : allProfilesListController.religionController.value.text =
                data[0]["religion"].toString();
    allProfilesListController.companyName.value.text =
        data[0]["companyName"] == ""
            ? ""
            : allProfilesListController.companyName.value.text =
                data[0]["companyName"].toString();
    allProfilesListController.specialCasesController.value.text =
        data[0]["specialCases"] == ""
            ? ""
            : allProfilesListController.specialCasesController.value.text =
                data[0]["specialCases"].toString();
    allProfilesListController.motherTongueController.value.text =
        data[0]["motherTongue"] == ""
            ? ""
            : allProfilesListController.motherTongueController.value.text =
                data[0]["motherTongue"].toString();
    allProfilesListController.casteController.value.text =
        data[0]["caste"] == ""
            ? ""
            : allProfilesListController.casteController.value.text =
                data[0]["caste"].toString();
    allProfilesListController.subCasteController.value.text =
        data[0]["subCaste"] == ""
            ? ""
            : allProfilesListController.subCasteController.value.text =
                data[0]["subCaste"].toString();
    allProfilesListController.manglikController.value.text =
        data[0]["manglik"] == ""
            ? ""
            : allProfilesListController.manglikController.value.text =
                data[0]["manglik"].toString();
    allProfilesListController.familyValuesController.value.text =
        data[0]["familyValues"] == ""
            ? ""
            : allProfilesListController.familyValuesController.value.text =
                data[0]["familyValues"].toString();
    allProfilesListController.educationController.value.text =
        data[0]["education"] == ""
            ? ""
            : allProfilesListController.educationController.value.text =
                data[0]["education"].toString();
    allProfilesListController.professionController.value.text =
        data[0]["profession"] == ""
            ? ""
            : allProfilesListController.professionController.value.text =
                data[0]["profession"].toString();
    allProfilesListController.dieatryHabitsController.value.text =
        data[0]["diet"] == ""
            ? ""
            : allProfilesListController.dieatryHabitsController.value.text =
                data[0]["diet"].toString();
    allProfilesListController.aboutYourselfController.value.text =
        data[0]["aboutYourself"] == ""
            ? ""
            : allProfilesListController.aboutYourselfController.value.text =
                data[0]["aboutYourself"];
    allProfilesListController.dateOfMarriage.value.text =
        data[0]["dateOfMarriage"] == null
            ? ""
            : TimeFormateMethod().getTimeFormate(
                time: data[0]["dateOfMarriage"].toString(),
                formate: 'yyyy-MM-dd');

    allProfilesListController.bloodGroupController.value.text =
        data[0]["bloodGroup"] == ""
            ? ""
            : allProfilesListController.bloodGroupController.value.text =
                data[0]["bloodGroup"].toString();
    allProfilesListController.annualIncomeController.value.text =
        data[0]["annualIncome"] == ""
            ? ""
            : allProfilesListController.annualIncomeController.value.text =
                data[0]["annualIncome"].toString();
    allProfilesListController.numberOfBrothersController.value.text =
        data[0]["numberOfBrother"] == null
            ? ""
            : allProfilesListController.numberOfBrothersController.value.text =
                data[0]["numberOfBrother"].toString();
    allProfilesListController.numberOfSistersController.value.text =
        data[0]["numberOfSister"] == null
            ? ""
            : allProfilesListController.numberOfSistersController.value.text =
                data[0]["numberOfSister"].toString();
    allProfilesListController.contactPersonNameController.value.text =
        data[0]["contactPersonName"] == ""
            ? ""
            : allProfilesListController.contactPersonNameController.value.text =
                data[0]["contactPersonName"].toString();
    allProfilesListController.relationshipController.value.text =
        data[0]["contactPersonRelationShip"] == ""
            ? ""
            : allProfilesListController.relationshipController.value.text =
                data[0]["contactPersonRelationShip"].toString();
    allProfilesListController.timeToCallController.value.text =
        data[0]["convenientCallTime"] == ""
            ? ""
            : allProfilesListController.timeToCallController.value.text =
                data[0]["convenientCallTime"].toString();
    allProfilesListController.placeOfBirthController.value.text =
        data[0]["placeOfBirth"] == ""
            ? ""
            : allProfilesListController.placeOfBirthController.value.text =
                data[0]["placeOfBirth"].toString();
    allProfilesListController.timeOfBirth.value.text =
        data[0]["timeOFBirth"] == ""
            ? ""
            : allProfilesListController.timeOfBirth.value.text =
                data[0]["timeOFBirth"].toString();
    allProfilesListController.hobbiesController.value.text =
        data[0]["hobbies"] == ""
            ? ""
            : allProfilesListController.hobbiesController.value.text =
                data[0]["hobbies"].toString();
    allProfilesListController.interestsController.value.text =
        data[0]["interests"] == ""
            ? ""
            : allProfilesListController.interestsController.value.text =
                data[0]["interests"].toString();
    allProfilesListController.favoriteReadsController.value.text =
        data[0]["favoriteReads"] == ""
            ? ""
            : allProfilesListController.favoriteReadsController.value.text =
                data[0]["favoriteReads"].toString();
    allProfilesListController.nickNameController.value.text =
        data[0]["nickName"] == "" ? "" : data[0]["nickName"].toString();
    allProfilesListController.preferredMoviesController.value.text =
        data[0]["preferredMovies"] == ""
            ? ""
            : allProfilesListController.preferredMoviesController.value.text =
                data[0]["preferredMovies"].toString();
    allProfilesListController.sportsController.value.text =
        data[0]["sports"] == ""
            ? ""
            : allProfilesListController.sportsController.value.text =
                data[0]["sports"].toString();
    allProfilesListController.favoriteCuisineController.value.text =
        data[0]["favoriteCuisine"] == ""
            ? ""
            : allProfilesListController.favoriteCuisineController.value.text =
                data[0]["favoriteCuisine"].toString();
    allProfilesListController.spokenLanguagesController.value.text =
        data[0]["spokenLanguages"] == ""
            ? ""
            : allProfilesListController.spokenLanguagesController.value.text =
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
    allProfilesListController.meritalStatus.value =
        data[0]["maritalStatus"] == ""
            ? ""
            : allProfilesListController.meritalStatus.value =
                data[0]["maritalStatus"].toString();

    allProfilesListController.haveChildrenValue =
        data[0]["haveChildren"] == 1 ? "Yes" : "No";
    allProfilesListController.haveChildren = data[0]["haveChildren"].toString();
    allProfilesListController.moonSignController.value.text =
        data[0]["rasi"] == ""
            ? ""
            : allProfilesListController.moonSignController.value.text =
                data[0]["rasi"].toString();
    allProfilesListController.nakshatraController.value.text =
        data[0]["nakshatra"] == ""
            ? ""
            : allProfilesListController.nakshatraController.value.text =
                data[0]["nakshatra"].toString();
    allProfilesListController.astroprofileController.value.text =
        data[0]["astroprofile"].toString();
    allProfilesListController.motherNameController.value.text =
        data[0]["motherName"].toString();
    allProfilesListController.fatherNameController.value.text =
        data[0]["fatherName"].toString();
    allProfilesListController.facebookLinkController.value.text =
        data[0]["facebookUrl"] == ""
            ? ""
            : allProfilesListController.facebookLinkController.value.text =
                data[0]["facebookUrl"].toString();
    allProfilesListController.linkedinUrlController.value.text =
        data[0]["linkedinUrl"] == ""
            ? ""
            : allProfilesListController.linkedinUrlController.value.text =
                data[0]["linkedinUrl"].toString();
    allProfilesListController.watsappNumberController.value.text =
        data[0]["whatsappUrl"] == ""
            ? ""
            : data[0]["whatsappUrl"]
                .toString()
                .replaceAll(RegExp(r'http(?:s)?://wa.me/'), '');

    allProfilesListController.contactPersonPhoneNumber.value.text =
        data[0]["contactPersonPhoneNumber"] == ""
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
  bool isLoading = false;
  Timer? _timer;
  @override
  void initState() {
    if (data[0] != null) assignFieldData();
    allProfilesListController.getAllLanguages();
    allProfilesListController.getAllCity();
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
      switch (allProfilesListController.rxRequestStatus.value) {
        case Status.loading:
          return const CustomLoading(
            color: Colors.orange,
            size: 13,
          );
        case Status.success:
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              key: scaffoldKey,
              appBar: CustomAppBar(
                centerTitle: true,
                leading: data[0] != null
                    ? IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: appTheme.whiteA700,
                        ),
                      )
                    : IconButton(
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
                          surfaceTintColor: appTheme.whiteA700,
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
                          padding: const EdgeInsets.only(
                              left: 10, top: 10, right: 10),
                          child: CustomDropdown(
                            labelText: 'Marital Status *',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Marital Status";
                              }
                              return null;
                            },
                            listName: materialStatus
                                .map((e) => e['title'].toString())
                                .toList(),
                            selectedItem:
                                allProfilesListController.meritalStatusValue,
                            onChng: (value) {
                              for (var element in materialStatus) {
                                if (element['title'] == value) {
                                  allProfilesListController.meritalStatus
                                      .value = element['id'].toString();
                                }
                              }
                              print(
                                  "meritalStatus ${allProfilesListController.meritalStatus}");
                            },
                          ),
                        ),
                        Visibility(
                          visible:
                              allProfilesListController.meritalStatus.value ==
                                      "2"
                                  ? false
                                  : true,
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.h),
                                  child: CustomTextFormField(
                                    readOnly: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return null;
                                      }
                                      // Parse the entered date of birth string into a DateTime object
                                      DateTime? enteredDate =
                                          DateTime.tryParse(value);

                                      if (enteredDate == null) {
                                        return "Invalid date format";
                                      }
                                      // Calculate the age by subtracting the entered date of birth from the current date
                                      int age = DateTime.now().year -
                                          enteredDate.year;

                                      // Check if the age is less than 18
                                      if (age < 18) {
                                        return "You must be 18 years or older";
                                      }

                                      return null;
                                    },
                                    controller: allProfilesListController
                                        .dateOfMarriage.value,
                                    labelText: "Date Of Marriage *",
                                    onTap: () {
                                      DateTimePickerController().selectDob1(
                                        allProfilesListController
                                            .dateOfMarriage.value,
                                      );
                                    },
                                    contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 18,
                                        bottom: 18),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.h),
                                  child: CustomDropdown(
                                    labelText: 'Have Children',
                                    listName: haveChildren
                                        .map((e) => e['title'].toString())
                                        .toList(),
                                    selectedItem: allProfilesListController
                                        .haveChildrenValue,
                                    onChng: (value) {
                                      for (var element in haveChildren) {
                                        if (element['title'] == value) {
                                          allProfilesListController
                                                  .haveChildren =
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.h),
                                  child: CustomTextFormField(
                                    prefix: Icon(
                                      Icons.child_care,
                                      color: appTheme.black900,
                                    ),
                                    controller: allProfilesListController
                                        .numberOfChildrenController.value,
                                    labelText: "No. Of Children",
                                    hintStyle:
                                        CustomTextStyles.titleSmallSemiBold_1,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return null;
                                      }
                                      if (!RegExp(r'^[0-9]{1,}$')
                                          .hasMatch(value)) {
                                        return "Please enter a valid numeric data";
                                      }
                                      return null;
                                    },
                                    contentPadding:
                                        const EdgeInsets.symmetric(),
                                  ),
                                ),
                              ],
                            ),
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
                            prefix: Icon(
                              Icons.line_weight,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .weightController.value,
                            labelText: "Weight *",
                            keyboardType: TextInputType.number,
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
                            prefix: Icon(
                              Icons.height,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .heightController.value,
                            labelText: "Height *",
                            keyboardType: TextInputType.number,
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
                            prefix: Icon(
                              Icons.type_specimen,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .bodyTypeController.value,
                            labelText: "Body Type (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter body type";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.face,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .complexionController.value,
                            labelText: "Face Complexion(Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter body complexion";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  prefix: Icon(
                                    Icons.person,
                                    color: appTheme.black900,
                                  ),
                                  controller: allProfilesListController
                                      .specialCasesController.value,
                                  labelText: "Special Cases(Optional)",
                                  hintStyle:
                                      CustomTextStyles.titleSmallSemiBold_1,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return "Please enter special cases (None/Physically/Mentally/Others)";
                                  //   }
                                  //   return null;
                                  // },
                                  contentPadding: const EdgeInsets.symmetric(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.bloodtype,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .bloodGroupController.value,
                            labelText: "Blood Group(Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter blood group (A+/B+/AB+/O+/A-/B-/AB-/O-)";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),

                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.food_bank,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .dieatryHabitsController.value,
                            labelText: "Dieatry Habits(Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter dieatry habits (Veg/Non Veg/Eggetarian) ";
                            //   }
                            //   return null;
                            // },
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
                            prefix: Icon(
                              Icons.recycling,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .religionController.value,
                            labelText: "Religion *",
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
                            prefix: Icon(
                              Icons.person_pin_circle_rounded,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .motherTongueController.value,
                            labelText: "Mother Tongue(Language)* ",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter mother tongue value";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.contacts_sharp,
                              color: appTheme.black900,
                            ),
                            controller:
                                allProfilesListController.casteController.value,
                            labelText: "Caste *",
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
                            prefix: Icon(
                              Icons.subdirectory_arrow_left,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .subCasteController.value,
                            labelText: "Sub Caste (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter sub caste value";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.crisis_alert_sharp,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .manglikController.value,
                            labelText: "Are You Managalik ? *",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please tell us are you mangalik";
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
                          child: Obx(() {
                            if (allProfilesListController
                                .languageList.isNotEmpty) {
                              List<Map<String, dynamic>> initiallySelectedIds =
                                  [];
                              // Iterate through initiallySelectedList and extract IDs
                              for (var item in allProfilesListController
                                  .selectedCheckBoxValue) {
                                // Ensure item is a map with "id" key
                                if (item is Map && item.containsKey("id")) {
                                  initiallySelectedIds
                                      .add({"id": item["id"].toString()});
                                }
                              }
                              return MultiselectDropdown(
                                title: 'Spoken Languages',
                                initiallySelectedList: initiallySelectedIds,
                                dropdownList:
                                    allProfilesListController.languageList,
                                compareData: 'id',
                                showData: 'name',
                                onChanged: (selectedItems) {
                                  allProfilesListController
                                      .selectedCheckBoxValue
                                      .clear();
                                  for (var item in selectedItems) {
                                    if (item is Map && item.containsKey("id")) {
                                      allProfilesListController
                                          .selectedCheckBoxValue
                                          .add({"id": item["id"].toString()});
                                    }
                                  }
                                },
                              );
                            } else {
                              // You might want to display a loading indicator or an empty state
                              return SizedBox();
                            }
                          }),
                        ),
                        const SizedBox(height: 13),
                        //Cities  DropDown List [1,2,3]
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 10.h),
                        //   child: Obx(() {
                        //     if (allProfilesListController.cityList.isNotEmpty) {
                        //       List<int> initiallySelectedIds = [];
                        //       // Iterate through initiallySelectedList and extract IDs
                        //       for (var item
                        //           in allProfilesListController.cityValue) {
                        //         // Ensure item is a map with "id" key
                        //         if (item is Map && item.containsKey("id")) {
                        //           initiallySelectedIds
                        //               .add(int.parse(item["id"].toString()));
                        //         }
                        //       }
                        //       return MultiselectDropdown(
                        //         title: 'Interested City',
                        //         initiallySelectedList: initiallySelectedIds,
                        //         dropdownList:
                        //             allProfilesListController.cityList,
                        //         compareData: 'id',
                        //         showData: 'name',
                        //         onChanged: (selectedItems) {
                        //           allProfilesListController.cityValue.clear();
                        //           for (var item in selectedItems) {
                        //             if (item is Map && item.containsKey("id")) {
                        //               // print("$item, item");
                        //               allProfilesListController.cityValue.add(
                        //                   int.parse(item["id"].toString()));
                        //             }
                        //             print(
                        //                 "item ${allProfilesListController.cityValue}");
                        //           }
                        //         },
                        //       );
                        //     } else {
                        //       // You might want to display a loading indicator or an empty state
                        //       return SizedBox();
                        //     }
                        //   }),
                        // ),

                        // city value [{"id":1},{ "id":2}]
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Obx(() {
                            if (allProfilesListController.cityList.isNotEmpty) {
                              List<Map<String, dynamic>> initiallySelectedIds =
                                  [];
                              // Iterate through initiallySelectedList and extract IDs
                              for (var item
                                  in allProfilesListController.cityValue) {
                                // Ensure item is a map with "id" key
                                if (item is Map && item.containsKey("id")) {
                                  initiallySelectedIds
                                      .add({"id": item["id"].toString()});
                                }
                              }
                              return MultiselectDropdown(
                                title: 'Interested City',
                                initiallySelectedList: initiallySelectedIds,
                                dropdownList:
                                    allProfilesListController.cityList,
                                compareData: 'id',
                                showData: 'name',
                                onChanged: (selectedItems) {
                                  allProfilesListController.cityValue.clear();
                                  for (var item in selectedItems) {
                                    if (item is Map && item.containsKey("id")) {
                                      allProfilesListController.cityValue
                                          .add({"id": item["id"].toString()});
                                    }
                                  }
                                },
                              );
                            } else {
                              // You might want to display a loading indicator or an empty state
                              return SizedBox();
                            }
                          }),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.radar_sharp,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .moonSignController.value,
                            labelText: "Moonsign (Rashi) *",
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
                            prefix: Icon(
                              Icons.star_sharp,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .nakshatraController.value,
                            labelText: "Nakshatra (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter nakshatra (star)";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.stars,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .astroprofileController.value,
                            labelText: "Astroprofile (Kundli Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter astroprofile (kundli) (Y/N / Don't Know)";
                            //   }
                            //   return null;
                            // },
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
                            prefix: Icon(
                              Icons.cast_for_education,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .educationController.value,
                            labelText: "Education Qualification *",
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
                            prefix: Icon(
                              Icons.business_center,
                              color: appTheme.black900,
                            ),
                            controller:
                                allProfilesListController.companyName.value,
                            labelText: "Company Name (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter company name";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.portrait_outlined,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .professionController.value,
                            labelText: "Profession *",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter profession";
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
                            prefix: Icon(
                              Icons.incomplete_circle,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .annualIncomeController.value,
                            labelText: "Annual Income *",
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
                            prefix: Icon(
                              Icons.face_6_sharp,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .nickNameController.value,
                            labelText: "Nickname",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter your nickname";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.family_restroom,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .familyValuesController.value,
                            labelText: "Family Values (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter family value Good/Bad ";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.face_4,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .motherNameController.value,
                            labelText: "Mother's Name (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter mother's name";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.tag_faces_sharp,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .fatherNameController.value,
                            labelText: "Father's Name (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter father's name";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.format_list_numbered_rtl_rounded,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .numberOfBrothersController.value,
                            labelText: "No. Of Siblings (Brothers Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
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
                            prefix: Icon(
                              Icons.numbers,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .numberOfSistersController.value,
                            labelText: "No. Of Siblings (Sisters Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
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
                            prefix: Icon(
                              Icons.keyboard,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .contactPersonPhoneNumber.value,
                            labelText: "Contact Person Phone Number *",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field cannot be empty.";
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
                            prefix: Icon(
                              Icons.contact_phone_rounded,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .contactPersonNameController.value,
                            labelText: "Contact Person Name (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter contact person name";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.real_estate_agent,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .relationshipController.value,
                            labelText: "Contact Person Relationship (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Enter contact person relationship with you";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.watch_later,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .timeToCallController.value,
                            labelText: "Convinient Time To Call (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Enter convinient time to call (Morning / Afternoon /Any Time)";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.place_outlined,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .placeOfBirthController.value,
                            labelText: "Place Of Birth (City & State Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter place of birth (city & state)";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),

                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.calendar_today,
                              color: appTheme.black900,
                            ),
                            readOnly: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter time of birth";
                              }
                              return null;
                            },
                            controller:
                                allProfilesListController.timeOfBirth.value,
                            labelText: "Time Of Birth(HH:MM) *",
                            onTap: () {
                              DateTimePickerController().selectTime(
                                  allProfilesListController.timeOfBirth.value);
                            },
                            contentPadding: const EdgeInsets.symmetric(),
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
                            prefix: Icon(
                              Icons.hot_tub_outlined,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .hobbiesController.value,
                            labelText: "Hobbies (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter hobbies";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.interpreter_mode_sharp,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .interestsController.value,
                            labelText: "Interests (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter interests";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.bookmark_added_sharp,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .favoriteReadsController.value,
                            labelText: "Favorite Reads (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter favorite reads";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.movie_sharp,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .preferredMoviesController.value,
                            labelText: "Preferred Movies",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter preferred movies";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.sports,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .sportsController.value,
                            labelText: "Sports (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter sports (Cricket/Football/Other)";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.food_bank_outlined,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .favoriteCuisineController.value,
                            labelText: "Favorite Cuisine (Optional)",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter favorite cuisine (North Indian/South Indian/Chinese/Thai/Mexican/Other)";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                            ),
                          ),
                        ),

                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.link,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .facebookLinkController.value,
                            labelText: "Facebook Profile Link",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter facebook profile link";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.link_outlined,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .linkedinUrlController.value,
                            labelText: "Linkedin Profile Link ",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please enter linkedin profile link";
                            //   }
                            //   return null;
                            // },
                            contentPadding: const EdgeInsets.symmetric(),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.wallet_membership_sharp,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .watsappNumberController.value,
                            labelText: "Watsapp Number *",
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter watsapp number";
                              } // Check if the entered value is numeric and has exactly 10 digits
                              if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                return "Please enter a 10-digit numeric phone number";
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
                            prefix: Icon(
                              Icons.info,
                              color: appTheme.black900,
                            ),
                            controller: allProfilesListController
                                .aboutYourselfController.value,
                            labelText: "About Yourself",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              } else if (value.trim().split(' ').length >= 20) {
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
                                color: appTheme.orange.withOpacity(0.5),
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
                                        ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.h),
                                  child: CustomElevatedButton(
                                    // isDisabled:
                                    //     allProfilesListController.isEdit.value,
                                    text: 'Upload',
                                    onTap: () {
                                      pickImage(1);
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
                                  color: appTheme.orange.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              allProfilesListController
                                                          .usersList2
                                                          .value
                                                          .downloadURL !=
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
                                  color: appTheme.orange.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                allProfilesListController
                                                            .usersList3
                                                            .value
                                                            .downloadURL !=
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
                        // Complete profile button
                        GetBuilder(
                            init: ImagePickerController(),
                            builder: (context) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: isLoading
                                        ? CustomLoading(
                                            color: appTheme.orange,
                                            size: 30,
                                          )
                                        : SizedBox(
                                            width: double.infinity,
                                            child: CustomElevatedButton(
                                              buttonStyle: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        appTheme.green600),
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
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    isLoading =
                                                        true; // Start loading

                                                    _timer = Timer(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      setState(() {
                                                        isLoading =
                                                            false; // Stop loading after 2 seconds
                                                        data[0] == null
                                                            ? allProfilesListController
                                                                .createProfile(
                                                                    imageUrl1,
                                                                    imageUrl2,
                                                                    imageUrl3)
                                                            : allProfilesListController
                                                                .updateProfile(
                                                                    imageUrl1,
                                                                    imageUrl2,
                                                                    imageUrl3,
                                                                    data[0]['id']
                                                                        .toString());
                                                      });
                                                    });
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

        default:
          return Container();
      }
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
}

//write  the code for adding two numbers in js.


