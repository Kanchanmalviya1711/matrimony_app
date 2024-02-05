import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/allProfiles/controller/allProfiles_controller.dart';
import 'package:matrimony_app/presentation/allProfiles/ui/allProfiles.form.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/size_utils.dart';

class AllProfilesFilter extends StatefulWidget {
  const AllProfilesFilter({
    super.key,
  });
  @override
  State<AllProfilesFilter> createState() => _AllProfilesFilterFilterState();
}

class _AllProfilesFilterFilterState extends State<AllProfilesFilter> {
  AllProfilesListController allProfilesListController =
      Get.put(AllProfilesListController());

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
          padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 30.v),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.v,
                ),
                const AllProfilesForm(),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: appTheme.red600D8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Get.back();
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
                          Get.toNamed(AppRoutes.allProfilesScreen);
                        },
                        child: const Text("Apply Filter",
                            style: TextStyle(color: Colors.white)))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
