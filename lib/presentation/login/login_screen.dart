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
import 'package:matrimony_app/widgets/custom_linear_loader.dart';
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
              Obx(
                () => controller.rxRequestStatus.value == Status.loading
                    ? const CustomLinearLoader()
                    : Container(),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 39),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.logoImg,
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          "Welcom to India's Best Matrimony App",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Sign In to your account",
                          style: CustomTextStyles.titleMedium16,
                        ),
                        const SizedBox(height: 40),
                        CustomTextFormField(
                          prefix: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          controller: controller.emailController.value,
                          labelText: "Email",
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
                                    : const Color.fromARGB(255, 103, 199, 106),
                              ),
                            ),
                            prefix: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            controller: controller.passwordController.value,
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
                        const SizedBox(height: 20),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot Password",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        controller.rxRequestStatus.value == Status.loading
                            ? const CustomLoading()
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
                                    controller.login();
                                  }
                                },
                              ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            const Text("Don't have an account ?"),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              child: CustomElevatedButton(
                                buttonStyle: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      appTheme.green600),
                                ),
                                text: "Join Now",
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.registerScreen,
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
