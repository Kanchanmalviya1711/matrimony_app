import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/time_formate_method.dart';
import 'package:matrimony_app/presentation/register/controller/resgister_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_circuler_loader.dart';
import 'package:matrimony_app/widgets/custom_dropdown.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_text_form_field.dart';
import 'package:matrimony_app/widgets/datetime_controller.dart';
import 'package:matrimony_app/widgets/image_picker.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  RegisterController registerController = Get.put(RegisterController());

  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  final data = Get.arguments;

  assignFieldData() {
    print("payload ${data}");
    registerController.firstNameController.value.text =
        data[0]["fullName"].toString();
    registerController.emailController.value.text =
        data[0]["emailAddress"].toString();
    registerController.userTypeController.value.text =
        data[0]["userType"].toString();

    registerController.addressController.value.text =
        data[0]["address"].toString();
    String passwordText = data[0]["password"].toString() != null
        ? "Enter password"
        : "Password not found";
    registerController.passwordController.value.text = passwordText;
    registerController.genderType = data[0]["gender"] == 1 ? "Male" : "Female";
    registerController.dateOfBirth.value.text = data[0]["dateOfBirth"] == null
        ? ""
        : TimeFormateMethod().getTimeFormate(
            time: data[0]["dateOfBirth"].toString(), formate: 'yyyy-MM-dd');
    registerController.phoneController.value.text = data[0]["phone"].toString();
    registerController.subscriptionTypeValue = data[0]["subscriptionType"] == 1
        ? "free"
        : data[0]["subscriptionType"] == 2
            ? "gold"
            : "platinum";
    registerController.interestedGenderTypeValue = data[0]["genderIntrest"] == 1
        ? "male"
        : data[0]["genderIntrest"] == 2
            ? "female"
            : "both";

    registerController.statusValue =
        data[0]["status"] == 1 ? "active" : "inactive";
    registerController.gender = data[0]?["gender"].toString() ?? '';
    registerController.subscriptionType =
        data[0]?["subscriptionType"].toString() ?? '';
    registerController.status = data[0]?["status"].toString() ?? '';
    registerController.usersList.value.downloadURL =
        data[0]["imagePath"].toString();
    imageUrl = data[0]["imagePath"].toString();
  }

  File? result1;
  String imageUrl = '';

  Future<void> pickImage(result) async {
    print("result $result");
    try {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var res = File(image.path);
        if (result == 1) {
          result1 = res;
          imageUrl = await uploadFile(result1!);
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

// Gender list
  var gender = [
    {"id": "1", "title": "male"},
    {"id": "2", "title": "female"},
  ];
  // Gender list
  var interestedGender = [
    {"id": "1", "title": "male"},
    {"id": "2", "title": "female"},
    {"id": "3", "title": "both"},
  ];
  // status list
  var status = [
    {"id": "1", "title": "active"},
    {"id": "2", "title": "inactive"},
  ];
  // SuscriptionType list
  var subscriptionType = [
    {"id": "1", "title": "free"},
    {"id": "2", "title": "gold"},
    {"id": "3", "title": "platinum"},
  ];

  @override
  void initState() {
    print("data initstate ${data}");
    if (data != null) assignFieldData();
    super.initState();
  }

  bool isLoading = false;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  data == null
                      ? _buildLogoSection()
                      : const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: data != null
                              ? Icon(
                                  Icons.arrow_back_ios,
                                  color: appTheme.headerColor,
                                )
                              : Container(),
                        ),
                        Text(
                          data == null
                              ? "Register New Member".tr
                              : "Update User Details".tr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 27,
                            color: appTheme.black900,
                            fontWeight: FontWeight.w500,
                            // Add this line
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: Icon(
                        Icons.person,
                        color: appTheme.black900,
                      ),
                      controller: registerController.firstNameController.value,
                      labelText: "Fullname",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your fullname";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      readOnly: true,
                      prefix: Icon(
                        Icons.calendar_today,
                        color: appTheme.black900,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter date of birth";
                        }
                        // Parse the entered date of birth string into a DateTime object
                        DateTime? enteredDate = DateTime.tryParse(value);

                        if (enteredDate == null) {
                          return "Invalid date format";
                        }
                        // Calculate the age by subtracting the entered date of birth from the current date
                        int age = DateTime.now().year - enteredDate.year;

                        // Check if the age is less than 18
                        if (age < 18) {
                          return "You must be 18 years or older";
                        }

                        return null;
                      },
                      controller: registerController.dateOfBirth.value,
                      labelText: "Date Of Birth",
                      onTap: () {
                        DateTimePickerController()
                            .selectDob(registerController.dateOfBirth.value);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: Icon(
                        Icons.person_2_rounded,
                        color: appTheme.black900,
                      ),
                      controller: registerController.userTypeController.value,
                      labelText: "Usertype",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return "Please enter a valid usertype with at least 5 characters";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: Icon(
                        Icons.email,
                        color: appTheme.black900,
                      ),
                      controller: registerController.emailController.value,
                      labelText: "Email",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter email";
                        }
                        String lowercaseValue = value.toLowerCase();
                        if (!lowercaseValue.contains('@')) {
                          return "Please enter a valid email address";
                        }
                        // Call a function to check if the email already exists
                        // String emailExists = value.toLowerCase();

                        // if (emailExists == value) {
                        //   return "This email is already registered";
                        // }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (data == null)
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomTextFormField(
                          obscureText:
                              registerController.isPasswordVisible.value,
                          suffix: CustomIconButton(
                            onTap: () {
                              registerController.togglePasswordVisibility();
                            },
                            child: Icon(
                              registerController.isPasswordVisible.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: appTheme.black900,
                            ),
                          ),
                          prefix: Icon(
                            Icons.lock,
                            color: appTheme.black900,
                          ),
                          controller:
                              registerController.passwordController.value,
                          labelText: "Password",
                          hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter password";
                            }
                            // Check if the password meets the required conditions
                            if (!RegExp(
                                    r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{5,}$')
                                .hasMatch(value)) {
                              return "Please enter valid password Eg.(Abc@123)";
                            }
                            return null;
                          },
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 18,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  if (data == null)
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomTextFormField(
                          obscureText:
                              registerController.isConfirmPassword.value,
                          suffix: CustomIconButton(
                            onTap: () {
                              registerController
                                  .toggleConfimPasswordVisibility();
                            },
                            child: Icon(
                              registerController.isConfirmPassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: appTheme.black900,
                            ),
                          ),
                          prefix: Icon(
                            Icons.lock,
                            color: appTheme.black900,
                          ),
                          controller: registerController
                              .confirmPasswordController.value,
                          labelText: "Confirm Password",
                          hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter confirm password";
                            }
                            // Check if the password matches the confirm password
                            if (value !=
                                registerController
                                    .passwordController.value.text) {
                              return "Passwords do not match";
                            }

                            return null;
                          },
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 18,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: Icon(
                        Icons.keyboard,
                        color: appTheme.black900,
                      ),
                      controller: registerController.phoneController.value,
                      labelText: "Phone Number",
                      keyboardType: TextInputType.number,
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your phone number";
                        }
                        // Check if the entered value is numeric and has exactly 10 digits
                        if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return "Please enter a 10-digit numeric phone number";
                        }

                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomTextFormField(
                      prefix: Icon(
                        Icons.place,
                        color: appTheme.black900,
                      ),
                      controller: registerController.addressController.value,
                      labelText: "Complete Address",
                      hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your address";
                        }
                        return null;
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomDropdown(
                      labelText: 'Suscription Type',
                      prefixIcon: Icon(
                        Icons.person_2_rounded,
                        color: appTheme.black900,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please select suscription type";
                        }
                        return null;
                      },
                      listName: subscriptionType
                          .map((e) => e['title'].toString())
                          .toList(),
                      selectedItem: registerController.subscriptionTypeValue,
                      onChng: (value) {
                        for (var element in subscriptionType) {
                          if (element['title'] == value) {
                            registerController.subscriptionType =
                                element['id'].toString();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomDropdown(
                      labelText: 'Status',
                      prefixIcon: Icon(
                        Icons.person_2_rounded,
                        color: appTheme.black900,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please select status";
                        }
                        return null;
                      },
                      listName:
                          status.map((e) => e['title'].toString()).toList(),
                      selectedItem: registerController.statusValue,
                      onChng: (value) {
                        for (var element in status) {
                          if (element['title'] == value) {
                            registerController.status =
                                element['id'].toString();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomDropdown(
                      labelText: 'Gender',
                      prefixIcon: Icon(
                        Icons.person_2_rounded,
                        color: appTheme.red600D8,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please select gender";
                        }
                        return null;
                      },
                      listName:
                          gender.map((e) => e['title'].toString()).toList(),
                      selectedItem: registerController.genderType,
                      onChng: (value) {
                        for (var element in gender) {
                          if (element['title'] == value) {
                            registerController.gender =
                                element['id'].toString();
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 5),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomDropdown(
                      labelText: 'Which gender you are interested ?',
                      prefixIcon: Icon(
                        Icons.person_2_rounded,
                        color: appTheme.red600D8,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Which gender you are interested ?";
                        }
                        return null;
                      },
                      listName: interestedGender
                          .map((e) => e['title'].toString())
                          .toList(),
                      selectedItem:
                          registerController.interestedGenderTypeValue,
                      onChng: (value) {
                        for (var element in interestedGender) {
                          if (element['title'] == value) {
                            registerController.interestedGenderType =
                                element['id'].toString();
                          }
                        }
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 10.h),
                  //   child: CustomDropdown(
                  //     labelText: 'Which gender you are interested ?',
                  //     prefixIcon: Icon(
                  //       Icons.person_2_rounded,
                  //       color: appTheme.red600D8,
                  //     ),
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return "Please select interested gender";
                  //       }
                  //       return null;
                  //     },
                  //     listName: interestedGender
                  //         .map((e) => e['title'].toString())
                  //         .toList(),
                  //     selectedItem:
                  //         registerController.interestedGenderTypeValue,
                  //     onChng: (value) {
                  //       for (var element in interestedGender) {
                  //         if (element['title'] == value) {
                  //           registerController.interestedGenderType =
                  //               element['id'].toString();
                  //         }
                  //       }
                  //     },
                  //   ),
                  // ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: GetBuilder<ImagePickerController>(
                        init: ImagePickerController(),
                        builder: (value) {
                          return Container(
                            width: size.width,
                            padding: const EdgeInsets.all(5),
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
                                            registerController.usersList.value
                                                        .downloadURL !=
                                                    null
                                                ? ApiNetwork.imageUrl +
                                                    registerController.usersList
                                                        .value.downloadURL!
                                                : ImageConstant.fakeProfile,
                                          ),
                                        ),
                                ),
                                CustomElevatedButton(
                                    width: 200,
                                    // isDisabled:
                                    //     registerController.isEdit.value,
                                    text: 'Image Upload',
                                    onTap: () {
                                      pickImage(1);
                                    }),
                              ],
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder(
                      init: ImagePickerController(),
                      builder: (context) {
                        return isLoading
                            ? CustomLoading(
                                color: appTheme.orange,
                                size: 30,
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: CustomElevatedButton(
                                  buttonStyle: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        appTheme.green600),
                                  ),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;

                                        // Start loading

                                        _timer = Timer(
                                            const Duration(seconds: 2), () {
                                          setState(() {
                                            isLoading =
                                                false; // Stop loading after 2 seconds
                                            data == null
                                                ? registerController.register(
                                                    imageUrl,
                                                  )
                                                : registerController
                                                    .updateUserDetails(
                                                        imageUrl,
                                                        data[0]["id"]
                                                            .toString());
                                          });
                                        });
                                      });
                                    }
                                  },
                                  text: "Submit".tr,
                                  margin: EdgeInsets.only(
                                    left: 10.h,
                                    right: 10.h,
                                    bottom: 10.v,
                                  ),
                                ),
                              );
                      }),
                  data != null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have a member ?",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: appTheme.black900,
                                ),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.loginScreen,
                                  );
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: appTheme.blue1600,
                                    fontWeight: FontWeight.bold,
                                    decorationColor: appTheme.blue1600,
                                    decoration: TextDecoration
                                        .underline, // Add this line
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                ],
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
                horizontal: 23.h,
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
