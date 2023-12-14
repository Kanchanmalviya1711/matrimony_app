import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/ui/profileLists_screen.dart';
import 'package:matrimony_app/presentation/home/controller/home_controller.dart';
import 'package:matrimony_app/presentation/home/homepage/homepage.dart';
import 'package:matrimony_app/presentation/notifications/ui/notifications_screen.dart';
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
  HomeController homeController = Get.put(HomeController());
  int currentIndex = 0;

  final pages = [
    const HomePage(),
    const ProfileListsScreen(),
    const Notifications(),
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
        title: "S & M ",
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: appTheme.whiteA700,
            ),
          ),
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
        ],
      ),
      body: Obx(() {
        return homeController.pagesList[homeController.count.value];
      }),
      // Home page
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() {
          homeController.count.value = value;
        }),
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
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),

      drawer: const SideMenu(),
    );
  }
}
