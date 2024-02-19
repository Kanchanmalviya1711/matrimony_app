import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/contact/controller/contact_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_circuler_loader.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SuscriptionScreen extends StatefulWidget {
  const SuscriptionScreen({Key? key}) : super(key: key);

  @override
  _SuscriptionScreenState createState() => _SuscriptionScreenState();
}

class _SuscriptionScreenState extends State<SuscriptionScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  ContactUsController contactUsController = Get.put(ContactUsController());

  @override
  void initState() {
    super.initState();
    contactUsController.getContact();
  }

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
        title: "TAKE SUSCRIPTION",
      ),
      body: Obx(() {
        if (contactUsController.rxRequestStatus.value == Status.loading) {
          return const Center(
            child: Text("No Data Found"),
          );
        } else if (contactUsController.rxRequestStatus.value ==
            Status.success) {
          return ListView.builder(
            itemCount: contactUsController.getContactUsDetails.length,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: appTheme.black900,
                contentPadding: const EdgeInsets.all(0),
                title: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFfdfcfb), Color(0xFFFFFBEE)],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                                    child: const Text(
                                      'Get Started !',
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: "PlayfairDisplay"),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Get the best plan for you",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
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
                                            color: Color.fromARGB(
                                                255, 221, 220, 220),
                                            fontFamily: "Poppins",
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: appTheme.credit,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Text(
                                            "No Credit Card Required. No Hidden Charges.",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
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
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 350, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: appTheme.whiteA700,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        child: Text(
                                          "Free",
                                          style: TextStyle(
                                              color: appTheme.heading,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "CinzelDecorative"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        child: Text(
                                          "Free plan for you to get started.",
                                          style: TextStyle(
                                            color: appTheme.headerColor,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: const Color(0xFFFFE4E6),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Get Started",
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Poppins",
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$0/month".toLowerCase(),
                                        style: TextStyle(
                                          color: appTheme.black900,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                    title: Text(
                                                        '5 Premium profiles View/month'),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green),
                                                    title: Text(
                                                        'Free users profiles can view'),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.close,
                                                        color: Colors.red),
                                                    title: Text('Start Chat'),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                    title: Text(
                                                        'View Contact Details'),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                    title:
                                                        Text('Send Interest'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          color: appTheme.headerColor,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: appTheme.whiteA700,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: const Color(0xFFFFF4BB),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Recommended Plan",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Color(0xFF9C8409),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Poppins",
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child: Text(
                                      "Gold",
                                      style: TextStyle(
                                          color: appTheme.heading,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "CinzelDecorative"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Text(
                                      "Take gold plan and start membership",
                                      style: TextStyle(
                                        color: appTheme.headerColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: const Color.fromRGBO(
                                            215, 67, 84, 20),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text(
                                          "Get Started",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Poppins",
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "\$349/month".toLowerCase(),
                                    style: TextStyle(
                                      color: appTheme.black900,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green),
                                                title: Text(
                                                    '20 Premium profiles can view/month'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green),
                                                title: Text(
                                                    'Free users profiles can view'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green),
                                                title: Text(
                                                    'View Contact Details'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green),
                                                title: Text('Send Interest'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green),
                                                title: Text('Start Chat'),
                                              ),
                                            ],
                                          ),
                                        ],
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
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          color: appTheme.headerColor,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: appTheme.whiteA700,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child: Text(
                                      "Platinum",
                                      style: TextStyle(
                                          color: appTheme.heading,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "CinzelDecorative"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Text(
                                      "Take platinum plan and start your journey",
                                      style: TextStyle(
                                        color: appTheme.headerColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: const Color(0xFFFFE4E6),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text(
                                          "Get Started",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Poppins",
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    "\$549/month".toLowerCase(),
                                    style: TextStyle(
                                      color: appTheme.black900,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              ListTile(
                                                leading: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green),
                                                title: Text(
                                                    '50 Premium Profiles View/month'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                ),
                                                title: Text(
                                                    'Free users profiles can view'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                ),
                                                title: Text(
                                                    'View Contact Details'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                ),
                                                title: Text('Send Interest'),
                                              ),
                                              ListTile(
                                                leading: Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                ),
                                                title: Text('Start Chat'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  //borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFFF166C),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(50),
                                  child: Text(
                                    "Free Support 24/7. No Hidden Charges. Cancel Anytime.",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "GET IN TOUCH",
                                style: TextStyle(
                                  color: appTheme.black900,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "If you have any questions, feel free to contact us.",
                                style: TextStyle(
                                  color: appTheme.black900,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: Text(
                                "28800 Orchard lake road, suite 180, farmington hills, MI 48334, USA",
                                style: TextStyle(
                                  color: appTheme.black900,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Divider(color: appTheme.gray),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Phone: +91 1234567890",
                                style: TextStyle(
                                  color: appTheme.black900,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Email: helpsoulmate@gmail.com",
                                style: TextStyle(
                                  color: appTheme.black900,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Website: www.soulmate.com",
                                style: TextStyle(
                                  color: appTheme.black900,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Divider(
                                color: appTheme.gray,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'HELP AND SUPPORT',
                                      style: TextStyle(
                                        color: appTheme.black900,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.offAndToNamed(
                                                AppRoutes.aboutScreen);
                                          },
                                          child: Text(
                                            "About Company",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: appTheme.black900,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        GestureDetector(
                                          onTap: () {
                                            Get.offAndToNamed(
                                                AppRoutes.contactUsScreen);
                                          },
                                          child: Text(
                                            "Contact Us",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: appTheme.black900,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        GestureDetector(
                                          onTap: () {
                                            Get.offAndToNamed(
                                                AppRoutes.ourServiceScreen);
                                          },
                                          child: Text(
                                            "Our Services",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: appTheme.black900,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        GestureDetector(
                                          child: Text(
                                            "Feedback",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: appTheme.black900,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        GestureDetector(
                                          onTap: () {
                                            Get.offAndToNamed(
                                                AppRoutes.testimonialsScreen);
                                          },
                                          child: Text(
                                            "Testimonials",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: appTheme.black900,
                                              fontSize: 15,
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
                              padding: const EdgeInsets.all(10),
                              child: Divider(
                                color: appTheme.gray,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'FOLLOW US',
                                    style: TextStyle(
                                      color: appTheme.black900,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              // 1 linkedIn
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: appTheme.gray200,
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    launch(
                                                        'https://www.linkedin.com/');
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CustomIconButton(
                                                      child: SvgPicture.asset(
                                                        ImageConstant.linkedin,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              // 2 facebook
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: appTheme.gray200,
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    launch(
                                                        'https://www.facebook.com/');
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CustomIconButton(
                                                      child: SvgPicture.asset(
                                                        ImageConstant.facebook,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              // 3 twitter
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: appTheme.gray200,
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    launch(
                                                        'https://twitter.com/');
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CustomIconButton(
                                                      child: SvgPicture.asset(
                                                        ImageConstant.twitter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(width: 10),
                                              // 4 youtube
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: appTheme.gray200,
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    launch(
                                                        'https://www.youtube.com/');
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: CustomIconButton(
                                                      child: SvgPicture.asset(
                                                        ImageConstant.youtube,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Divider(
                                color: appTheme.gray,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Company name site- Trusted by over thousands of people worldwide. for there success marriage.",
                                style: TextStyle(
                                  color: appTheme.black900,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: CustomElevatedButton(
                                buttonStyle: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      appTheme.red600D8),
                                ),
                                text: "Explore Us Today",
                                buttonTextStyle:
                                    CustomTextStyles.titleMediumBlackA700,
                                onTap: () {
                                  setState(() {
                                    Get.toNamed(AppRoutes.allProfilesScreen);
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Divider(
                                color: appTheme.gray,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "© 2021 Soulmate. All rights reserved.",
                                style: TextStyle(
                                  color: appTheme.black900,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
      drawer: const SideMenu(),
    );
  }
}
