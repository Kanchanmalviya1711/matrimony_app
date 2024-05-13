import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewOurTeamScreen extends StatefulWidget {
  const ViewOurTeamScreen({Key? key}) : super(key: key);
  @override
  _ViewOurTeamScreenState createState() => _ViewOurTeamScreenState();
}

class _ViewOurTeamScreenState extends State<ViewOurTeamScreen> {
  bool isExpanded = false;
  late var data;
  @override
  void initState() {
    super.initState();
    data = Get.arguments;
    print("$data, data data");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.aboutScreen);
          },
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.whiteA700,
          ),
        ),
        title: "VIEW OUR TEAM DETAILS",
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: appTheme.whiteA700),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  MyImageWidget(
                      height: size.height * 0.5,
                      width: double.infinity,
                      imageUrl: ApiNetwork.imageUrl + data["image"]),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data["name"],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            color: data["status"] == 1
                                ? appTheme.green600.withOpacity(0.2)
                                : appTheme.red600D8.withOpacity(0.2),
                            child: Text(
                              data["status"] == 1 ? "Active" : "Inactive",
                              style: TextStyle(
                                fontSize: 20,
                                color: data["status"] == 1
                                    ? appTheme.green600
                                    : appTheme.red600D8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        data["designation"].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        data["about"] == null
                            ? "No Description About Team Member."
                            : data["about"].toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Get In Touch",
                              style: TextStyle(
                                color: appTheme.heading,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // 1. linkedIn
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: appTheme.hobbies,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        print("hsgrhsterf");
                                        if (data != null) {
                                          String linkedinUrl =
                                              data['linkedinUrl'].toString();
                                          if (linkedinUrl.isNotEmpty) {
                                            launchUrl(Uri.parse(linkedinUrl));
                                          } else {
                                            print('linkedinUrl is empty.');
                                          }
                                        } else {
                                          print('Index out of bounds.');
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomIconButton(
                                          child: SvgPicture.asset(
                                            ImageConstant.linkedin,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  // 2. facebook
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: appTheme.hobbies,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        print("hsgrhsterf");
                                        if (data != null) {
                                          String facebookUrl =
                                              data['facebookUrl'].toString();
                                          if (facebookUrl.isNotEmpty) {
                                            launchUrl(Uri.parse(facebookUrl));
                                          } else {
                                            print('facebook Url URL is empty.');
                                          }
                                        } else {
                                          print('Index out of bounds.');
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomIconButton(
                                          child: SvgPicture.asset(
                                            ImageConstant.facebook,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  // 3. watsapp
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: appTheme.hobbies,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        print("hsgrhsterf");
                                        if (data != null) {
                                          String watsappUrl =
                                              data['whatsappUrl'].toString();
                                          if (watsappUrl.isNotEmpty) {
                                            launchUrl(Uri.parse(watsappUrl));
                                          } else {
                                            print('whatsappUrl is empty.');
                                          }
                                        } else {
                                          print('Index out of bounds.');
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomIconButton(
                                          child: SvgPicture.asset(
                                            ImageConstant.whatsapp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
        ),
      ),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  // Make sure imageUrl is nullable

  MyImageWidget(
      {required this.imageUrl, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return imageUrl != null
        ? Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            width: width,
            height: height,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child; // Image is fully loaded
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return CustomImageView(
                width: double.infinity,
                height: size.height * 0.4,
                fit: BoxFit.cover,
                imagePath: ImageConstant.couple1,
              ); // Display an error icon if the image fails to load
            },
          )
        : CustomImageView(
            width: double.infinity,
            height: size.height * 0.4,
            fit: BoxFit.cover,
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}

Widget buildSocialMediaIcon(String iconPath) {
  return Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: appTheme.hobbies,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: CustomIconButton(
        child: SvgPicture.asset(iconPath),
        onTap: () {},
      ),
    ),
  );
}
