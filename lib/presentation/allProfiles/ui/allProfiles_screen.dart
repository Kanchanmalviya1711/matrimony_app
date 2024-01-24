// ignore_for_file: unnecessary_null_comparison
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/presentation/allProfiles/controller/allProfiles_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:matrimony_app/widgets/custom_pagination_view.dart';

class AllProfilesScreen extends StatefulWidget {
  const AllProfilesScreen({Key? key}) : super(key: key);

  @override
  _AllProfilesScreenState createState() => _AllProfilesScreenState();
}

class _AllProfilesScreenState extends State<AllProfilesScreen> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  var scaffoldKey = GlobalKey<ScaffoldState>();

  AllProfilesListController allProfilesListController =
      Get.put(AllProfilesListController());

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
      final newItems = await allProfilesListController.getAllProfiles(
        page: pageKey,
        perPageRecord: allProfilesListController.perPage,
      );
      final isLastPage = newItems.length < allProfilesListController.perPage;
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
        title: "ALL PROFILES",
      ),
      body: Container(
        color: appTheme.gray200,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Showing All Profiles For You ",
              style: TextStyle(
                  color: appTheme.heading,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "CinzelDecorative"),
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
                                Stack(
                                  children: [
                                    MyImageWidget(
                                        width: double.infinity,
                                        height: size.height * 0.4,
                                        imageUrl: p1["user"] == null
                                            ? ImageConstant.couple1
                                            : ApiNetwork.imageUrl +
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
                                    Container(
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: appTheme.black900,
                                                width: 3.0)),
                                      ),
                                      child: Text(
                                        p1["user"] == null
                                            ? "No Name Found"
                                            : "${p1["user"]["firstName"].toString()} ${p1["user"]["lastName"].toString()}",
                                        style: TextStyle(
                                          color: appTheme.black900,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: appTheme.gray500),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                p1["profession"] == null
                                                    ? "no data"
                                                    : p1["profession"]
                                                        .toString()
                                                        .capitalizeFirst!,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: appTheme.whiteA700),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: appTheme.gray500),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                p1["height"] == null
                                                    ? "No such height"
                                                    : 'Height: ${p1["height"].toString()} Cm',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: appTheme.whiteA700),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: appTheme.gray500),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                p1["user"] == null
                                                    ? "No Date of Birth Found"
                                                    : _formatDateOfBirth(
                                                        p1["user"]
                                                            ["dateOfBirth"]),
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: appTheme.whiteA700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: appTheme.gray500),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                p1["education"] == null
                                                    ? "No Education"
                                                    : 'Education: ${p1["education"].toString()}',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: appTheme.whiteA700),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Paragraph
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: CustomElevatedButton(
                                  buttonStyle: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        appTheme.green600),
                                  ),
                                  text: "More Details",
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes.viewAllProfilesScreen,
                                      arguments: [p1],
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ]),
      ),
      drawer: const SideMenu(),
      // Home page
    );
  }
}

class CustomCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;

  const CustomCard({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      width: 200,
      height: 200,
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: imageAsset,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(subtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
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
    return imageUrl != null
        ? Image.network(
            imageUrl!,
            width: width,
            height: height,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
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
                height: height,
                imagePath: ImageConstant.couple1,
                width: width,
              );
            },
          )
        : CustomImageView(
            imagePath: ImageConstant.couple1,
          );
  }
}

// Function to format the date of birth
String _formatDateOfBirth(dynamic dateOfBirth) {
  try {
    if (dateOfBirth != null && dateOfBirth.toString().isNotEmpty) {
      DateTime? parsedDate = DateTime.tryParse(dateOfBirth.toString());
      if (parsedDate != null) {
        // Calculate age based on the parsed date of birth
        int age = DateTime.now().year - parsedDate.year;
        return 'Age: $age';
      }
    }
  } catch (e) {
    print("Error formatting date of birth: $e");
  }
  return 'No Date Found';
}
