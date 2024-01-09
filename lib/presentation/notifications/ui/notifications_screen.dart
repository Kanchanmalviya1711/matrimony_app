import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Notifications",
                style: TextStyle(
                    color: appTheme.heading,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "CinzelDecorative"),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
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
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "PENDING REQUESTS",
                      style: TextStyle(
                          color: appTheme.black900,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "CinzelDecorative"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
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
                      "Kanchan Malviya",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: appTheme.black900,
                      ),
                    ),
                    subtitle: Text(
                      "Assosiate Software Developer at TCS",
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
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offNamed(AppRoutes.friendRequestScreen);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: appTheme.green600,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: appTheme.whiteA700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
