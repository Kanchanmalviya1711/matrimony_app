import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/about/controller/about_controller.dart';
import 'package:matrimony_app/presentation/about/ui/ourTeam_screen.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  AboutController aboutUsController = Get.put(AboutController());

  @override
  void initState() {
    super.initState();
    aboutUsController.getAbout();
    aboutUsController.getOurTeam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        centerTitle: true,
        leading: CustomIconButton(
          child: SvgPicture.asset(
            ImageConstant.menuIcon,
            color: appTheme.whiteA700,
          ),
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: "ABOUT US",
      ),
      body: Obx(() {
        if (aboutUsController.rxRequestStatus.value == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (aboutUsController.rxRequestStatus.value == Status.success) {
          return ListView.builder(
            itemCount: aboutUsController.getAboutDetails.length,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: Colors.black,
                contentPadding: const EdgeInsets.all(0),
                title: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFfdfcfb), Color(0xFFFFFBEE)],
                    ),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          MyImageWidget(
                            imageUrl: ApiNetwork.imageUrl +
                                aboutUsController.getAboutDetails[index]
                                    ["image"],
                          ),
                          Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Text(
                                  "About Us",
                                  style: TextStyle(
                                      color: appTheme.black900,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    aboutUsController.getAboutDetails[index]
                                            ["description"]
                                        .toString()
                                        .capitalizeFirst!,
                                    style: TextStyle(
                                      color: appTheme.black900,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          aboutUsController.getAboutDetails[index]["title"]
                              .toString()
                              .capitalizeFirst!,
                          style: TextStyle(
                            fontFamily: 'CinzelDecorative',
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: appTheme.heading,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          elevation: 5,
                          surfaceTintColor: Colors.white,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.0), // Add rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                16.0), // Increased padding for better spacing
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconButton(
                                  child: CustomImageView(
                                    imagePath: ImageConstant.prize,
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        12), // Added some space between the image and text
                                Text(
                                  'Geniune Profiles',
                                  style: TextStyle(
                                    color: appTheme.heading,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        8), // Added space between the title and description
                                Text(
                                  "We have 100% genuine profiles of brides and grooms.",
                                  textAlign: TextAlign
                                      .center, // Center the description text
                                  style: TextStyle(
                                    color: appTheme.headerColor,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          elevation: 5,
                          surfaceTintColor:
                              Colors.white, // Add a subtle shadow for elevation
                          color: Colors.white, // Set a white background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.0), // Add rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                16.0), // Increased padding for better spacing
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconButton(
                                  child: CustomImageView(
                                    imagePath: ImageConstant.rings,
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  '2000+  Weddings',
                                  style: TextStyle(
                                    color: appTheme.heading,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        8), // Added space between the title and description
                                Text(
                                  "2000+ weddings successfully done by us.",
                                  textAlign: TextAlign
                                      .center, // Center the description text
                                  style: TextStyle(
                                    color: appTheme.headerColor,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          elevation: 5,
                          surfaceTintColor:
                              Colors.white, // Add a subtle shadow for elevation
                          color: Colors.white, // Set a white background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.0), // Add rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                16.0), // Increased padding for better spacing
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconButton(
                                  child: CustomImageView(
                                    imagePath: ImageConstant.trust,
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        12), // Added some space between the image and text
                                Text(
                                  'Most Trusted',
                                  style: TextStyle(
                                    color: appTheme.heading,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "The most trusted matrimony service in India.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: appTheme.headerColor,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // Our Team Details
                      Text(
                        "OUR PROFESSIONALS",
                        style: TextStyle(
                          fontFamily: 'CinzelDecorative',
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: appTheme.trustedColor,
                        ),
                      ),
                      Text(
                        "MEET OUR TEAM",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: appTheme.heading,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Our Team Details Image Slider
                      OurTeamScreen(controller: aboutUsController),
                      // Our Team Details Image Slider___________End
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome to",
                              style: TextStyle(
                                fontFamily: 'CinzelDecorative',
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: appTheme.heading,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomImageView(
                              imagePath: ImageConstant.logoImg,
                              width: 250,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Finding your life partner is a journey filled with excitement,"
                              "and we are here to make that journey smoother and more meaningful."
                              "Soulmate is a platform dedicated to helping individuals"
                              "discover their perfect match and embark on a lifelong journey of love"
                              "and companionship",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: appTheme.headerColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.allProfilesScreen);
                              },
                              child: const Text(
                                "Click here to start your matrimony service now.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            Text(
                              "Create your profile by providing essential details about yourself."
                              "Add photos and share your interests to make your profile stand out.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: appTheme.headerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return Container(child: const Text("data not found"));
      }),
      drawer: const SideMenu(),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String? imageUrl; // Make sure imageUrl is nullable

  MyImageWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(
            imageUrl!,
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
                imagePath: ImageConstant.couple1,
              ); // Display an error icon if the image fails to load
            },
          )
        : CustomImageView(
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}
