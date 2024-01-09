import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/presentation/about/controller/about_controller.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';

class OurTeamScreen extends StatefulWidget {
  final AboutController controller;

  const OurTeamScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _OurTeamScreenState createState() => _OurTeamScreenState();
}

class _OurTeamScreenState extends State<OurTeamScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          items: widget.controller.getOurTeamDetails.isNotEmpty
              ? List.generate(
                  widget.controller.getOurTeamDetails.length,
                  (index) {
                    return Container(
                      child: buildCarouselItem(
                        imagePath: ApiNetwork.imageUrl +
                            widget.controller.getOurTeamDetails[index]['image'],
                        title: widget.controller.getOurTeamDetails[index]
                            ['name'],
                        description: widget.controller.getOurTeamDetails[index]
                            ['designation'],
                        subtitle: widget
                            .controller.getOurTeamDetails[index]['order_number']
                            .toString(),
                      ),
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
                ],
        ),
        const SizedBox(height: 10.0),
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Positioned(
              child: DotsIndicator(
                dotsCount: widget.controller.getOurTeamDetails.isNotEmpty
                    ? widget.controller.getOurTeamDetails.length
                    : 4,
                position: _currentIndex.toDouble().toInt(),
                decorator: DotsDecorator(
                  color: appTheme.black900,
                  activeColor: Colors.blue,
                  size: const Size.square(11),
                  activeSize: const Size(11, 11),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30.0),
      ],
    );
  }

  Widget buildCarouselItem({
    required String imagePath,
    required String title,
    required String subtitle,
    required String description,
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
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Get In Touch",
                      style: TextStyle(
                        color: appTheme.heading,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildSocialMediaIcon(ImageConstant.linkedin),
                            const SizedBox(width: 10),
                            buildSocialMediaIcon(ImageConstant.facebook),
                            const SizedBox(width: 10),
                            buildSocialMediaIcon(ImageConstant.whatsapp),
                          ],
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
    );
  }

  Widget buildSocialMediaIcon(String iconPath) {
    return Container(
      height: 50,
      width: 50,
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
}
