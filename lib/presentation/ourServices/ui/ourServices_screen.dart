import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/presentation/ourServices/controller/ourServices_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_pagination_view.dart';

class OurServicesScreen extends StatefulWidget {
  const OurServicesScreen({Key? key}) : super(key: key);

  @override
  _OurServicesScreenState createState() => _OurServicesScreenState();
}

class _OurServicesScreenState extends State<OurServicesScreen> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  var scaffoldKey = GlobalKey<ScaffoldState>();

  OurServicesController ourServicesController =
      Get.put(OurServicesController());

  @override
  void initState() {
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
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await ourServicesController.getServices(
        page: pageKey,
        perPageRecord: ourServicesController.perPage,
      );
      final isLastPage = newItems.length < ourServicesController.perPage;
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
          title: "OUR SERVICES"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Showing Our Services For You",
              style: TextStyle(
                  color: appTheme.heading,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "CinzelDecorative"),
            ),
          ),
          Expanded(
            child: CustomPaginationView(
                onRefresh: () => Future.sync(() {
                      pagingController.refresh();
                    }),
                pagingController: pagingController,
                itemBuilder: (p0, p1, p2) {
                  return Padding(
                    padding: const EdgeInsets.only(),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.ourServicesDetailsScreen,
                            arguments: [p1]);
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 5, right: 5),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: appTheme.gray.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          color: appTheme.whiteA700,
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    MyImageWidget(
                                      height: 400,
                                      imageUrl:
                                          ApiNetwork.imageUrl + p1["image"],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: appTheme.black900,
                                                width: 3.0)),
                                      ),
                                      child: Text(
                                        p1["title"].toString(),
                                        style: TextStyle(
                                          color: appTheme.black900,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p1["sub_title"].toString(),
                                      style: TextStyle(
                                          color: appTheme.black900,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p1["description"].toString(),
                                      style: TextStyle(
                                        color: appTheme.black900,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      drawer: const SideMenu(),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? height;

  // Make sure imageUrl is nullable

  MyImageWidget({required this.imageUrl, this.height});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(
            height: height,
            width: double.infinity,
            imageUrl!,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child; // Image is fully loaded
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
              ); // Display an error icon if the image fails to load
            },
          )
        : CustomImageView(
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}
