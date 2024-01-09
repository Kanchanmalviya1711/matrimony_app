import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/presentation/allProfiles/controller/allProfiles_controller.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_dropdown.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_text_form_field.dart';
import 'package:matrimony_app/widgets/datetime_controller.dart';
import 'package:matrimony_app/widgets/image_picker.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);
  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  AllProfilesListController allProfilesListController =
      Get.put(AllProfilesListController());

  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

// haveChildren list
  var haveChildren = [
    {"id": "0", "title": "Yes"},
    {"id": "1", "title": "No"},
  ];
  // materialStatus list
  var materialStatus = [
    {"id": "1", "title": "Married"},
    {"id": "2", "title": "Unmarried"},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return SafeArea(
        child: Scaffold(
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
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Complete Your Profile".tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.labelLargeBlack900,
                      ),
                    ),
                    SizedBox(height: 25.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
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
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomDropdown(
                        labelText: 'Have Children',
                        listName: haveChildren
                            .map((e) => e['title'].toString())
                            .toList(),
                        selectedItem:
                            allProfilesListController.haveChildrenValue,
                        onChng: (value) {
                          for (var element in haveChildren) {
                            if (element['title'] == value) {
                              allProfilesListController.haveChildren =
                                  element['id'].toString();
                            }
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.black,
                        ),
                        controller: allProfilesListController
                            .numberOfChildrenController,
                        labelText: "No. Of Children",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid no. of children value";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        controller: allProfilesListController.weightController,
                        labelText: "Weight",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter weight value";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.black,
                        ),
                        controller: allProfilesListController.heightController,
                        labelText: "Height",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter height value";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.bodyTypeController,
                        labelText: "Body Type",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter body type";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.complexionController,
                        labelText: "Body Complexion",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter body complexion";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.religionController,
                        labelText: "Religion",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid email";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.specialCasesController,
                        labelText: "Special Cases",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid email";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.motherTongueController,
                        labelText: "Mother Tongue",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller: allProfilesListController.casteController,
                        labelText: "Caste",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter caste";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.subCasteController,
                        labelText: "Sub Caste",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller: allProfilesListController.manglikController,
                        labelText: "Are You Managalik ?",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter text";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.familyValuesController,
                        labelText: "Family Values",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.educationController,
                        labelText: "Education Qualification",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.professionController,
                        labelText: "Profession",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.dieatryHabitsController,
                        labelText: "Dieatry Habits",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.aboutYourselfController,
                        labelText: "About Yourself",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.h),
                      child: CustomTextFormField(
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter date of Marriage";
                          }
                          return null;
                        },
                        controller:
                            allProfilesListController.dateOfMarriage.value,
                        labelText: "Date Of Birth",
                        onTap: () {
                          DateTimePickerController().selectDob(
                              allProfilesListController.dateOfMarriage.value);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.bloodGroupController,
                        labelText: "Blood Group",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.annualIncomeController,
                        labelText: "Annual Income",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller: allProfilesListController
                            .numberOfBrothersController,
                        labelText: "No. Of Siblings (Brothers)",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.numberOfSistersController,
                        labelText: "No. Of Siblings (Sisters)",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller: allProfilesListController
                            .contactPersonNameController,
                        labelText: "Contact Person Name",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.relationshipController,
                        labelText: "Contact Person Relationship",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.timeToCallController,
                        labelText: "Convinient Time To Call",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.placeOfBirthController,
                        labelText: "Place Of Birth (City & State)",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.timeOFBirthController,
                        labelText: "Time Of Birth (HH:MM AM/PM)",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller: allProfilesListController.hobbiesController,
                        labelText: "Hobbies",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.interestsController,
                        labelText: "Interests",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.favoriteReadsController,
                        labelText: "Favorite Reads",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.preferredMoviesController,
                        labelText: "Preferred Movies",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller: allProfilesListController.sportsController,
                        labelText: "Sports",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.favoriteCuisineController,
                        labelText: "Favorite Cuisine",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.spokenLanguagesController,
                        labelText: "Spoken Languages",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.moonSignController,
                        labelText: "Moonsign (Rashi)",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.nakshatraController,
                        labelText: "Nakshatra",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.astroprofileController,
                        labelText: "Astroprofile (Kundli)",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.motherNameController,
                        labelText: "Mother's Name ",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.fatherNameController,
                        labelText: "Father's Name ",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.facebookLinkController,
                        labelText: "Facebook Profile Link",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.linkedinUrlController,
                        labelText: "Linkedin Profile Link",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller:
                            allProfilesListController.watsappNumberController,
                        labelText: "Watsapp Number",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid phone number";
                          }
                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 1 image picker
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: GetBuilder<ImagePickerController>(
                          init: ImagePickerController(),
                          builder: (value) {
                            return Container(
                              width: size.width,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: 100.h,
                                      height: 100.v,
                                      child: imagePickerController.result !=
                                              null
                                          ? CircleAvatar(
                                              backgroundImage: FileImage(
                                                imagePickerController.result!,
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                allProfilesListController
                                                            .usersList
                                                            .value
                                                            .downloadURL !=
                                                        null
                                                    ? ApiNetwork.imageUrl +
                                                        allProfilesListController
                                                            .usersList
                                                            .value
                                                            .downloadURL!
                                                    : ImageConstant.fakeProfile,
                                              ),
                                            )),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.h),
                                      child: CustomElevatedButton(
                                        // isDisabled:
                                        //     allProfilesListController.isEdit.value,
                                        text: 'Upload',
                                        onTap: () {
                                          imagePickerController.pickImage();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 10),
                    // 2 image picker
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: GetBuilder<ImagePickerController>(
                          init: ImagePickerController(),
                          builder: (value) {
                            return Container(
                              width: size.width,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: 100.h,
                                      height: 100.v,
                                      child: imagePickerController.result !=
                                              null
                                          ? CircleAvatar(
                                              backgroundImage: FileImage(
                                                imagePickerController.result!,
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
                                            )),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.h),
                                      child: CustomElevatedButton(
                                        // isDisabled:
                                        //     allProfilesListController.isEdit.value,
                                        text: 'Upload',
                                        onTap: () {
                                          imagePickerController.pickImage();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 10),
                    // 3 image picker

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: GetBuilder<ImagePickerController>(
                          init: ImagePickerController(),
                          builder: (value) {
                            return Container(
                              width: size.width,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: 100.h,
                                      height: 100.v,
                                      child: imagePickerController.result !=
                                              null
                                          ? CircleAvatar(
                                              backgroundImage: FileImage(
                                                imagePickerController.result!,
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
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.h),
                                      child: CustomElevatedButton(
                                        // isDisabled:
                                        //     allProfilesListController.isEdit.value,
                                        text: 'Upload',
                                        onTap: () {
                                          imagePickerController.pickImage();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 10),
                    _buildLoginButtonSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  /// Section Widget
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
          return CustomElevatedButton(
            buttonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(appTheme.green600),
            ),
            onTap: () {
              allProfilesListController
                  .createProfile(imagePickerController.imageUrl);
            },
            text: "Submit".tr,
            margin: EdgeInsets.only(
              left: 23.h,
              right: 23.h,
              bottom: 20.v,
            ),
          );
        });
  }
}
