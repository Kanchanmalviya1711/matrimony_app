import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/friendRequestScreen/ui/friendRequest_screen.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.homeScreen);
          },
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.whiteA700,
          ),
        ),
        title: "All NOTIFICATIONS",
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(
                    text: "Notifications",
                    icon: Icon(Icons.all_inbox),
                  ),
                  Tab(text: "Interested Request", icon: Icon(Icons.message)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        surfaceTintColor: Colors.white,
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipOval(
                              child: CustomImageView(
                                height: 50,
                                width: 50,
                                imagePath: ImageConstant.couple3,
                              ),
                            ),
                          ),
                          title: Text(
                            "Notification Title",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: appTheme.black900,
                            ),
                          ),
                          subtitle: Text(
                            "Notification Subtitle",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: appTheme.gray500,
                            ),
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(
                              color: appTheme.heading,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipOval(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "12:00 PM",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: appTheme.whiteA700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const FriendRequestScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
