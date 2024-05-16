import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/presentation/myConnections/controller/myConnections_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_pagination_view.dart';

class MyConnectionsScreen extends StatefulWidget {
  const MyConnectionsScreen({Key? key}) : super(key: key);
  @override
  State<MyConnectionsScreen> createState() => _MyConnectionsScreenState();
}

class _MyConnectionsScreenState extends State<MyConnectionsScreen> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  var scaffoldKey = GlobalKey<ScaffoldState>();
  MyConnectionsController myConnectionsController =
      Get.put(MyConnectionsController());

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
      final newItems = await myConnectionsController.getConnectionsList(
        page: pageKey,
        perPageRecord: myConnectionsController.perPage,
      );
      final isLastPage = newItems.length < myConnectionsController.perPage;
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
      body: Column(
        children: [
          Container(
            color: Colors.black,
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "My Matches",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: CustomPaginationView(
              noDataFound: () {
                Get.offAllNamed(AppRoutes.homeScreen);
              },
              onRefresh: () => Future.sync(() {
                pagingController.refresh();
                // Get.offAllNamed(AppRoutes.homeScreen);
              }),
              pagingController: pagingController,
              itemBuilder: (p0, p1, p2) {
                return Padding(
                  padding: const EdgeInsets.all(0.2),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 211, 109, 7),
                          Color.fromARGB(255, 214, 213, 209)
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: ClipOval(
                                child: MyImageWidget(
                                  width: 60,
                                  height: 60,
                                  imageUrl: ApiNetwork.imageUrl +
                                      (p1["user"]["imagePath"]),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p1["user"]["fullName"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: appTheme.whiteA700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${p1["user"]["emailAddress"]}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: appTheme.whiteA700,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Phone- ${p1["user"]["phone"]}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: appTheme.whiteA700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                AppRoutes
                                                    .viewAllMyConnectionsProfile,
                                                arguments: [p1],
                                              );
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: appTheme.green600,
                                              child: Text(
                                                "View Profile",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: appTheme.whiteA700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                AppRoutes.chatUiScreen,
                                                arguments: [p1],
                                              );
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: appTheme.tealColor,
                                              child: Text(
                                                "Chat Now",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: appTheme.whiteA700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                color: appTheme.red600D8,
                                                child: Text(
                                                  "Remove",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: appTheme.whiteA700,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                myConnectionsController
                                                    .removeRequest(
                                                  p1["friendRequest"]["id"]
                                                      .toString(),
                                                  p1["friendRequest"]
                                                          ["sender_id"]["id"]
                                                      .toString(),
                                                  p1["friendRequest"]
                                                          ["receiver_id"]["id"]
                                                      .toString(),
                                                );
                                              }),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;

  MyImageWidget({
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        width: width,
        height: height,
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
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }
        },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {
      return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    return CustomImageView(
      height: height ?? 80,
      width: width ?? 80,
      fit: BoxFit.cover,
      imagePath: ImageConstant.userProfile,
    );
  }
}
