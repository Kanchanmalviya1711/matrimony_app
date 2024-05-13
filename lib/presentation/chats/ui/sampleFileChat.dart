import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import '../../../theme/custom_text_style.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatUiScreen extends StatefulWidget {
  const ChatUiScreen({super.key});
  @override
  State<ChatUiScreen> createState() => _ChatUiScreenState();
}

class _ChatUiScreenState extends State<ChatUiScreen> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    try {
      socket = IO.io(
        'http://172.22.224.1:3000',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        },
      );

      print(socket.connected);

      socket.onConnect((_) {
        print("Connected");
      });

      socket.onError((error) {
        print("Socket connection error sfd: $error");
      });

      socket.connect();
    } catch (e) {
      print("Socket connection error eee: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 100,
        leading: Stack(
          children: [
            IconButton(
                onPressed: () => {Get.offAllNamed(AppRoutes.chatScreen)},
                icon: const Icon(Icons.arrow_back, color: Colors.white)),
            Positioned(
              left: 40,
              top: 5,
              child: CircleAvatar(
                child: CustomImageView(
                  imagePath: ImageConstant.couple1,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Adarsh Sharma",
                style: TextStyle(
                  color: appTheme.whiteA700,
                  fontSize: 13,
                ),
              ),
              Text(
                "Last seen today at 18:45",
                style: TextStyle(
                  color: appTheme.whiteA700,
                  fontSize: 10,
                ),
              ),
            ],
          ),
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Expanded(
              child: Container(
                color: appTheme.whiteA700,
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
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [_buildChatBubble("Hello .", true)]),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _buildChatBubble(
                                    "Hey there! How are you doing today?",
                                    false)
                              ],
                            ),
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
