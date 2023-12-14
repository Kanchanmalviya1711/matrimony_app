import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/home/homepage/controller/homepage_controller.dart';
import 'package:matrimony_app/presentation/home/homepage/widget/menu_screen.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

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
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homepageController.rxRequestStatus.value == Status.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (homepageController.rxRequestStatus.value == Status.success) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(1),
                      BlendMode.dstATop,
                    ),
                    child: CustomImageView(
                      imagePath: ImageConstant.homePicture,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 30,
                    child: Column(
                      children: [
                        Text(
                          'Find Your Perfect Match',
                          style: TextStyle(
                            color: appTheme.whiteA700,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "SOULMATE",
                          style: TextStyle(
                              color: appTheme.red600D8,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              MyMenuBar(controller: homepageController),
              const SizedBox(height: 30),
              Column(
                children: [
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

                  // slider module
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 330.0,
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
                    items: List.generate(homepageController.slidersList.length,
                        (index) {
                      return buildCarouselItem(
                          imagePath: homepageController.slidersList[index]
                              ['image'],
                          title: homepageController.slidersList[index]
                              ['title']);
                    }),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => buildIndicator(index),
                    ),
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(
                          children: <Widget>[
                            // Image
                            CustomImageView(
                                imagePath: ImageConstant.aboutPicture),
                            // Name and Subheading
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'John Doe',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Software Engineer',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Paragraph
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Why Choose Us
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF2a262691), Color(0xFF2a2c3c)],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
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
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Most Trusted and premium Matrimony Service in the World.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins"),
                            ),
                          )
                        ],
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
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
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
                            const SizedBox(height: 12),
                            Text(
                              'Geniune Profiles',
                              style: TextStyle(
                                color: appTheme.heading,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "The most trusted wedding matrimony brand",
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
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Card(
                      elevation: 5,
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
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
                            const SizedBox(height: 8),
                            Text(
                              "The most trusted wedding matrimony brand",
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
                ],
              ),
            ],
          ),
        );
      }
      return Container();
    });
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? appTheme.red600D8 : appTheme.black900,
      ),
    );
  }
}

Widget buildCarouselItem({required String imagePath, required String title}) {
  return Stack(
    children: [
      CachedNetworkImage(
        imageUrl: imagePath,
        placeholder: (context, url) =>
            CustomImageView(imagePath: ImageConstant.couple1, width: 300),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      Positioned(
        bottom: 20,
        left: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomElevatedButton(
              text: "View",
              buttonStyle: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.pink),
              ),
            )
          ],
        ),
      ),
    ],
  );
}
