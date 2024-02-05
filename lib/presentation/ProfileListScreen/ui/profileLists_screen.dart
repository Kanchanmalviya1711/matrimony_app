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
  const ProfileListsScreen({Key? key}) : super(key: key);

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
          children: [
            Padding(
              padding: const EdgeInsets.all(
                10,
              ),
              child: Text(
                "Showing All Profiles For You",
                style: TextStyle(
                    color: appTheme.heading,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "CinzelDecorative"),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                filterDialog(context, size, const ProfileListFilter());
              },
              child: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ],
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
                return Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: double.maxFinite,
                      decoration: const BoxDecoration(color: Colors.white),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        p1["user"]["firstName"]
                                            .toString()
                                            .capitalizeFirst!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        p1["user"]["lastName"]
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
                                    p1["user"]["emailAddress"].toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Paragraph
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(width: 5),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green
                                        // This is what you need!
                                        ),
                                    child: const Text(
                                      'Chat Now',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('WhatsApp'),
                                  ),
                                  const SizedBox(width: 5),
                                  ElevatedButton(
                                    onPressed: () {
                                      profileListController.sendFriendRequest(
                                        p1["user"]["id"].toString(),
                                        status[1]["id"].toString(),
                                      );
                                    },
                                    child: p1["friendRequest"]?["sender_id"]
                                                ["status"] ==
                                            1
                                        ? const Text('Pending...')
                                        : const Text('Send Interest'),
                                  ),
                                  const SizedBox(width: 5),
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