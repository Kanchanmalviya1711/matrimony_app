import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/controller/profileLists_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_text_form_field.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});
  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  ProfileListController profileListController =
      Get.put(ProfileListController());

  // @override
  // void initState() {
  //   profileListController.getUsers();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter name";
              }
              return null;
            },
            controller: profileListController.name.value,
            labelText: "Name",
          ),
          SizedBox(height: 5.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: appTheme.red600D8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  profileListController.clearInputField();
                  Get.back(closeOverlays: true);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: appTheme.whiteA700),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: appTheme.blue1600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print(profileListController.name.value.text);
                    Get.offAllNamed(AppRoutes.homeScreen,
                        arguments: [1, profileListController.name.value.text]);
                  }
                },
                child: Text(
                  "Apply Filter",
                  style: TextStyle(color: appTheme.whiteA700),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
