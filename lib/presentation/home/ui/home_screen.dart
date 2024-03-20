import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/ui/profileLists_screen.dart';
import 'package:matrimony_app/presentation/home/controller/home_controller.dart';
import 'package:matrimony_app/presentation/home/homepage/controller/homepage_controller.dart';
import 'package:matrimony_app/presentation/home/homepage/homepage.dart';
import 'package:matrimony_app/presentation/myConnections/ui/myConnections_screen.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  HomepageController controller = Get.put(HomepageController());
  HomeController homeController = Get.put(HomeController());
  int currentIndex = 0;

  final pages = [
    const HomePage(),
    const ProfileListsScreen(),
    const MyConnectionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        centerTitle: true,
        leading: CustomIconButton(
          child: SvgPicture.asset(
            ImageConstant.menuIcon,
            color: appTheme.whiteA700,
          ),
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: "S & M",
        actions: [
          IconButton(
            onPressed: () {
              Get.offNamed(
                AppRoutes.profileScreen,
              );
            },
            icon: Icon(
              Icons.account_circle,
              color: appTheme.whiteA700,
            ),
          ),
          Stack(
            // Use Stack to overlay the red dot
            children: [
              IconButton(
                onPressed: () {
                  Get.offNamed(AppRoutes.notificationScreen);
                },
                icon: Icon(
                  Icons.notifications,
                  color: appTheme.whiteA700,
                ),
              ),
              // Conditionally show the red dot
              Positioned(
                right: 13,
                top: 10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: appTheme.red600D8,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 9,
                    minHeight: 9,
                  ),
                ),
              ),
            ],
          ),
          PopupMenuButton<String>(
            surfaceTintColor: appTheme.whiteA700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: appTheme.whiteA700),
            ),
            icon: Icon(
              Icons.more_vert,
              color: appTheme.whiteA700,
            ),
            onSelected: (value) {
              if (value == "0") {
                Get.toNamed(AppRoutes.ourServiceScreen);
              } else if (value == "1") {
                Get.toNamed(AppRoutes.blogScreen);
              } else if (value == "2") {
                Get.toNamed(AppRoutes.testimonialsScreen);
              } else if (value == "3") {
                Get.toNamed(AppRoutes.allProfilesScreen);
              }
            },
            itemBuilder: (BuildContext context) {
              return List.generate(
                controller.menusList.length,
                (index) {
                  return PopupMenuItem<String>(
                    value: index.toString(),
                    child: Text(
                      controller.menusList[index]["menu"]["name"] == null
                          ? "No data"
                          : controller.menusList[index]["menu"]["name"] ??
                              "No data",
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        return homeController.pagesList[homeController.count.value];
      }),
      // Home page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeController.count.value,
        onTap: (value) => setState(() {
          homeController.count.value = value;
        }),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: appTheme.red600D8,
        unselectedItemColor: appTheme.black900,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.segment),
            label: 'Profile List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'My Connections',
          ),
        ],
      ),

      drawer: const SideMenu(),
    );
  }
}
