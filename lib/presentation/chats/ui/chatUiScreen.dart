import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/chats/ui/ownChatingCard.dart';
import 'package:matrimony_app/presentation/chats/ui/replyCard.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_text_form_field.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class ChatUiScreen extends StatefulWidget {
  const ChatUiScreen({Key? key}) : super(key: key);
  @override
  State<ChatUiScreen> createState() => _ChatUiScreenState();
}

class _ChatUiScreenState extends State<ChatUiScreen> {
  //late WebSocketChannel _channel;

  late Socket socket;

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  // void connectToSocket() async {
  //   //  final url = Uri.parse('ws://192.168.1.32:9091');
  //   final url = Uri.parse('wss://192.168.1.25:9091');
  //   final channel = WebSocketChannel.connect(url);

  //   await channel.ready;

  //   channel.stream.listen((message) {
  //     channel.sink.add('received!');
  //     channel.sink.close(status.goingAway);
  //   });
  // }

  void connectToServer() {
    try {
      // Configure socket transports must be specified
      socket = io('http://192.168.1.25:9091', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // Connect to websocket
      socket.connect();
      socket.onConnect((data) => print("$data , connected"));
      print(socket.connected);

      // Handle socket events
      socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print("$e , tttttttttttttttttttttttttttttttt");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 90,
        leading: Stack(
          children: [
            IconButton(
              onPressed: () => Get.offAllNamed(AppRoutes.chatScreen),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
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
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: const [
              ChatingCard(),
              ReplyCard(),
              ChatingCard(),
              ReplyCard(),
              ChatingCard(),
              ReplyCard(),
              ChatingCard(),
              ReplyCard(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: appTheme.whiteA700.withOpacity(0.8),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
}
