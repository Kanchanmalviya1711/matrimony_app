import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/controller/profileLists_controller.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_text_form_field.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});
  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  ProfileListController profileListController =
      Get.put(ProfileListController());

  @override
  void initState() {
    profileListController.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter name";
            }
            return null;
          },
          controller: profileListController.firstName.value,
          labelText: "Name",
        ),
        SizedBox(height: 5.v),
      ],
    );
  }
}
