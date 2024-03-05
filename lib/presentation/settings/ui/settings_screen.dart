import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/notifications/controller/notifications_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  var scaffoldKey = GlobalKey<ScaffoldState>();
  NotificationsController notificationsController =
      Get.put(NotificationsController());

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await notificationsController.getAllNotification(
        page: pageKey,
        perPageRecord: notificationsController.perPage,
      );
      final isLastPage = newItems.length < notificationsController.perPage;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.homeScreen);
          },
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.whiteA700,
          ),
        ),
        title: "FAQS",
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Frequently Asked Questions",
                style: TextStyle(
                  fontSize: 20,
                  color: appTheme.heading,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "1. How Soulmate matrimony works?",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 3),
              const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
              const SizedBox(height: 10),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              const Text(
                "2. Printing and typesetting industry?",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 3),
              const Text(
                  "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
              const SizedBox(height: 10),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              const Text(
                "3. What are the eligibility criteria for registration?",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 3),
              const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
              const SizedBox(height: 10),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              const Text(
                "4. Why do we use it?",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 3),
              const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
              const SizedBox(height: 10),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              const Text(
                "5. There are many variations of passages?",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 3),
              const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
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
              const SizedBox(height: 10),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFFF166C),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Free Support 24/7. No Hidden Charges. Cancel Anytime.",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "GET IN TOUCH",
                      style: TextStyle(
                        color: appTheme.black900,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "If you have any questions, feel free to contact us.",
                      style: TextStyle(
                        color: appTheme.black900,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Text(
                      "28800 Orchard lake road, suite 180, farmington hills, MI 48334, USA",
                      style: TextStyle(
                        color: appTheme.black900,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Divider(color: appTheme.gray),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Phone: +91 1234567890",
                      style: TextStyle(
                        color: appTheme.black900,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Email: helpsoulmate@gmail.com",
                      style: TextStyle(
                        color: appTheme.black900,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Website: www.soulmate.com",
                      style: TextStyle(
                        color: appTheme.black900,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Divider(
                      color: appTheme.gray,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'HELP AND SUPPORT',
                            style: TextStyle(
                              color: appTheme.black900,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.offAndToNamed(AppRoutes.aboutScreen);
                                },
                                child: Text(
                                  "About Company",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  Get.offAndToNamed(AppRoutes.contactUsScreen);
                                },
                                child: Text(
                                  "Contact Us",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  Get.offAndToNamed(AppRoutes.ourServiceScreen);
                                },
                                child: Text(
                                  "Our Services",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              GestureDetector(
                                child: Text(
                                  "Feedback",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  Get.offAndToNamed(
                                      AppRoutes.testimonialsScreen);
                                },
                                child: Text(
                                  "Testimonials",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Divider(
                      color: appTheme.gray,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'FOLLOW US',
                          style: TextStyle(
                            color: appTheme.black900,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // 1 linkedIn
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: appTheme.gray200,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          launch('https://www.linkedin.com/');
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
                                        borderRadius: BorderRadius.circular(5),
                                        color: appTheme.gray200,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          launch('https://www.facebook.com/');
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
                                    // 3 twitter
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: appTheme.gray200,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          launch('https://twitter.com/');
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

                                    const SizedBox(width: 10),
                                    // 4 youtube
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: appTheme.gray200,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          launch('https://www.youtube.com/');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomIconButton(
                                            child: SvgPicture.asset(
                                              ImageConstant.youtube,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ],
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

  MyImageWidget(
      {required this.imageUrl, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(
            imageUrl!,
            width: width,
            height: height,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child; // Displaying the image if it's already loaded
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
                width: 200,
                height: height,
                fit: BoxFit.cover,
                imagePath: ImageConstant.couple1,
              );
            },
          )
        : CustomImageView(
            width: 200,
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}
