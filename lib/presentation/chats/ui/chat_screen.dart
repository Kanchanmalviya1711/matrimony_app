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
          title: "ALL CHATS".tr,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: appTheme.whiteA700,
            onPressed: () {
              Get.offAllNamed(AppRoutes.homeScreen);
            },
          )),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            surfaceTintColor: appTheme.whiteA700,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Get.offAllNamed(AppRoutes.chatUiScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: CustomImageView(
                                imagePath: ImageConstant.couple1,
                                height: 60,
                                width: 60,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ashish Sharma",
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Hey Ashish, How are you?",
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
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
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(AppRoutes.chatUiScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: CustomImageView(
                                imagePath: ImageConstant.couple1,
                                height: 60,
                                width: 60,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Advik Malviya",
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Hey Advik, How are you?",
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
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
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(AppRoutes.chatUiScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: CustomImageView(
                                imagePath: ImageConstant.couple1,
                                height: 60,
                                width: 60,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Aniket Verma",
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Hey aniket, How are you?",
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
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
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(AppRoutes.chatUiScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: CustomImageView(
                                imagePath: ImageConstant.couple1,
                                height: 60,
                                width: 60,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rudrah Jat",
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Hey Rudrah, How are you?",
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
