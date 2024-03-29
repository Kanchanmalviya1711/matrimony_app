import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/presentation/blog/controller/blog_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_pagination_view.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  var scaffoldKey = GlobalKey<ScaffoldState>();

  BlogController blogController = Get.put(BlogController());
  bool isExpanded = false;
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
      final newItems = await blogController.getBlogs(
        page: pageKey,
        perPageRecord: blogController.perPage,
      );
      final isLastPage = newItems.length < blogController.perPage;
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
    Size size = MediaQuery.of(context).size;
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
        title: "BLOGS",
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/banner.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.05, 0.8],
                    colors: [
                      Color.fromRGBO(255, 154, 154, 0.89),
                      Color.fromRGBO(218, 223, 255, 1.0),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LATEST & POPULAR",
                          style: TextStyle(
                              color: appTheme.black900,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "CinzelDecorative"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: CustomPaginationView(
                  noDataFound: () {
                    Get.offNamed(AppRoutes.homeScreen);
                  },
                  onRefresh: () => Future.sync(() {
                        pagingController.refresh();
                      }),
                  pagingController: pagingController,
                  itemBuilder: (p0, p1, p2) {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFfdfcfb), Color(0xFFFFFBEE)],
                        ),
                      ),
                      child: Column(
                        children: [
                          Card(
                            elevation: 5,
                            surfaceTintColor: appTheme.whiteA700,
                            color: appTheme.whiteA700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  4), // Add rounded corners
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    MyImageWidget(
                                        width: double.infinity,
                                        height: size.height * 0.6,
                                        imageUrl: ApiNetwork.imageUrl +
                                            p1["image_path"]),
                                    Positioned(
                                      bottom: 10,
                                      child: Container(
                                        color: appTheme.whiteA700,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "${p1["title"]}",
                                                style: TextStyle(
                                                  color: appTheme.black900,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                DateFormat('dd,MMM yyyy')
                                                    .format(
                                                  DateTime.parse(
                                                      p1["dateOfMarriage"]
                                                          .toString()),
                                                ),
                                                style: TextStyle(
                                                    color: appTheme.heading,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            p1["slug"], // Added null check
                                            style: TextStyle(
                                              color: appTheme.heading,
                                              fontSize: 17,
                                            ),
                                          ),
                                          Container(
                                            color: p1["status"] == 1
                                                ? appTheme.green600
                                                    .withOpacity(0.2)
                                                : appTheme.red600D8
                                                    .withOpacity(0.2),
                                            padding: const EdgeInsets.all(7),
                                            child: Text(
                                              p1["status"] == 1
                                                  ? "Active"
                                                  : "Inactive",
                                              style: TextStyle(
                                                color: p1["status"] == 1
                                                    ? appTheme.green600
                                                    : appTheme.red600D8,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        p1["content"] +
                                            "...", // Replace 'content' with the correct variable name
                                        style: TextStyle(
                                          color: appTheme.amber800,
                                          fontSize: 15,
                                        ),
                                        softWrap: true,
                                        maxLines: isExpanded ? null : 1,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isExpanded = !isExpanded;
                                          });

                                          Get.offNamed(AppRoutes.viewBlogScreen,
                                              arguments: [p1]);
                                        },
                                        child: Text(
                                          'Read More...',
                                          style: TextStyle(
                                              color: appTheme.black900),
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
                  }),
            ),
          ],
        ),
      ),
      drawer: const SideMenu(),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String? imageUrl; // Make sure imageUrl is nullable
  final double? width;
  final double? height;

  MyImageWidget({required this.imageUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return imageUrl != null
        ? Image.network(
            imageUrl!,
            width: width,
            fit: BoxFit.cover,
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
