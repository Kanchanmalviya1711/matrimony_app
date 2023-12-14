import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/presentation/testimonials/controller/testimonials_controller.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
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
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final CarouselController _controller = CarouselController();

  TestimonialsController testimonialsController =
      Get.put(TestimonialsController());

  int _currentIndex = 0;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    testimonialsController.getTestimonials();
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
        title: "Testimonials",
      ),
      body: Obx(() {
        return Column(
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
                    _currentIndex = index;
                  });
                },
              ),
              items: List.generate(testimonialsController.slidersList.length,
                  (index) {
                return buildCarouselItem(
                    imagePath: testimonialsController.slidersList[index]
                            ['image'] ??
                        "",
                    title:
                        testimonialsController.slidersList[index]['name'] ?? "",
                    dateOfMarriage: testimonialsController.slidersList[index]
                        ['dateOfMarriage'],
                    description: testimonialsController.slidersList[index]
                            ['description'] ??
                        "",
                    rating: testimonialsController.slidersList[index]['rating'],
                    status: testimonialsController.slidersList[index]
                        ['status']);
              }),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    _controller.previousPage();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    _controller.nextPage();
                  },
                ),
              ],
            ),
          ],
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
    required int dateOfMarriage,
    required int rating,
    required int status}) {
  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: const Color.fromARGB(255, 226, 3, 3),
      )),
      width: double.infinity,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: imagePath,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      CustomImageView(imagePath: ImageConstant.couple1),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  dateOfMarriage.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  description,
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  rating.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  status == 1 ? "Active" : "Inactive" ?? "N/A",
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
