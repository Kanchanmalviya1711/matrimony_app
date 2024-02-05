import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matrimony_app/presentation/allProfiles/controller/allProfiles_controller.dart';
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
        CustomTextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter Caste";
            }
            return null;
          },
          controller: allProfilesListController.casteController.value,
          labelText: "Caste",
          onTap: () {},
        ),
        SizedBox(height: 20.v),
      ],
    );
  }
}
