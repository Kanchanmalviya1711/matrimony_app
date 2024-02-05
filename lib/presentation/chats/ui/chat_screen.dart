import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/chats/controller/chat_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = ChatController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "CHATLIST".tr,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: appTheme.whiteA700,
            onPressed: () {
              Get.offAllNamed(AppRoutes.homeScreen);
            },
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "CHAT LIST",
              style: TextStyle(
                color: appTheme.heading,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: "CinzelDecorative",
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Card(
            elevation: 5,
            surfaceTintColor: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: CustomImageView(
                        imagePath: ImageConstant.couple1,
                        height: 70,
                        width: 70,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adarsh Sharma",
                          style: TextStyle(
                            color: appTheme.black900,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Hii Manju, How are you?",
                          style: TextStyle(
                            color: appTheme.black900,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    Text(
                      "12:00 PM",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: appTheme.heading,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: CustomImageView(
                        imagePath: ImageConstant.couple1,
                        height: 70,
                        width: 70,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adarsh Sharma",
                          style: TextStyle(
                            color: appTheme.black900,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Hii Manju, How are you?",
                          style: TextStyle(
                            color: appTheme.black900,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    Text(
                      "12:00 PM",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: appTheme.heading,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: CustomImageView(
                        imagePath: ImageConstant.couple1,
                        height: 70,
                        width: 70,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adarsh Sharma",
                          style: TextStyle(
                            color: appTheme.black900,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Hii Manju, How are you?",
                          style: TextStyle(
                            color: appTheme.black900,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    Text(
                      "12:00 PM",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: appTheme.heading,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: CustomImageView(
                        imagePath: ImageConstant.couple1,
                        height: 70,
                        width: 70,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adarsh Sharma",
                          style: TextStyle(
                            color: appTheme.black900,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Hii Manju, How are you?",
                          style: TextStyle(
                            color: appTheme.black900,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    Text(
                      "12:00 PM",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: appTheme.heading,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
