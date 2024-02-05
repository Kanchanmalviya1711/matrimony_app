import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/widgets/custom_circuler_loader.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_linear_loader.dart';
import 'package:matrimony_app/widgets/custom_text_form_field.dart';
import 'controller/login_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                              "Reset Password",
                              style: TextStyle(
                                  color: appTheme.black900,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
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
                        controller.rxRequestStatus.value == Status.loading
                            ? const CustomLoading(
                                color: Colors.green,
                                size: 50,
                              )
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
                                    controller.resetPassword();
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
