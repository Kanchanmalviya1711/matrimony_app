import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
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
  int currentPageIndex = 0;

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
        title: "About Us",
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  CustomImageView(
                    imagePath: ImageConstant.aboutPicture,
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
                              color: appTheme.whiteA700,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Most Trusted and premium Matrimony Service in the World.',
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Card(
                  elevation: 5,
                  surfaceTintColor:
                      Colors.white, // Add a subtle shadow for elevation
                  color: Colors.white, // Set a white background color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0), // Add rounded corners
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
                          "The most trusted wedding matrimony brand",
                          textAlign:
                              TextAlign.center, // Center the description text
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
                    borderRadius:
                        BorderRadius.circular(12.0), // Add rounded corners
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
                        const SizedBox(
                            height:
                                12), // Added some space between the image and text
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
                          "The most trusted wedding matrimony brand",
                          textAlign:
                              TextAlign.center, // Center the description text
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
                    borderRadius:
                        BorderRadius.circular(12.0), // Add rounded corners
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
                        const SizedBox(
                            height:
                                8), // Added space between the title and description
                        Text(
                          "The most trusted wedding matrimony brand",
                          textAlign:
                              TextAlign.center, // Center the description text
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
                height: 10,
              ),
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
                      "Best wedding matrimony. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: appTheme.headerColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Click here to start your matrimony service now.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .blue, // Adjust the color based on your design
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(
                      "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
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
      ),
      drawer: const SideMenu(),
    );
  }
}
