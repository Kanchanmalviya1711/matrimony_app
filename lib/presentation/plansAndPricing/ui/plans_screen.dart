import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/presentation/plansAndPricing/controller/plans_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({Key? key}) : super(key: key);
  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  PlansAndPricingController plansAndPricingController =
      Get.put(PlansAndPricingController());

  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    plansAndPricingController.getTestimonials();
  }

  var planList = [
    {
      "plantype": "Platinum",
      "Duration": "12 Months (May 2023) - 12 Months (May 2024)",
      "Cost": "Rs. 5000",
    },
    {
      "plantype": "Gold",
      "Duration": "6 Months (May 2023) - 6 Months (May 2024)",
      "Cost": "Rs. 3000",
    },
    {
      "plantype": "Silver",
      "Duration": "3 Months (May 2023) - 3 Months (May 2024)",
      "Cost": "Rs. 2000",
    },
  ];

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
        title: "PLANS & PRICING",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "Choose your plan",
                      style: TextStyle(
                        fontFamily: 'CinzelDecorative',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: appTheme.heading,
                      ),
                    ),
                    Text(
                      "Plan Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: appTheme.black900,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Card(
                elevation: 5,
                surfaceTintColor: appTheme.whiteA700,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text("Current Plan",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.planImg,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Plan Name: Standard",
                          style: TextStyle(
                            fontSize: 18,
                            color: appTheme.heading,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Validity: 6 Month",
                          style: TextStyle(
                            fontSize: 16,
                            color: appTheme.headerColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "Valid Till: 12/12/2024",
                          style: TextStyle(
                            fontSize: 16,
                            color: appTheme.headerColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: appTheme.red600D8,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Upgrade Now",
                              style: TextStyle(
                                fontSize: 16,
                                color: appTheme.whiteA700,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: planList.length,
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
                                          "${planList[index]["plantype"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: appTheme.headerColor,
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
                                        Text(
                                          "${planList[index]["Cost"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: appTheme.headerColor,
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
                                          "Duration:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: appTheme.headerColor,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          color: appTheme.black900,
                                          width:
                                              mediaQueryData.size.width * 0.5,
                                          child: Text(
                                            "${planList[index]["Duration"]}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: appTheme.whiteA700,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
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
                    child: const Text(
                      "Click here to start your matrimony service now.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
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
          ],
        ),
      ),
      drawer: const SideMenu(),
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
