// import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/home/homepage/controller/homepage_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomepageController homepageController = Get.put(HomepageController());

  @override
  void initState() {
    super.initState();
    homepageController.getSliders();
    homepageController.getMenus();
    homepageController.getAppSettings();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          if (homepageController.rxRequestStatus.value == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (homepageController.rxRequestStatus.value ==
              Status.success) {
            return buildContent();
          } else if (homepageController.rxRequestStatus.value == Status.error) {
            return const Center(child: Text("Something went wrong"));
          } else {
            return const Center(child: Text("No data found"));
          }
        }),
      ],
    );
  }

  Widget buildContent() {
    return ListView.builder(
      itemCount: homepageController.getAppSettingsDetails.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              tileColor: Colors.black,
              contentPadding: const EdgeInsets.all(0),
              title: Column(
                children: [
                  Stack(
                    children: [
                      MyImageWidget(
                        imageUrl: ApiNetwork.imageUrl +
                            homepageController.getAppSettingsDetails[index]
                                    ["logo_path"]
                                .toString(),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              Text(
                                homepageController.getAppSettingsDetails[index]
                                    ["description"],
                                style: TextStyle(
                                  color: appTheme.whiteA700,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                homepageController.getAppSettingsDetails[index]
                                        ["app_name"]
                                    .toString(),
                                style: TextStyle(
                                    color: appTheme.red600D8,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // MENU BAR DATA DISPLAY END

            Column(
              children: [
                Lottie.asset(
                  "assets/lottie/heart.json",
                  repeat: true,
                  animate: true,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "Quick Access",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Our Services",
                    style: TextStyle(
                        color: appTheme.heading,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "CinzelDecorative"),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // ---------Slider module start--------------
                // Slider module
                CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.56,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.8,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: homepageController.slidersList.isNotEmpty
                        ? List.generate(
                            homepageController.slidersList.length,
                            (index) {
                              return buildCarouselItem(
                                imagePath: ApiNetwork.imageUrl +
                                    homepageController.slidersList[index]
                                        ['image'],
                                title: homepageController.slidersList[index]
                                        ['title']
                                    .toString()
                                    .capitalizeFirst!,
                                subtitle: homepageController.slidersList[index]
                                        ['sub_title']
                                    .toString()
                                    .capitalizeFirst!,
                                status: homepageController.slidersList[index]
                                            ['status'] ==
                                        0
                                    ? "Active"
                                    : "Inactive",
                                description: homepageController
                                    .slidersList[index]['description']
                                    .toString(),
                                onExploreTap: () {
                                  Get.toNamed(
                                    AppRoutes.viewSliderScreen,
                                    arguments:
                                        homepageController.slidersList[index],
                                  );
                                },
                              );
                            },
                          )
                        : [
                            const Center(
                              child: Text(
                                'No data available',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ]),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Positioned(
                      child: DotsIndicator(
                        dotsCount: homepageController.slidersList.isNotEmpty
                            ? homepageController.slidersList.length
                            : 4,
                        position: _currentIndex.toDouble().toInt(),
                        decorator: DotsDecorator(
                          color: appTheme.black900,
                          activeColor: Colors.pink,
                          size: const Size.square(11),
                          activeSize: const Size(11, 11),
                        ),
                      ),
                    ),
                  ],
                ),
                // ---------Slider module end--------------

                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 20),

                const Text(
                  "Trusted Brands ",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Trust by 1500+ Couples",
                    style: TextStyle(
                        color: appTheme.heading,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "CinzelDecorative"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Why Choose Us
                Container(
                  height: 350,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xff2a262691), Color(0xFF2a2c3c)],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "#1 WEDDING SITE",
                            style: TextStyle(
                              color: appTheme.firstSite,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [Color(0xFF00ff72), Color(0xFF66b5ff)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: const Text(
                            'Why Choose Us !',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "PlayfairDisplay"),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Most Trusted and premium Matrimony Service in the World.",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 5,
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: MyImageWidget(
                            imageUrl: ApiNetwork.imageUrl +
                                homepageController.getAppSettingsDetails[index]
                                        ["fav_icon"]
                                    .toString(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Soulmate Contact Info',
                          style: TextStyle(
                            color: appTheme.heading,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            ListTile(
                                leading: const Icon(Icons.mobile_friendly),
                                title: const Text('Call Us'),
                                subtitle: Text(homepageController
                                    .getAppSettingsDetails[index]['call_us']
                                    .toString())),
                            ListTile(
                                leading: const Icon(Icons.mail_lock_outlined),
                                title: const Text('Mail Us'),
                                subtitle: Text(homepageController
                                    .getAppSettingsDetails[index]['mail_us']
                                    .toString())),
                            ListTile(
                                leading: const Icon(Icons.phone),
                                title: const Text('Support Contact Number'),
                                subtitle: Text(
                                    "+91 - ${homepageController.getAppSettingsDetails[index]['support_contact_number']}")),
                            ListTile(
                                leading: const Icon(Icons.email),
                                title: const Text('Support Email'),
                                subtitle: Text(homepageController
                                    .getAppSettingsDetails[index]
                                        ['support_email']
                                    .toString())),
                            ListTile(
                                leading: const Icon(Icons.contact_emergency),
                                title: const Text('Custmer Care Number'),
                                subtitle: Text(homepageController
                                    .getAppSettingsDetails[index]
                                        ['customer_care_number']
                                    .toString())),
                            ListTile(
                                leading: const Icon(Icons.map),
                                title: const Text('Address'),
                                subtitle: Text(homepageController
                                    .getAppSettingsDetails[index]['address']
                                    .toString())),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Connect with Us",
                                  style: TextStyle(
                                      color: appTheme.heading,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "CinzelDecorative"),
                                ),
                                const SizedBox(height: 10),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // 1 linkedIn
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: appTheme.hobbies,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (index >= 0 &&
                                                index <
                                                    homepageController
                                                        .getAppSettingsDetails
                                                        .length) {
                                              String linkedInUrl =
                                                  homepageController
                                                      .getAppSettingsDetails[
                                                          index]['linkedIn_url']
                                                      .toString();

                                              if (linkedInUrl.isNotEmpty) {
                                                launchUrl(
                                                    Uri.parse(linkedInUrl));
                                              } else {
                                                print('LinkedIn URL is empty.');
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
                                      // 2 facebook
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: appTheme.hobbies,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (index >= 0 &&
                                                index <
                                                    homepageController
                                                        .getAppSettingsDetails
                                                        .length) {
                                              String fbUrl = homepageController
                                                  .getAppSettingsDetails[index]
                                                      ['fb_url']
                                                  .toString();

                                              if (fbUrl.isNotEmpty) {
                                                launchUrl(Uri.parse(fbUrl));
                                              } else {
                                                print('LinkedIn URL is empty.');
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
                                      // 3 instagram
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: appTheme.hobbies,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (index >= 0 &&
                                                index <
                                                    homepageController
                                                        .getAppSettingsDetails
                                                        .length) {
                                              String instaUrl =
                                                  homepageController
                                                      .getAppSettingsDetails[
                                                          index]['insta_url']
                                                      .toString();
                                              if (instaUrl.isNotEmpty) {
                                                launchUrl(Uri.parse(instaUrl));
                                              } else {
                                                print('LinkedIn URL is empty.');
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
                                      const SizedBox(width: 10),
                                      // 4 twitter
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: appTheme.hobbies,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (index >= 0 &&
                                                index <
                                                    homepageController
                                                        .getAppSettingsDetails
                                                        .length) {
                                              String instaUrl =
                                                  homepageController
                                                      .getAppSettingsDetails[
                                                          index]['twitter_url']
                                                      .toString();
                                              if (instaUrl.isNotEmpty) {
                                                launchUrl(Uri.parse(instaUrl));
                                              } else {
                                                print('LinkedIn URL is empty.');
                                              }
                                            } else {
                                              print('Index out of bounds.');
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomIconButton(
                                              child: SvgPicture.asset(
                                                ImageConstant.twitter,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 12.0,
      height: 12.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? appTheme.red600D8 : appTheme.black900,
      ),
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
            fit: BoxFit.cover,
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
            fit: BoxFit.cover,
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}

Widget buildCarouselItem({
  bool isExpanded = false,
  required String imagePath,
  required String title,
  required String subtitle,
  required String status,
  required String description,
  required VoidCallback onExploreTap,
}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: SingleChildScrollView(
      child: Card(
        shape: Border.all(
          color: Colors.white70,
          width: 4,
        ),
        surfaceTintColor: appTheme.whiteA700,
        elevation: 4,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          color: Colors.green.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              status,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      softWrap: true,
                      maxLines: isExpanded ? null : 1,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: GestureDetector(
                        onTap: onExploreTap,
                        child: const Text(
                          "Explore",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
