import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/presentation/myConnections/controller/myConnections_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
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
                "My Connection (10 People)",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
                      colors: [
                        Color.fromARGB(255, 248, 245, 242),
                        Color.fromARGB(255, 224, 223, 217)
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 6,
                        surfaceTintColor: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: ClipOval(
                                child: MyImageWidget(
                                  width: 80,
                                  height: 80,
                                  imageUrl: ApiNetwork.imageUrl +
                                      (p1["friendRequest"]["sender_id"]
                                              ["imagePath"] ??
                                          ""),
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
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "${p1["friendRequest"]["sender_id"]["firstName"]}"
                                              " " +
                                          p1["friendRequest"]["sender_id"]
                                              ["lastName"],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "${p1["friendRequest"]["sender_id"]["emailAddress"]}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "Phone- ${p1["friendRequest"]["sender_id"]["phone"]}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
  final double? height; // Make sure imageUrl is nullable

  MyImageWidget(
      {required this.imageUrl, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(
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
              return CustomImageView(
                height: height,
                width: width,
                fit: BoxFit.cover,
                imagePath: ImageConstant.couple1,
              ); // Display an error icon if the image fails to load
            },
          )
        : CustomImageView(
            height: height,
            width: width,
            fit: BoxFit.cover,
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}
