import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class FriendRequestScreen extends StatefulWidget {
  const FriendRequestScreen({super.key});
  @override
  State<FriendRequestScreen> createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
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
                "All Requests",
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
        ],
      ),
    );
  }
}
