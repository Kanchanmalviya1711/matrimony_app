import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_circuler_loader.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_text_form_field.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late LoginController controller;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    controller = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Obx(() {
                return Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.logoImg,
                            width: 300,
                          ),
                          const SizedBox(height: 25),
                          Text(
                            "Welcome to India's Best Matrimony App",
                            style: TextStyle(
                              fontSize: 15,
                              color: appTheme.black900,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Sign In to your account",
                            style: CustomTextStyles.titleMedium16,
                          ),
                          const SizedBox(height: 40),
                          CustomTextFormField(
                            prefix: Icon(
                              Icons.email,
                              color: appTheme.black900,
                            ),
                            controller: controller.emailController.value,
                            labelText: "Email",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
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
                          const SizedBox(height: 10),
                          CustomTextFormField(
                            obscureText: controller.isPasswordVisible.value,
                            suffix: CustomIconButton(
                              onTap: () {
                                controller.togglePasswordVisibility();
                              },
                              child: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: controller.isPasswordVisible.value
                                    ? appTheme.black900
                                    : appTheme.green600,
                              ),
                            ),
                            prefix: Icon(
                              Icons.lock,
                              color: appTheme.black900,
                            ),
                            controller: controller.passwordController.value,
                            labelText: "Password",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              }
                              // Check if the password meets the required conditions
                              if (!RegExp(
                                      r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{5,}$')
                                  .hasMatch(value)) {
                                return "Please enter valid password";
                              }
                              return null;
                            },
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.forgotPasswordScreen,
                                  );
                                },
                                child: Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: appTheme.black900,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          controller.rxRequestStatus.value == Status.loading
                              ? CustomLoading(
                                  color: appTheme.orange,
                                  size: 30,
                                )
                              : CustomElevatedButton(
                                  buttonStyle: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        appTheme.black900),
                                  ),
                                  text: "Sign In",
                                  buttonTextStyle:
                                      CustomTextStyles.titleMediumBlackA700,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        controller.login();
                                      });
                                    }
                                  },
                                ),
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              const Text("Don't have an account ?"),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: appTheme.green600,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                  ),
                                  child: isLoading
                                      ? CustomLoading(
                                          color: appTheme.whiteA700,
                                          size: 22,
                                        )
                                      : Text(
                                          "Become a Member",
                                          style: TextStyle(
                                              color: appTheme.whiteA700,
                                              fontSize: 15),
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Get.toNamed(
                                      AppRoutes.registerScreen,
                                    );
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
