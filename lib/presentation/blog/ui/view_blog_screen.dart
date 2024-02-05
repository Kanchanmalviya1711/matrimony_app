import 'package:intl/intl.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class ViewBlogScreen extends StatefulWidget {
  const ViewBlogScreen({Key? key}) : super(key: key);
  @override
  _ViewBlogScreenState createState() => _ViewBlogScreenState();
}

class _ViewBlogScreenState extends State<ViewBlogScreen> {
  bool isExpanded = false;
  late var data;

  @override
  void initState() {
    super.initState();
    data = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.blogScreen);
          },
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.whiteA700,
          ),
        ),
        title: "VIEW COUPLES BLOG",
        centerTitle: true,
      ),
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFfdfcfb), Color(0xFFFFFBEE)],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    MyImageWidget(
                        height: size.height * 0.4,
                        width: double.infinity,
                        imageUrl: ApiNetwork.imageUrl + data[0]["image_path"]),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[0]["title"],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            data[0]["slug".toString()],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: appTheme.heading,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                DateFormat('dd,MMM yyyy').format(
                                  DateTime.parse(
                                      data[0]["dateOfMarriage"].toString()),
                                ),
                                style: TextStyle(
                                    color: appTheme.whiteA700,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: appTheme.blogBoxColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "EVENTS",
                            style: TextStyle(
                                color: appTheme.whiteA700,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: appTheme.blogBoxColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "DECORAION",
                            style: TextStyle(
                                color: appTheme.whiteA700,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: appTheme.blogBoxColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "WEDDING",
                            style: TextStyle(
                                color: appTheme.whiteA700,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text("Our Wedding Journey",
                        style: TextStyle(
                            color: appTheme.heading,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500."
                      "has been the industry's standard dummy text ever since the 1500",
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          )),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  // Make sure imageUrl is nullable

  MyImageWidget(
      {required this.imageUrl, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return imageUrl != null
        ? Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            width: width,
            height: height,
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
                width: double.infinity,
                height: size.height * 0.4,
                fit: BoxFit.cover,
                imagePath: ImageConstant.couple1,
              ); // Display an error icon if the image fails to load
            },
          )
        : CustomImageView(
            width: double.infinity,
            height: size.height * 0.4,
            fit: BoxFit.cover,
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}
