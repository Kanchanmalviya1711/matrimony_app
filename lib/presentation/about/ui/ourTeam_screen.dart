import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/presentation/about/controller/about_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.5,
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
                              widget.controller.getOurTeamDetails[index]
                                  ['image'],
                          title: widget.controller.getOurTeamDetails[index]
                              ['name'],
                          designation: widget.controller
                              .getOurTeamDetails[index]['designation'],
                          description: widget
                              .controller.getOurTeamDetails[index]['about']
                              .toString()
                              .capitalizeFirst!,
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
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              DotsIndicator(
                dotsCount: widget.controller.getOurTeamDetails.isNotEmpty
                    ? widget.controller.getOurTeamDetails.length
                    : 4,
                position: _currentIndex.toDouble().toInt(),
                decorator: DotsDecorator(
                  color: appTheme.black900,
                  activeColor: appTheme.newGreen,
                  size: const Size.square(11),
                  activeSize: const Size(11, 11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCarouselItem({
    bool isExpanded = false,
    required String imagePath,
    required String title,
    required String designation,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.viewOurTeamDetailsScreen,
              arguments: widget.controller.getOurTeamDetails[_currentIndex]);
        },
        child: SingleChildScrollView(
          child: Card(
            shape: Border.all(
              color: appTheme.whiteA700,
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
                    height: !isExpanded ? 200 : double.infinity,
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
                          designation,
                          style: TextStyle(
                            fontSize: 14,
                            color: appTheme.gray,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 13,
                            color: appTheme.black900,
                          ),
                          softWrap: true,
                          maxLines: isExpanded ? null : 2,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: double.infinity,
                    color: appTheme.newGreen,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "View Profile",
                              style: TextStyle(
                                  color: appTheme.whiteA700, fontSize: 16),
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
