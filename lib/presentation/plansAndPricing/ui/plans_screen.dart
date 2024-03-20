import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/plansAndPricing/controller/plans_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class PlansAndPricingScreen extends StatefulWidget {
  const PlansAndPricingScreen({super.key});
  @override
  State<PlansAndPricingScreen> createState() => _PlansAndPricingScreenState();
}

class _PlansAndPricingScreenState extends State<PlansAndPricingScreen> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  var scaffoldKey = GlobalKey<ScaffoldState>();
  PlansAndPricingController plansAndPricingController =
      Get.put(PlansAndPricingController());
  @override
  void initState() {
    super.initState();
    plansAndPricingController.getPlansAndPricing();
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
        title: "Plans And Pricing",
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Obx(() {
            if (plansAndPricingController.rxRequestStatus.value ==
                Status.loading) {
              return const Center(child: Text("No Data Found"));
            } else if (plansAndPricingController.rxRequestStatus.value ==
                Status.success) {
              return buildContent();
            } else if (plansAndPricingController.rxRequestStatus.value ==
                Status.error) {
              return const Center(child: Text("Something went wrong"));
            } else {
              return const Center(child: Text("No data found"));
            }
          }),
        ],
      ),
      drawer: const SideMenu(),
    );
  }

  Widget buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 400,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF9E2A65),
                      Color(0xFFda4453),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Pricing",
                          style: TextStyle(
                            color: appTheme.whiteA700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 212, 204, 208),
                              Color.fromARGB(255, 202, 197, 197),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          'Get Started !',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: appTheme.whiteA700,
                              fontFamily: "PlayfairDisplay"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Get the best plan for you",
                              style: TextStyle(
                                fontSize: 20,
                                color: appTheme.whiteA700,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Choose the best plan for you and get started. And you can cancel anytime.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 221, 220, 220),
                                fontFamily: "Poppins",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: appTheme.credit,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "No Credit Card Required. No Hidden Charges.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: appTheme.whiteA700,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 350, bottom: 10),
                child: Card(
                  elevation: 5,
                  surfaceTintColor: appTheme.whiteA700,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Text("All Invoices",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.invoiceImg,
                            width: mediaQueryData.size.width * 0.35,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  plansAndPricingController.allPlans.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Plan Name",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: appTheme.headerColor,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          "${plansAndPricingController.allPlans[index]["plan_type"] ?? "No plan found"}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: plansAndPricingController
                                                            .allPlans[index]
                                                        ["plan_type"] ==
                                                    null
                                                ? appTheme.red600D8
                                                : appTheme.headerColor,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Cost:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: appTheme.headerColor,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.currency_rupee,
                                              size: 18,
                                              color: appTheme.headerColor,
                                            ),
                                            Text(
                                              "${plansAndPricingController.allPlans[index]["cost"]} /m",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: appTheme.headerColor,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Duration:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: appTheme.headerColor,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          color: appTheme.black900,
                                          width:
                                              mediaQueryData.size.width * 0.5,
                                          child: Text(
                                            "${plansAndPricingController.allPlans[index]["duration"]} ${plansAndPricingController.allPlans[index]["duration"] == 1 ? 'month' : 'months'}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: appTheme.whiteA700,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Features:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: appTheme.headerColor,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  plansAndPricingController
                                                                      .allPlans[
                                                                  index]
                                                              ["plan_type"] ==
                                                          "Free"
                                                      ? Icons.close
                                                      : Icons.check_circle,
                                                  size: 18,
                                                  color: plansAndPricingController
                                                                      .allPlans[
                                                                  index]
                                                              ["plan_type"] ==
                                                          "Free"
                                                      ? appTheme.red600D8
                                                      : appTheme.green600,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "${plansAndPricingController.allPlans[index]["feature1"]}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: plansAndPricingController
                                                                        .allPlans[
                                                                    index]
                                                                ["plan_type"] ==
                                                            "Free"
                                                        ? appTheme.red600D8
                                                        : appTheme.green600,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.check_circle,
                                                  size: 18,
                                                  color: appTheme.green600,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "${plansAndPricingController.allPlans[index]["feature2"]}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: appTheme.green600,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Icon(
                                                  plansAndPricingController
                                                                      .allPlans[
                                                                  index]
                                                              ["plan_type"] ==
                                                          "Free"
                                                      ? Icons.close
                                                      : Icons.check_circle,
                                                  size: 18,
                                                  color: plansAndPricingController
                                                                      .allPlans[
                                                                  index]
                                                              ["plan_type"] ==
                                                          "Free"
                                                      ? appTheme.red600D8
                                                      : appTheme.green600,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "${plansAndPricingController.allPlans[index]["feature3"]}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: plansAndPricingController
                                                                        .allPlans[
                                                                    index]
                                                                ["plan_type"] ==
                                                            "Free"
                                                        ? appTheme.red600D8
                                                        : appTheme.green600,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Icon(
                                                  plansAndPricingController
                                                                      .allPlans[
                                                                  index]
                                                              ["plan_type"] ==
                                                          "Free"
                                                      ? Icons.close
                                                      : Icons.check_circle,
                                                  size: 18,
                                                  color: plansAndPricingController
                                                                      .allPlans[
                                                                  index]
                                                              ["plan_type"] ==
                                                          "Free"
                                                      ? appTheme.red600D8
                                                      : appTheme.green600,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "${plansAndPricingController.allPlans[index]["feature4"]}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: plansAndPricingController
                                                                        .allPlans[
                                                                    index]
                                                                ["plan_type"] ==
                                                            "Free"
                                                        ? appTheme.red600D8
                                                        : appTheme.green600,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Icon(
                                                  plansAndPricingController
                                                                      .allPlans[
                                                                  index]
                                                              ["plan_type"] ==
                                                          "Free"
                                                      ? Icons.close
                                                      : Icons.check_circle,
                                                  size: 18,
                                                  color: plansAndPricingController
                                                                      .allPlans[
                                                                  index]
                                                              ["plan_type"] ==
                                                          "Free"
                                                      ? appTheme.red600D8
                                                      : appTheme.green600,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "${plansAndPricingController.allPlans[index]["feature5"]}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: plansAndPricingController
                                                                        .allPlans[
                                                                    index]
                                                                ["plan_type"] ==
                                                            "Free"
                                                        ? appTheme.red600D8
                                                        : appTheme.green600,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: appTheme.headerColor,
                                    ),
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome to",
                  style: TextStyle(
                    fontFamily: 'CinzelDecorative',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: appTheme.heading,
                  ),
                ),
                const SizedBox(height: 10),
                CustomImageView(
                  imagePath: ImageConstant.logoImg,
                  width: 250,
                ),
                const SizedBox(height: 16),
                Text(
                  "Finding your life partner is a journey filled with excitement,"
                  "and we are here to make that journey smoother and more meaningful."
                  "Soulmate is a platform dedicated to helping individuals"
                  "discover their perfect match and embark on a lifelong journey of love"
                  "and companionship",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: appTheme.headerColor,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.allProfilesScreen);
                  },
                  child: Text(
                    "Click here to start your matrimony service now.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: appTheme.blue1600,
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(height: 10),
                Text(
                  "Create your profile by providing essential details about yourself."
                  "Add photos and share your interests to make your profile stand out.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: appTheme.headerColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: appTheme.planCancel,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Plan cancellation. Click Here to cancel the Current Plan",
                      style: TextStyle(
                          color: appTheme.black900,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class MyImageWidget extends StatelessWidget {
  final String? imageUrl; // Make sure imageUrl is nullable
  MyImageWidget({required this.imageUrl, required double height});
  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(
            imageUrl!,
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
                imagePath: ImageConstant.couple1,
              ); // Display an error icon if the image fails to load
            },
          )
        : CustomImageView(
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}
