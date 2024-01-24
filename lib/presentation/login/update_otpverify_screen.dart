import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/widgets/custom_circuler_loader.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_linear_loader.dart';
import 'package:matrimony_app/widgets/custom_text_form_field.dart';
import 'controller/login_controller.dart';

class UpdateOtpVerifyScreen extends StatefulWidget {
  const UpdateOtpVerifyScreen({Key? key}) : super(key: key);
  @override
  State<UpdateOtpVerifyScreen> createState() => _UpdateOtpVerifyScreenState();
}

class _UpdateOtpVerifyScreenState extends State<UpdateOtpVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  late LoginController controller;

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
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => controller.rxRequestStatus.value == Status.loading
                        ? const CustomLinearLoader()
                        : Container(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Verify OTP",
                              style: TextStyle(
                                  color: appTheme.black900,
                                  fontSize: 25,
                                  fontWeight: FontWeight
                                      .bold // Adjust font size as needed
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        CustomTextFormField(
                          prefix: const Icon(
                            Icons.numbers_outlined,
                            color: Colors.black,
                          ),
                          controller: controller.reserOTP.value,
                          labelText: "Enter OTP",
                          hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter valid OTP";
                            }
                            return null;
                          },
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => CustomTextFormField(
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
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            prefix: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            controller: controller.passwordController.value,
                            labelText: "New Password",
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
                        const SizedBox(height: 20),
                        Obx(
                          () => CustomTextFormField(
                            obscureText:
                                controller.isConfirmPasswordVisible.value,
                            suffix: CustomIconButton(
                              onTap: () {
                                controller.togglePasswordVisibility();
                              },
                              child: Icon(
                                controller.isConfirmPasswordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: controller.isConfirmPasswordVisible.value
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            prefix: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            controller: controller.newPassword.value,
                            labelText: "Confirm New Password",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter valid new password";
                              }
                              return null;
                            },
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        controller.rxRequestStatus.value == Status.loading
                            ? const CustomLoading()
                            : CustomElevatedButton(
                                buttonStyle: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green),
                                ),
                                text: "Submit",
                                buttonTextStyle: TextStyle(
                                  color: appTheme.whiteA700,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.verifyOtp();
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
