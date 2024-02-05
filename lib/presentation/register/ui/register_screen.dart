import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/time_formate_method.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
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
        data[0]["firstName"].toString();
    registerController.lastNameController.value.text =
        data[0]["lastName"].toString();
    registerController.emailController.value.text =
        data[0]["emailAddress"].toString();
    registerController.userTypeController.value.text =
        data[0]["userType"].toString();
    registerController.userNameController.value.text =
        data[0]["username"] == null
            ? "Username not found"
            : data[0]["username"].toString();
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

  String imageUrl = '';

// Gender list
  var gender = [
    {"id": "1", "title": "male"},
    {"id": "2", "title": "female"},
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
                    data == null ? _buildLogoSection() : Container(),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
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
                            style: CustomTextStyles.labelLargeBlack900,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        controller:
                            registerController.firstNameController.value,
                        labelText: "Firstname",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid name";
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
                        prefix: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        controller: registerController.lastNameController.value,
                        labelText: "Lastname",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid lastname";
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
                        prefix: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.black,
                        ),
                        controller: registerController.userNameController.value,
                        labelText: "Username",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid username";
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
                        prefix: const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
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
                        prefix: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.black,
                        ),
                        controller: registerController.userTypeController.value,
                        labelText: "Usertype",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid usertype";
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
                        prefix: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        controller: registerController.emailController.value,
                        labelText: "Email",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter email";
                          }

                          // Convert the email to lowercase
                          String lowercaseValue = value.toLowerCase();

                          // Check if the email contains the "@" character
                          if (!lowercaseValue.contains('@')) {
                            return "Please enter a valid email address";
                          }

                          // Check if the email contains any uppercase letters
                          if (value != lowercaseValue) {
                            return "Email should be correct";
                          }

                          return null;
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                              color: Colors.black,
                            ),
                          ),
                          prefix: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          controller:
                              registerController.passwordController.value,
                          labelText: "Password",
                          hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a valid password";
                            }

                            // Check if the password meets the required conditions
                            if (!RegExp(
                                    r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{5,}$')
                                .hasMatch(value)) {
                              return "Plase enter a correct password";
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
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller: registerController.phoneController.value,
                        labelText: "Phone Number",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a valid phone number";
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
                        prefix: const Icon(
                          Icons.place,
                          color: Colors.black,
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
                        prefixIcon: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.black,
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
                        prefixIcon: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.black,
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
                        prefixIcon: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.red,
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
                      child: GetBuilder<ImagePickerController>(
                          init: ImagePickerController(),
                          builder: (value) {
                            return Container(
                              width: size.width,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.orange.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 70.h,
                                      height: 70.v,
                                      child: imagePickerController.result !=
                                              null
                                          ? CircleAvatar(
                                              backgroundImage: FileImage(
                                                imagePickerController.result!,
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                registerController
                                                            .usersList
                                                            .value
                                                            .downloadURL !=
                                                        null
                                                    ? ApiNetwork.imageUrl +
                                                        registerController
                                                            .usersList
                                                            .value
                                                            .downloadURL!
                                                    : ImageConstant.fakeProfile,
                                              ),
                                            )),
                                  CustomElevatedButton(
                                    // isDisabled:
                                    //     registerController.isEdit.value,
                                    text: 'Upload',
                                    onTap: () {
                                      imagePickerController.pickImage();
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 10),
                    _buildLoginButtonSection(),
                    data != null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 10,
                              bottom: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Already have a member ?",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: appTheme.black900,
                                  ),
                                ),
                                Column(
                                  children: [
                                    CustomElevatedButton(
                                      buttonStyle: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                appTheme.headerColor),
                                      ),
                                      text: "Login",
                                      buttonTextStyle:
                                          CustomTextStyles.titleMediumBlackA700,
                                      onTap: () {
                                        Get.toNamed(
                                          AppRoutes.loginScreen,
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
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

  /// Section Widget
  Widget _buildLoginButtonSection() {
    return GetBuilder(
        init: ImagePickerController(),
        builder: (context) {
          return registerController.rxRequestStatus.value == Status.loading
              ? CustomLoading(
                  color: appTheme.orange,
                  size: 20,
                )
              : CustomElevatedButton(
                  buttonStyle: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(appTheme.green600),
                  ),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        data == null
                            ? registerController
                                .register(imagePickerController.imageUrl)
                            : registerController.updateUserDetails(
                                imagePickerController.imageUrl,
                                data[0]["id"].toString());
                      });
                    }
                  },
                  text: "Submit".tr,
                  margin: EdgeInsets.only(
                    left: 10.h,
                    right: 10.h,
                    bottom: 10.v,
                  ),
                );
        });
  }
}
