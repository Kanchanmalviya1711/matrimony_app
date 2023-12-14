import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: appTheme.black900,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/logowhite.png',
                    color: appTheme.whiteA700,
                  ),
                ),
              ],
            ),
          ),
          DrawerListTile(
            title: "Home",
            svgSrc: ImageConstant.dashboardIcon,
            press: () {
              Get.toNamed(AppRoutes.homeScreen);
            },
          ),
          DrawerListTile(
            title: "About",
            svgSrc: ImageConstant.eventCalander,
            press: () {
              Get.toNamed(AppRoutes.aboutScreen);
            },
          ),
          DrawerListTile(
            title: "Blog",
            svgSrc: ImageConstant.contact,
            press: () {},
          ),
          DrawerListTile(
            title: "Testimonial",
            svgSrc: ImageConstant.contact,
            press: () {
              Get.toNamed(AppRoutes.testimonialsScreen);
            },
          ),
          DrawerListTile(
            title: "All Profiles",
            svgSrc: ImageConstant.contact,
            press: () {
              Get.offAllNamed(AppRoutes.allProfilesScreen);
            },
          ),
          DrawerListTile(
            title: "Contact Us",
            svgSrc: ImageConstant.contact,
            press: () {
              Get.offAllNamed(AppRoutes.contactUsScreen);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, svgSrc;
  final VoidCallback press;

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: CustomImageView(
        svgPath: svgSrc,
        height: 25,
      ),
      title: Text(
        title,
        style: TextStyle(color: appTheme.blueGray900, fontSize: 18),
      ),
    );
  }
}
