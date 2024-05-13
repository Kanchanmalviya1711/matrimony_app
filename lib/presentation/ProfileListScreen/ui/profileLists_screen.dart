import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_filter.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/controller/profileLists_controller.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/ui/profileList_filter.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_pagination_view.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class ProfileListsScreen extends StatefulWidget {
  String? searchItem;
  ProfileListsScreen({Key? key, this.searchItem}) : super(key: key);

  @override
  State<ProfileListsScreen> createState() => _ProfileListsScreenState();
}

class _ProfileListsScreenState extends State<ProfileListsScreen> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  ProfileListController profileListController =
      Get.put(ProfileListController());
  TextEditingController searchController = TextEditingController();
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
      final newItems = await profileListController.getUsers(
        searchTerm: widget.searchItem,
        page: pageKey,
        perPageRecord: profileListController.perPage,
      );
      final isLastPage = newItems.length < profileListController.perPage;
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

  var status = [
    {"id": "1", "title": "Accepted"},
    {"id": "2", "title": "Pending"},
    {"id": "3", "title": "Declined"},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(
                10,
              ),
              child: Text(
                "Showing All Members For You",
                style: TextStyle(
                    color: appTheme.heading,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "CinzelDecorative"),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                filterDialog(context, size, const ProfileListFilter());
              },
              child: Icon(
                Icons.search,
                color: appTheme.black900,
              ),
            ),
          ],
        ),
        Expanded(
          child: CustomPaginationView(
            noDataFound: () {
              Get.offAllNamed(AppRoutes.homeScreen);
            },
            onRefresh: () => Future.sync(() {
              profileListController.clearInputField();
              pagingController.refresh();
              //profileListController.getUsers(searchTerm: null);
              Get.offAllNamed(AppRoutes.homeScreen, arguments: [1, null]);
            }),
            pagingController: pagingController,
            itemBuilder: (p0, p1, p2) {
              return Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: p1["user"] == null
                    ? const SizedBox(height: 250)
                    : Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(color: appTheme.whiteA700),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      MyImageWidget(
                                          height: size.height * 0.4,
                                          width: double.maxFinite,
                                          imageUrl: ApiNetwork.imageUrl +
                                              p1["user"]["imagePath"]),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                p1["user"]["fullName"]
                                                    .toString()
                                                    .capitalizeFirst!,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            p1["user"]["emailAddress"]
                                                .toString()
                                                .capitalizeFirst!,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: appTheme.black908,
                                            ),
                                          ),
                                          Text(
                                            "+91- ${p1["user"]["phone"].toString()}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: appTheme.black908,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            profileListController
                                                .sendFriendRequest(
                                              p1["user"]["id"].toString(),
                                              status[1]["id"].toString(),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: p1["friendRequest"]
                                                            ?["sender_id"]
                                                        ["status"] ==
                                                    1
                                                ? appTheme.siteName
                                                : appTheme.newGreen,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 15,
                                            ),
                                          ),
                                          child: p1["friendRequest"]
                                                          ?["sender_id"]
                                                      ["status"] ==
                                                  1
                                              ? Text(
                                                  'Pending...',
                                                  style: TextStyle(
                                                      color: appTheme.whiteA700,
                                                      fontSize: 15),
                                                )
                                              : Text(
                                                  'Send Interest',
                                                  style: TextStyle(
                                                      color: appTheme.whiteA700,
                                                      fontSize: 15),
                                                ),
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
            },
          ),
        ),
      ],
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  MyImageWidget({required this.imageUrl, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(
            imageUrl!,
            height: height,
            width: width ?? double.maxFinite,
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
                width: width ?? double.maxFinite,
                fit: BoxFit.cover,
                imagePath: ImageConstant.couple1,
              ); // Display an error icon if the image fails to load
            },
          )
        : CustomImageView(
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}
    //  Container(
    //       margin: const EdgeInsets.only(left: 10, right: 10),
    //       width: double.infinity,
    //       child: ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //             primary: appTheme.gray400,
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(10))),
    //         onPressed: () {
    //           filterDialog(context, size, const ProfileListFilter());
    //         },
    //         child: Row(
    //           children: [
    //             Icon(
    //               Icons.search,
    //               color: appTheme.gray500,
    //             ),
    //             const SizedBox(
    //               width: 5,
    //             ),
    //             Text(
    //               "Search By Name",
    //               style: TextStyle(color: appTheme.gray500),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),