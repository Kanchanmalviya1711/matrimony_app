import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/presentation/home/homepage/controller/homepage_controller.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';

class ImagesSlider extends StatelessWidget {
  final HomepageController controller;

  const ImagesSlider({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

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
              // Remove setState as this is a stateless widget
              _currentIndex = index;
            },
          ),
          items: List.generate(
            controller.slidersList.length,
            (index) {
              return buildCarouselItem(
                imagePath: ApiNetwork.imageUrl +
                    controller.slidersList[index]['image'],
                title: controller.slidersList[index]['title'],
                subtitle: controller.slidersList[index]['sub_title'],
                description: controller.slidersList[index]['description'],
              );
            },
          ),
        ),
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            4,
            (index) => buildIndicator(index, _currentIndex),
          ),
        ),
      ],
    );
  }

  Widget buildIndicator(int index, int currentIndex) {
    return Container(
      width: 10.0,
      height: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index ? Colors.red : Colors.black,
      ),
    );
  }
}

Widget buildCarouselItem({
  required String imagePath,
  required String title,
  required String subtitle,
  required String description,
}) {
  return Padding(
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
            Image.network(
              imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title.toLowerCase(),
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
                    const Text(
                      "adding some data in the image  carousel ",
                      style: TextStyle(
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
              child: CustomElevatedButton(
                buttonStyle: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                text: "Explore ghfghf fgcfd",
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
