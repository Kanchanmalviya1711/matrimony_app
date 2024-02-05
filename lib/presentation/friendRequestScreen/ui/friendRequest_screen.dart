import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/friendRequestScreen/controller/friendRequest_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/empty_container.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_pagination_view.dart';

class FriendRequestScreen extends StatefulWidget {
  const FriendRequestScreen({Key? key}) : super(key: key);
  @override
  State<FriendRequestScreen> createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  var scaffoldKey = GlobalKey<ScaffoldState>();
  FriendRequestController friendRequestController =
      Get.put(FriendRequestController());

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
      final newItems = await friendRequestController.getRequestList(
        page: pageKey,
        perPageRecord: friendRequestController.perPage,
      );
      final isLastPage = newItems.length < friendRequestController.perPage;
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
      body: CustomPaginationView(
        noDataFound: () {
          Get.offNamed(AppRoutes.homeScreen);
        },
        onRefresh: () => Future.sync(() {
          pagingController.refresh();
        }),
        pagingController: pagingController,
        itemBuilder: (p0, p1, p2) {
          return p1['friendRequest']["status"].toString() == "1"
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appTheme.whiteA700,
                      border: Border.all(
                        color: appTheme.gray50,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
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
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${p1["friendRequest"]["sender_id"]["firstName"] ?? ""} ${p1["friendRequest"]["sender_id"]["lastName"] ?? ""}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: appTheme.black900,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    p1["friendRequest"]?["sender_id"]["address"]
                                            ?.toString() ??
                                        "",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: appTheme.gray500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: appTheme.green600,
                                          border: Border.all(
                                            color: appTheme.green600,
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          child: Text(
                                            "Accept",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: appTheme.whiteA700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        friendRequestController.acceptRequest(
                                            p1["friendRequest"]["sender_id"]
                                                    ["id"]
                                                .toString(),
                                            p1["friendRequest"]["id"]
                                                .toString());
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: appTheme.whiteA700,
                                          border: Border.all(
                                            color: appTheme.red600D8,
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          child: Text(
                                            "Reject",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: appTheme.red600D8,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        friendRequestController.rejectRequest(
                                            p1["friendRequest"]["sender_id"]
                                                    ["id"]
                                                .toString(),
                                            p1["friendRequest"]["id"]
                                                .toString());
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
