import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/presentation/friendRequestScreen/ui/friendRequest_screen.dart';
import 'package:matrimony_app/presentation/notifications/controller/notifications_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_pagination_view.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  var scaffoldKey = GlobalKey<ScaffoldState>();
  NotificationsController notificationsController =
      Get.put(NotificationsController());

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
      final newItems = await notificationsController.getAllNotification(
        page: pageKey,
        perPageRecord: notificationsController.perPage,
      );
      final isLastPage = newItems.length < notificationsController.perPage;
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
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.homeScreen);
          },
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.whiteA700,
          ),
        ),
        title: "All NOTIFICATIONS",
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(
                    text: "Notifications",
                    icon: Icon(Icons.all_inbox),
                  ),
                  Tab(text: "Interested Request", icon: Icon(Icons.message)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  CustomPaginationView(
                      noDataFound: () {
                        Get.offNamed(AppRoutes.homeScreen);
                      },
                      onRefresh: () => Future.sync(() {
                            pagingController.refresh();
                          }),
                      pagingController: pagingController,
                      itemBuilder: (p0, p1, p2) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ClipOval(
                                  child: CustomImageView(
                                      height: 50,
                                      width: 50,
                                      imagePath: ImageConstant.couple1),
                                ),
                              ),
                              title: Text(
                                p1["userId"]["firstName"].toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: appTheme.black900,
                                ),
                              ),
                              subtitle: Text(
                                p1['message'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: appTheme.gray500,
                                ),
                              ),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  color: appTheme.heading,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ClipOval(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      p1["userId"]["createdAt"] == null
                                          ? "00:00"
                                          : p1["userId"]["createdAt"]
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: appTheme.whiteA700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: appTheme.gray200,
                              thickness: 1,
                            ),
                          ],
                        );
                      }),
                  const FriendRequestScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;

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
                return child; // Displaying the image if it's already loaded
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
                width: 200,
                height: height,
                fit: BoxFit.cover,
                imagePath: ImageConstant.couple1,
              );
            },
          )
        : CustomImageView(
            width: 200,
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}
