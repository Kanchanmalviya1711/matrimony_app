import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/contact/controller/contact_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
        title: "CONTACT US",
      ),
      body: Obx(() {
        if (contactUsController.rxRequestStatus.value == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (contactUsController.rxRequestStatus.value ==
            Status.success) {
          return ListView.builder(
            itemCount: contactUsController.getContactUsDetails.length,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: Colors.black,
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
                    children: [
                      Container(
                        height: 300,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFF2a262691), Color(0xFF2a2c3c)],
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
                                  "WE ARE HERE TO ASSIST YOU",
                                  style: TextStyle(
                                    color: appTheme.firstSite,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return const LinearGradient(
                                    colors: [
                                      Color(0xFF00ff72),
                                      Color(0xFF66b5ff)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ).createShader(bounds);
                                },
                                child: const Text(
                                  'Contact Us !',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: "PlayfairDisplay"),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Most Trusted and premium Matrimony Service in the World.",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          elevation: 5,
                          surfaceTintColor: Colors.white,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconButton(
                                  child: CustomImageView(
                                    imagePath: ImageConstant.prize,
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Column(
                                  children: [
                                    Text(
                                      'Contact Info',
                                      style: TextStyle(
                                          color: appTheme.heading,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "CinzelDecorative"),
                                    ),
                                    Text(
                                      "Our Office",
                                      style: TextStyle(
                                        color: appTheme.blue600,
                                        fontSize: 30,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    ListTile(
                                        leading: const Icon(Icons.person),
                                        title: const Text('Contact Person'),
                                        subtitle: Text(contactUsController
                                            .getContactUsDetails[index]['name']
                                            .toString())),
                                    ListTile(
                                        leading:
                                            const Icon(Icons.phone_android),
                                        title: const Text('Phone Number'),
                                        subtitle: Text(contactUsController
                                            .getContactUsDetails[index]
                                                ['mobile_number']
                                            .toString())),
                                    ListTile(
                                      leading: const Icon(Icons.email),
                                      title: const Text('Email'),
                                      subtitle: Text(contactUsController
                                          .getContactUsDetails[index]['email']
                                          .toString()),
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.map_rounded),
                                      title: const Text('Address'),
                                      subtitle: Text(contactUsController
                                              .getContactUsDetails[index]
                                          ["address"]),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          elevation: 5,
                          surfaceTintColor: Colors.white,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconButton(
                                  child: CustomImageView(
                                    imagePath: ImageConstant.trust,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'CUSTOMER RELATIONS',
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Most Trusted and premium Matrimony Service in the World.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: appTheme.heading,
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 200,
                                  child: CustomElevatedButton(
                                    buttonStyle: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              appTheme.heading),
                                    ),
                                    text: "Get Support",
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          elevation: 5,
                          surfaceTintColor: Colors.white,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconButton(
                                  child: CustomImageView(
                                    imagePath: ImageConstant.contactUs,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'WHATSAPP SUPPORT',
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Most Trusted and premium Matrimony Service in the World.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: appTheme.heading,
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 200,
                                  child: CustomElevatedButton(
                                    buttonStyle: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              appTheme.heading),
                                    ),
                                    text: "Talk to Sales",
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: Text("Data not found"));
      }),
      drawer: const SideMenu(),
    );
  }
}
