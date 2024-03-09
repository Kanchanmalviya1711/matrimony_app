import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/presentation/home/homepage/controller/homepage_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  HomepageController homepageController = Get.put(HomepageController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homepageController.getMenus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFfdfcfb), Color(0xFFFFFBEE)],
            ),
          ),
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
                  Get.offAllNamed(AppRoutes.homeScreen);
                },
              ),
              DrawerListTile(
                title: "All Profiles",
                svgSrc: ImageConstant.allProfiles,
                press: () {
                  Get.offAllNamed(AppRoutes.allProfilesScreen);
                },
              ),
              const Divider(
                color: Colors.black,
              ),
              DrawerListTile(
                title: "Blog",
                svgSrc: ImageConstant.blog,
                press: () {
                  Get.offAllNamed(AppRoutes.blogScreen);
                },
              ),
              DrawerListTile(
                title: "Testimonials",
                svgSrc: ImageConstant.testimonials,
                press: () {
                  Get.offAllNamed(AppRoutes.testimonialsScreen);
                },
              ),
              const Divider(
                color: Colors.black,
              ),
              DrawerListTile(
                title: "About",
                svgSrc: ImageConstant.groupAbout,
                press: () {
                  Get.offAllNamed(AppRoutes.aboutScreen);
                },
              ),
              DrawerListTile(
                title: "Contact Us",
                svgSrc: ImageConstant.contact,
                press: () {
                  Get.offAllNamed(AppRoutes.contactUsScreen);
                },
              ),
              DrawerListTile(
                title: "Our Services",
                svgSrc: ImageConstant.services,
                press: () {
                  Get.offAllNamed(AppRoutes.ourServiceScreen);
                },
              ),
              DrawerListTile(
                title: "Gallery",
                svgSrc: ImageConstant.gallery,
                press: () {
                  Get.offAllNamed(AppRoutes.galleryScreen);
                },
              ),
              DrawerListTile(
                title: "Plans & Pricing",
                svgSrc: ImageConstant.suscription,
                press: () {
                  Get.offAllNamed(AppRoutes.plansAndPricingScreen);
                },
              ),
              DrawerListTile(
                title: "Settings",
                svgSrc: ImageConstant.settings,
                press: () {
                  Get.offAllNamed(AppRoutes.settings);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: CustomElevatedButton(
                  buttonStyle: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  text: "Logout",
                  buttonTextStyle: CustomTextStyles.titleMediumBlackA700,
                  onTap: () {
                    showAlertDialog(
                      context,
                      () {
                        Get.back();
                      },
                      () {
                        SessionManager.removeToken();
                        Get.offAllNamed(AppRoutes.loginScreen);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
        height: 22,
        color: appTheme.black900,
      ),
      title: Text(
        title,
        style: TextStyle(color: appTheme.black900, fontSize: 18),
      ),
    );
  }
}

void showAlertDialog(
  context,
  VoidCallback noTap,
  VoidCallback deleteTap, {
  title,
  msg,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20,
        ),
        actionsOverflowButtonSpacing: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        surfaceTintColor: Colors.white,
        title: Text(title ?? "Log Out ?", textAlign: TextAlign.center),
        content: Text(
          msg ?? 'Are you sure want to logout? ',
          style: const TextStyle(color: Colors.black, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        actions: [
          Column(
            children: [
              const Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor: appTheme.filterColor,
                    ),
                    onPressed: noTap,
                    child: SizedBox(
                      width: 50,
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: appTheme.whiteA700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor: Colors.red,
                    ),
                    onPressed: deleteTap,
                    child: SizedBox(
                      width: 50,
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: appTheme.whiteA700,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );
}
