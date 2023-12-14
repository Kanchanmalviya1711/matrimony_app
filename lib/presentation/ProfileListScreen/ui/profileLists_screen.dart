import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/presentation/ProfileListScreen/controller/profileLists_controller.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_pagination_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Showing All Profiles For You",
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
                  padding: const EdgeInsets.all(10),
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
                              CachedNetworkImage(
                                height: size.height * 0.3,
                                imageUrl: p1["imagePath"],
                                placeholder: (context, url) => CustomImageView(
                                    imagePath: ImageConstant.couple1,
                                    width: 300),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
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
                                        p1["firstName"]
                                            .toString()
                                            .capitalizeFirst!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        p1["lastName"]
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
                                    p1["emailAddress"]
                                        .toString()
                                        .capitalizeFirst!,
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
                                      'Chat now',
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
                                    onPressed: () {},
                                    child: const Text('Send Interest'),
                                  ),
                                  const SizedBox(width: 5),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Get.offAllNamed(
                                      //     AppRoutes.allProfilesScreen);
                                    },
                                    child: const Text('More Details'),
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
