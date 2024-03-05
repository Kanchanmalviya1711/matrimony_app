import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/custom_widget/custom_drawer.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/utils/string_capitalization.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var getUserData;
  var getUserProfileData;

  getData() async {
    getUserData = json.decode(SessionManager.getUser().toString());
    print("getProfileDataDisplay ${getUserData}");
  }

  getProfileData() async {
    getUserProfileData =
        json.decode(SessionManager.getUserProfileData().toString());
    print("getUserprofile ${getUserProfileData}");
  }

  @override
  void initState() {
    getData();
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        centerTitle: true,
        leading: CustomIconButton(
          child: IconButton(
            onPressed: () {
              Get.offNamed(AppRoutes.homeScreen);
            },
            icon: Icon(
              Icons.arrow_back,
              color: appTheme.whiteA700,
            ),
          ),
        ),
        title: "MY PROFILE",
        actions: [
          PopupMenuButton(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: appTheme.whiteA700),
            ),
            icon: Icon(
              Icons.edit,
              color: appTheme.whiteA700,
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.edit_attributes,
                        color: appTheme.black900, size: 20),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Edit User",
                      style: CustomTextStyles.titleSmall_1,
                    ),
                  ],
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.registerScreen,
                      arguments: [getUserProfileData]);
                },
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.edit, color: appTheme.black900, size: 20),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      getUserData == null ? "Complete Profile" : "Edit Profile",
                      style: CustomTextStyles.titleSmall_1,
                    ),
                  ],
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.createProfileScreen,
                      arguments: [getUserData]);
                },
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.logout, color: appTheme.black900, size: 20),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Logout",
                      style: CustomTextStyles.titleSmall_1,
                    ),
                  ],
                ),
                onTap: () {
                  showAlertDialog(
                    context,
                    () {
                      Get.back();
                    },
                    () {
                      SessionManager.removeToken();
                      Get.offAllNamed(AppRoutes.loginScreen);
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              setState(() {
                getData();
                getProfileData();
              });
            },
            child: Stack(
              children: [
                MyImageWidget(
                  height: 400,
                  imageUrl:
                      ApiNetwork.imageUrl + getUserProfileData["imagePath"],
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 10,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${getUserProfileData["firstName"]} ${getUserProfileData["lastName"]}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                getUserData == null
                                    ? "No data found"
                                    : getUserData["nickName"] == null
                                        ? "No nickname found"
                                        : "(${getUserData["nickName"].toString()})",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "By Profession ${getUserData == null ? "No Data Found" : getUserData["profession"]} ",
                            style: TextStyle(
                              color: appTheme.heading,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
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
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: appTheme.profileView,
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "100+ Viewers",
                          style: TextStyle(
                              color: appTheme.whiteA700,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )),
                  const SizedBox(width: 10),
                  Container(
                      decoration: BoxDecoration(
                          color: appTheme.onlineAvail,
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Available Online",
                          style: TextStyle(
                              color: appTheme.whiteA700,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )),
                ]),
          ),
          const Divider(),
          const SizedBox(height: 10),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "About",
                  style: TextStyle(
                      color: appTheme.heading,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "CinzelDecorative"),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    getUserData == null
                        ? "No Data Found"
                        : getUserData["aboutYourself"].toString(),
                    style: TextStyle(
                        color: appTheme.heading,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.4),
                  ),
                ),
              ]),
          const Divider(),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Photo Gallery",
                        style: TextStyle(
                            color: appTheme.heading,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "CinzelDecorative"),
                      ),
                      const SizedBox(height: 30),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MyImageWidget(
                                  width: 200,
                                  height: mediaQueryData.size.height * 0.3,
                                  imageUrl: getUserData == null
                                      ? ImageConstant.userProfile
                                      : getUserData["photo1"] == null
                                          ? ImageConstant.userProfile
                                          : ApiNetwork.imageUrl +
                                              getUserData["photo1"]),
                              const SizedBox(
                                width: 10,
                              ),
                              MyImageWidget(
                                  width: 200,
                                  height: mediaQueryData.size.height * 0.3,
                                  imageUrl: getUserData == null
                                      ? ImageConstant.userProfile
                                      : getUserData["photo2"] == null
                                          ? ImageConstant.userProfile
                                          : ApiNetwork.imageUrl +
                                              getUserData["photo2"]),
                              const SizedBox(
                                width: 10,
                              ),
                              MyImageWidget(
                                  width: 200,
                                  height: mediaQueryData.size.height * 0.3,
                                  imageUrl: getUserData == null
                                      ? ImageConstant.userProfile
                                      : getUserData["photo3"] == null
                                          ? ImageConstant.userProfile
                                          : ApiNetwork.imageUrl +
                                              getUserData["photo3"]),
                            ]),
                      )
                    ])),
          ),
          const SizedBox(height: 50),
          const Divider(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Contact Info',
                  style: TextStyle(
                      color: appTheme.heading,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "CinzelDecorative"),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.phone_android),
                title: const Text('Phone Number'),
                subtitle: Text(
                    getUserData != null && getUserData["user"]["phone"] != null
                        ? "+91 - " + getUserData["user"]["phone"]
                        : "+91 - " + getUserProfileData["phone"]),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(getUserData != null
                    ? getUserData["user"]["emailAddress"]
                    : getUserProfileData["emailAddress"]),
              ),
              ListTile(
                leading: const Icon(Icons.map_rounded),
                title: const Text('Address'),
                subtitle: Text(getUserData != null
                    ? getUserData["user"]["address"]
                    : getUserProfileData["address"]),
              )
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Personal Information',
                    style: TextStyle(
                        color: appTheme.heading,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "CinzelDecorative"),
                  ),
                ),
                Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.face),
                      title: const Text('Name'),
                      subtitle: Text(getUserProfileData["firstName"] +
                              " " +
                              getUserProfileData["lastName"] ??
                          "No Name Found"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Nick Name'),
                      subtitle: Text(
                        getUserData == null
                            ? "No data found"
                            : getUserData["nickName"] == null
                                ? "No nickname found"
                                : getUserData["nickName"].toString(),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.date_range),
                      title: const Text('Date of birth'),
                      subtitle: Text(getUserData != null
                          ? _formatDateOfBirth(
                              getUserProfileData["dateOfBirth"])
                          : "No Data Found"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.height),
                      title: const Text('Height'),
                      subtitle: Text(getUserData != null
                          ? "${getUserData["height"]} ft"
                          : "No Data Found"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.line_weight),
                      title: const Text('Weight'),
                      subtitle: Text(getUserData != null
                          ? "${getUserData["weight"]} kg"
                          : "No Data Found"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.bloodtype),
                      title: const Text('Blood Group'),
                      subtitle: Text(
                        getUserData != null
                            ? getUserData["bloodGroup"].toString()
                            : "No Data Found",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.fit_screen),
                      title: const Text('Body Type'),
                      subtitle: Text(
                        getUserData != null
                            ? getUserData["bodyType"].toString().toCapitalized()
                            : "No Data Found",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.compare_outlined),
                      title: const Text('Complexion'),
                      subtitle: Text(
                        getUserData != null
                            ? getUserData["complexion"]
                                .toString()
                                .toCapitalized()
                            : "No Data Found",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.folder_special),
                      title: const Text('Special Cases'),
                      subtitle: Text(
                        getUserData != null
                            ? getUserData["specialCases"]
                                .toString()
                                .toCapitalized()
                            : "No Data Found",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Mother Tongue'),
                      subtitle: Text(
                        getUserData != null
                            ? getUserData["motherTongue"]
                                .toString()
                                .toCapitalized()
                            : "No Data Found",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.category),
                      title: const Text('Religion'),
                      subtitle: Text(
                        getUserData != null
                            ? getUserData["religion"].toString().toCapitalized()
                            : "No Data Found",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.cast_for_education),
                      title: const Text('Caste'),
                      subtitle: Text(
                        getUserData != null
                            ? getUserData["caste"].toString().toCapitalized()
                            : "No Data Found",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.subdirectory_arrow_left),
                      title: const Text('Sub Caste'),
                      subtitle: Text(
                        getUserData != null
                            ? getUserData["subCaste"].toString().toCapitalized()
                            : "No Data Found",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.place),
                      title: const Text('Place Of Birth'),
                      subtitle: Text(
                        getUserData != null
                            ? getUserData["placeOfBirth"]
                                .toString()
                                .toCapitalized()
                            : "No Data Found",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.punch_clock),
                      title: const Text('Time Of Birth'),
                      subtitle: Text(
                        getUserData == null
                            ? "Time not found"
                            : getUserData["timeOFBirth"].toString(),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.food_bank),
                      title: const Text('diet'),
                      subtitle: Text(
                        getUserData != null
                            ? getUserData["diet"].toString().toCapitalized()
                            : "No Data Found",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.unarchive),
                      title: const Text('Education'),
                      subtitle: Text(getUserData != null
                          ? getUserData["education"]
                          : "No Data Found"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.work),
                      title: const Text('Profession'),
                      subtitle: Text(getUserData != null
                          ? getUserData["profession"]
                          : "No Data Found"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.comment_outlined),
                      title: const Text('Company'),
                      subtitle: Text(
                        getUserData != null &&
                                getUserData["companyName"] != null
                            ? getUserData["companyName"]
                            : "No Company Found ",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.currency_rupee),
                      title: const Text('Annual Income'),
                      subtitle: Text(getUserData != null
                          ? "${getUserData["annualIncome"]} LPA"
                          : "No Income Found"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: <Widget>[
              Text(
                "Family Details",
                style: TextStyle(
                    color: appTheme.heading,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: "CinzelDecorative"),
              ),
              const SizedBox(height: 20),
              // buildInfoItem(
              //     'Family Name :',
              //     getUserData == null
              //         ? "No Data Found"
              //         : getUserData["familyName"].toString().toCapitalized()),
              ListTile(
                leading: const Icon(Icons.star_outline_sharp),
                title: const Text('Family Status'),
                subtitle: Text(
                  getUserData == null
                      ? "No Data Found"
                      : getUserData["familyValues"].toString().toCapitalized(),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person_2_rounded),
                title: const Text('Father\'s Name'),
                subtitle: Text(
                  getUserData == null
                      ? "No Data Found"
                      : getUserData["fatherName"].toString().capitalizeFirst!,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.face_2_rounded),
                title: const Text('Mother\'s Name'),
                subtitle: Text(
                  getUserData == null
                      ? "No Data Found"
                      : getUserData["motherName"].toString().capitalizeFirst!,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.numbers),
                title: const Text('No of Brothers'),
                subtitle: Text(
                  getUserData == null
                      ? "Data Not found"
                      : getUserData["numberOfBrother"].toString(),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.confirmation_number_sharp),
                title: const Text('No of Sisters'),
                subtitle: Text(
                  getUserData != null
                      ? getUserData["numberOfSister"].toString()
                      : "No Data Found",
                ),
              ),
              ListTile(
                leading: const Icon(Icons.contact_emergency),
                title: const Text('Contact Person Number'),
                subtitle: Text(
                  getUserData != null &&
                          getUserData["contactPersonPhoneNumber"] != null
                      ? getUserData["contactPersonPhoneNumber"].toString()
                      : "No number found",
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Contact Person Name'),
                subtitle: Text(
                  getUserData == null
                      ? "No Data "
                      : getUserData["contactPersonName"]
                          .toString()
                          .toCapitalized(),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.real_estate_agent),
                title: const Text('Contact Person RelationShip'),
                subtitle: Text(
                  getUserData == null
                      ? "No Data "
                      : getUserData["contactPersonRelationShip"]
                          .toString()
                          .toCapitalized(),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hobbies & Interests",
                    style: TextStyle(
                        color: appTheme.heading,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "CinzelDecorative"),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: appTheme.hobbies),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              getUserData != null
                                  ? getUserData["hobbies"]
                                  : "No Data Found",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: appTheme.black900),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: appTheme.hobbies),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              getUserData != null
                                  ? getUserData["interests"]
                                  : "No Data Found",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: appTheme.black900),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SOCIAL MEDIA",
                    style: TextStyle(
                        color: appTheme.heading,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "CinzelDecorative"),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: appTheme.hobbies,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // if (getUserData != null) {
                              //   String facebookUrl =
                              //       getUserData['facebookUrl'].toString() ??
                              //           "No Data Found";
                              //   if (facebookUrl.isNotEmpty) {
                              //     launchUrl(Uri.parse(facebookUrl));
                              //   } else {
                              //     print('facebook URL is empty.');
                              //   }
                              // } else {
                              //   print('getUserData is null.');
                              // }
                              launch("https://www.facebook.com/");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomIconButton(
                                child: SvgPicture.asset(
                                  ImageConstant.facebook,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: appTheme.hobbies,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // if (getUserData != null) {
                              //   String linkedInUrl =
                              //       getUserData['linkedinUrl'].toString() ??
                              //           "No Data Found";

                              //   if (linkedInUrl.isNotEmpty) {
                              //     launchUrl(Uri.parse(linkedInUrl));
                              //   } else {
                              //     print('LinkedIn URL is empty.');
                              //   }
                              // } else {
                              //   print('getUserData is null.');
                              // }
                              launch("https://www.linkedin.com/");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomIconButton(
                                child: SvgPicture.asset(
                                  ImageConstant.linkedin,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: appTheme.hobbies,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (getUserData != null) {
                                String whatsappUrl =
                                    getUserData['whatsappUrl'].toString() ??
                                        "No Data Found";

                                if (whatsappUrl.isNotEmpty) {
                                  launchUrl(Uri.parse(whatsappUrl));
                                } else {
                                  print('LinkedIn URL is empty.');
                                }
                              } else {
                                print('getUserData is null.');
                              }
                              launch("https://www.whatsapp.com/");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomIconButton(
                                child: SvgPicture.asset(
                                  ImageConstant.whatsapp,
                                ),
                              ),
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomElevatedButton(
              buttonStyle: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              text: "Logout",
              buttonTextStyle: CustomTextStyles.titleMediumBlackA700,
              onTap: () {
                showAlertDialog(
                  context,
                  () {
                    Get.back();
                  },
                  () {
                    SessionManager.removeToken();
                    Get.offAllNamed(AppRoutes.loginScreen);
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;
  const CustomCard({
    Key? key,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomImageView(
                imagePath: imageAsset,
                fit: BoxFit.cover,
              ),
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
    );
  }
}

// add personal details
// add personal details
Widget buildInfoItem(String title, String value) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: appTheme.heading),
        ),
        Text(value),
      ],
    ),
  );
}

// Function to format the date of birth
String _formatDateOfBirth(dynamic dateOfBirth) {
  try {
    if (dateOfBirth != null && dateOfBirth.toString().isNotEmpty) {
      DateTime? parsedDate = DateTime.tryParse(dateOfBirth.toString());
      if (parsedDate != null) {
        // Calculate age based on the parsed date of birth
        int age = DateTime.now().year - parsedDate.year;
        return '${DateFormat('dd/MMM/yyyy').format(parsedDate)} (Age: $age)';
      }
    }
  } catch (e) {
    print("Error formatting date of birth: $e");
  }
  return 'No Date Found';
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
                  width: double.infinity,
                  height: height,
                  fit: BoxFit.cover,
                  imagePath: ImageConstant.userProfile);
            },
          )
        : CustomImageView(
            width: double.infinity,
            fit: BoxFit.cover,
            imagePath: ImageConstant.logoImg,
          ); // Display a static image if imageUrl is null
  }
}
