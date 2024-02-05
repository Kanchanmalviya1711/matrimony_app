import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/controller/profileLists_controller.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/ui/profileListForm.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/size_utils.dart';

class ProfileListFilter extends StatefulWidget {
  const ProfileListFilter({
    super.key,
  });
  @override
  State<ProfileListFilter> createState() => _ProfileListFilterState();
}

class _ProfileListFilterState extends State<ProfileListFilter> {
  ProfileListController profileListController =
      Get.put(ProfileListController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(alignment: Alignment.center, children: [
      Container(
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey.withOpacity(0.1)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.v),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileForm(),
                SizedBox(
                  height: 5.v,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: appTheme.red600D8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          Get.back();
                          profileListController.clearInputField();
                        },
                        child: const Text("Cancel",
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(
                        width: 10.v,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: appTheme.blue1600,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "Apply Filter",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
