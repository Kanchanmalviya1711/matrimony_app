import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/presentation/testimonials/controller/testimonials_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/utils/string_capitalization.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class TestimonialsScreen extends StatefulWidget {
  const TestimonialsScreen({Key? key}) : super(key: key);
  @override
  _TestimonialsScreenState createState() => _TestimonialsScreenState();
}

class _TestimonialsScreenState extends State<TestimonialsScreen> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final CarouselController _controller = CarouselController();

  TestimonialsController testimonialsController =
      Get.put(TestimonialsController());

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    testimonialsController.getTestimonials();
    // timeline api call
    testimonialsController.getTimeLineData();
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
        title: "TESTIMONIALS",
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "TRUSTED BRAND",
                  style: TextStyle(
                      fontSize: 25,
                      color: appTheme.trustedColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "CinzelDecorative"),
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
              const SizedBox(height: 30),
              CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: 400,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentPageIndex = index;
                      });
                    },
                  ),
                  items: testimonialsController.slidersList.isNotEmpty
                      ? List.generate(testimonialsController.slidersList.length,
                          (index) {
                          return buildCarouselItem(
                              imagePath: ApiNetwork.imageUrl +
                                  testimonialsController.slidersList[index]
                                      ['image'],
                              title: testimonialsController.slidersList[index]
                                      ['name'] ??
                                  "",
                              dateOfMarriage: testimonialsController
                                  .slidersList[index]['dateOfMarriage'],
                              description: testimonialsController
                                  .slidersList[index]['description']
                                  .toString()
                                  .capitalizeFirst!,
                              rating: testimonialsController.slidersList[index]
                                      ['rating']
                                  .toDouble(),
                              status: testimonialsController.slidersList[index]
                                  ['status']);
                        })
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
                      dotsCount: testimonialsController.slidersList.isNotEmpty
                          ? testimonialsController.slidersList.length
                          : 4,
                      position: currentPageIndex.toDouble().toInt(),
                      decorator: DotsDecorator(
                        color: appTheme.black900,
                        activeColor: Colors.red,
                        size: const Size.square(11),
                        activeSize: const Size(11, 11),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              Text(
                "Moments",
                style: TextStyle(
                  fontFamily: 'CinzelDecorative',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: appTheme.trustedColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Wedding Timeline",
                style: TextStyle(
                  fontFamily: 'CinzelDecorative',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: appTheme.heading,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  thickness: 1,
                  color: appTheme.heading,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: testimonialsController.timeLineList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: MyImageWidget(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      imageUrl: testimonialsController
                                                      .timeLineList[index]
                                                  ["image"] ==
                                              null
                                          ? ImageConstant.couple1
                                          : ApiNetwork.imageUrl +
                                              testimonialsController
                                                  .timeLineList[index]["image"],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          testimonialsController
                                              .timeLineList[index]['title']
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              color: appTheme.black900,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Timming: ${testimonialsController.timeLineList[index]['time'].toString()}",
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              color: appTheme.red600D8,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${testimonialsController.timeLineList[index]['description']}",
                                          style: TextStyle(
                                            fontFamily: 'poppins',
                                            color: appTheme.black900,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              const Divider(),
                            ],
                          );
                        }),
                  ),
                ],
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
        );
      }),
      drawer: const SideMenu(),
    );
  }
}

Widget buildCarouselItem(
    {required String imagePath,
    required String title,
    required String description,
    required String dateOfMarriage,
    required double rating,
    required int status}) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.1,
            ),
          ),
          width: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    MyImageWidget(
                      imageUrl: imagePath,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style:
                              TextStyle(color: appTheme.black900, fontSize: 18),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: status == 1
                                ? Colors.green.withOpacity(0.2)
                                : Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              status == 1 ? "Active" : "Inactive",
                              style: TextStyle(
                                  color:
                                      status == 1 ? Colors.green : Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Date of Marriage",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                DateFormat('dd-MM-yy').format(
                                  DateTime.parse(dateOfMarriage.toString()),
                                ),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          ],
                        ),
                        RatingBarIndicator(
                          rating: rating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 25.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            description,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
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
      ],
    ),
  );
}

class MyImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  // Make sure imageUrl is nullable
  MyImageWidget({required this.imageUrl, this.width, this.height});
  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(
            imageUrl!,
            height: height,
            width: width,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes! ?? 1.0)
                        : null,
                  ),
                );
              }
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return CustomImageView(
                imagePath: ImageConstant.couple1,
                height: height,
                width: width,
              );
            },
          )
        : CustomImageView(
            imagePath: ImageConstant.couple1,
            height: height,
            width: width,
          );
  }
}
