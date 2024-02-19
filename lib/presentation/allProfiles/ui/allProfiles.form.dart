import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/allProfiles/controller/allProfiles_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_text_form_field.dart';

class AllProfilesForm extends StatefulWidget {
  const AllProfilesForm({super.key});
  @override
  State<AllProfilesForm> createState() => _AllProfilesFormState();
}

class _AllProfilesFormState extends State<AllProfilesForm> {
  AllProfilesListController allProfilesListController =
      Get.put(AllProfilesListController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Search Profile",
          style: TextStyle(
              color: appTheme.headerColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter caste";
            }
            return null;
          },
          controller: allProfilesListController.casteController.value,
          labelText: "Caste",
        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter religion";
            }
            return null;
          },
          controller: allProfilesListController.religionController.value,
          labelText: "Religion",
        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter age";
            }
            return null;
          },
          controller: allProfilesListController.age.value,
          labelText: "Age",
        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter city";
            }
            return null;
          },
          controller: allProfilesListController.placeOfBirthController.value,
          labelText: "City",
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: appTheme.red600D8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                allProfilesListController.clearInputField();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: appTheme.blue1600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Get.offAndToNamed(AppRoutes.allProfilesScreen);
              },
              child: const Text(
                "Apply Filter",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
}
