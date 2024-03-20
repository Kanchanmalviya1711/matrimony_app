import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_text_form_field.dart';

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
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.whiteA700,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: appTheme.black900,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adarsh Sharma",
                          style: TextStyle(
                            color: appTheme.whiteA700,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Last seen today at 18:45",
                          style: TextStyle(
                            color: appTheme.whiteA700,
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
              color: const Color.fromARGB(255, 233, 237, 240),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Chat bubbles or messages will go here
                    Expanded(
                      child: ListView(
                        reverse: true,
                        children: [
                          // Example chat bubbles
                          _buildChatBubble("Hello .", true),
                          _buildChatBubble(
                              "Hey there! How are you doing today?", false),
                          // Add more chat bubbles as needed
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            prefix: Icon(
                              Icons.face,
                              size: 25,
                              color: appTheme.tealColor,
                            ),
                            labelText: "Type your message...",
                            hintStyle: CustomTextStyles.titleSmallSemiBold_1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter text";
                              }
                              return null;
                            },
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            print("This is a Button");
                          },
                          icon: Icon(
                            Icons.send,
                            color: appTheme.black900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isSender) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSender ? const Color.fromARGB(255, 80, 79, 79) : appTheme.gray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 15,
        ),
      ),
    );
  }
}
