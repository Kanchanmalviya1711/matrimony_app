import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class ChatUIScreen extends StatelessWidget {
  const ChatUIScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Chat With",
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(AppRoutes.chatScreen);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: CustomImageView(
                        imagePath: ImageConstant.couple1,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adarsh Sharma",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Last seen today at 18:45",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.offNamed(
                          AppRoutes.profileScreen,
                        );
                      },
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        size: 25,
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
                        Icons.phone,
                        size: 25,
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
                        Icons.more_vert,
                        size: 25,
                        color: appTheme.whiteA700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blueGrey,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 153, 153, 146),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            "Your chat content goes here.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 153, 153, 146),
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, right: 10, top: 10, bottom: 10),
                          child: const Text(
                            "Your chat content goes here. Your chat content goes here.Your chat content goes here.Your chat content goes here.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 153, 153, 146),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            "Your chat content goes here.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 153, 153, 146),
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, right: 10, top: 10, bottom: 10),
                          child: const Text(
                            "Your chat content goes here. Your chat content goes here.Your chat content goes here.Your chat content goes here.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ])
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
