import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/presentation/register/controller/resgister_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
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
                    _buildLogoSection(),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Register New Member".tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.labelLargeBlack900,
                      ),
                    ),
                    SizedBox(height: 25.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.black,
                        ),
                        controller: registerController.firstNameController,
                        labelText: "Enter firstname",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid name";
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
                        prefix: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        controller: registerController.lastNameController,
                        labelText: "Enter lastname",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid lastname";
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
                        prefix: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.black,
                        ),
                        controller: registerController.userNameController,
                        labelText: "Enter Username",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid username";
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
                        prefix: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.black,
                        ),
                        controller: registerController.userTypeController,
                        labelText: "Enter Usertype",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid usertype";
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
                        prefix: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.black,
                        ),
                        controller: registerController.addressController,
                        labelText: "Enter address",
                        hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid address";
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
                        prefix: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        controller: registerController.emailController,
                        labelText: "Enter email",
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
                      padding: EdgeInsets.symmetric(horizontal: 23.h),
                      child: Obx(
                        () => CustomTextFormField(
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
                              color: registerController.isPasswordVisible.value
                                  ? Colors.black
                                  : Colors.black54,
                            ),
                          ),
                          prefix: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          controller: registerController.passwordController,
                          labelText: "Password",
                          hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter valid password";
                            }
                            return null;
                          },
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.h),
                      child: CustomTextFormField(
                        prefix: const Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        controller: registerController.phoneController,
                        labelText: "Phone Number",
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
                            return "Please enter date of birth";
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.h),
                      child: CustomDropdown(
                        labelText: 'Suscription Type',
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
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.h),
                      child: CustomDropdown(
                        labelText: 'Status',
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
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.h),
                      child: CustomDropdown(
                        labelText: 'Gender',
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
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.h),
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
                                      width: 130.h,
                                      height: 130.v,
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
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.h),
                                      child: CustomElevatedButton(
                                        // isDisabled:
                                        //     registerController.isEdit.value,
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Already have a member ?",
                              style: TextStyle(
                                fontSize: 13,
                                color: appTheme.black900,
                              ),
                            ),
                            Column(children: [
                              CustomElevatedButton(
                                buttonStyle: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
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
                            ])
                          ]),
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
          return CustomElevatedButton(
            buttonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(appTheme.green600),
            ),
            onTap: () {
              registerController.register(imagePickerController.imageUrl);
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
