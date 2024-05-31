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
  var profileData;

  getData() async {
    getUserData = json.decode(SessionManager.getUser().toString());
    //print("getregisterData ttttttttt ${getUserData}");
  }

  getProfileData() async {
    getUserProfileData =
        json.decode(SessionManager.getLoginUserProfileData().toString());
    print("getUserprofileData rrrrrrrrrrrrrr ${getUserProfileData}");
  }

  // setUserProfileData() async {
  //   profileData = json.decode(SessionManager.getUserProfileData().toString());
  //   print("getUserprofileData fghgjkkkkkkkkkkkkkkk ${profileData}");
  // }

  @override
  void initState() {
    getData();
    getProfileData();
    //setUserProfileData();
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
                      arguments: [getUserData]);
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
                      getUserProfileData == null
                          ? "Complete Profile"
                          : "Edit Profile",
                      style: CustomTextStyles.titleSmall_1,
                    ),
                  ],
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.createProfileScreen,
                      arguments: [getUserProfileData]);
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
                //  setUserProfileData();
              });
            },
            child: Stack(
              children: [
                MyImageWidget(
                  height: 400,
                  imageUrl: getUserData == null
                      ? "No Image found"
                      : ApiNetwork.imageUrl +
                          getUserData["imagePath"].toString(),
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
                                getUserData["fullName"].toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                getUserProfileData == null ||
                                        getUserProfileData.isEmpty ||
                                        getUserProfileData["nickName"] ==
                                            null ||
                                        getUserProfileData["nickName"].isEmpty
                                    ? "No Nickname"
                                    : "(${getUserProfileData["nickName"].toString()})",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "By Profession ${getUserProfileData == null ? "Prof not found" : getUserProfileData["profession"]} ",
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
                    getUserProfileData == null ||
                            getUserProfileData.isEmpty ||
                            getUserProfileData["aboutYourself"] == null ||
                            getUserProfileData["aboutYourself"].isEmpty
                        ? "About information not available"
                        : getUserProfileData["aboutYourself"].toString(),
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
                                  imageUrl: getUserProfileData == null
                                      ? ImageConstant.couple1
                                      : getUserProfileData["photo1"] == null
                                          ? ImageConstant.couple1
                                          : ApiNetwork.imageUrl +
                                              getUserProfileData["photo1"]),
                              const SizedBox(
                                width: 10,
                              ),
                              MyImageWidget(
                                  width: 200,
                                  height: mediaQueryData.size.height * 0.3,
                                  imageUrl: getUserProfileData == null
                                      ? ImageConstant.couple1
                                      : getUserProfileData["photo2"] == null
                                          ? ImageConstant.couple1
                                          : ApiNetwork.imageUrl +
                                              getUserProfileData["photo2"]),
                              const SizedBox(
                                width: 10,
                              ),
                              MyImageWidget(
                                  width: 200,
                                  height: mediaQueryData.size.height * 0.3,
                                  imageUrl: getUserProfileData == null
                                      ? ImageConstant.couple1
                                      : getUserProfileData["photo3"] == null
                                          ? ImageConstant.couple1
                                          : ApiNetwork.imageUrl +
                                              getUserProfileData["photo3"]),
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
                subtitle: Text(getUserData["phone"] != null
                    ? "+91 - ${getUserData["phone"]}"
                    : "+91 - ${getUserProfileData["phone"]}"),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(getUserData != null
                    ? getUserData["emailAddress"].toString()
                    : getUserProfileData["emailAddress"].toString()),
              ),
              ListTile(
                leading: const Icon(Icons.map_rounded),
                title: const Text('Address'),
                subtitle: Text(getUserData != null
                    ? getUserData["address"].toString()
                    : getUserProfileData["address"].toString()),
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
                      subtitle: Text(
                        getUserData["fullName"].toString(),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Nick Name'),
                      subtitle: Text(
                        getUserProfileData == null ||
                                getUserProfileData.isEmpty ||
                                getUserProfileData["nickName"] == null ||
                                getUserProfileData["nickName"].isEmpty
                            ? "No Nickname"
                            : getUserProfileData["nickName"].toString(),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.date_range),
                      title: const Text('Date of birth'),
                      subtitle: Text(getUserData != null
                          ? _formatDateOfBirth(getUserData["dateOfBirth"])
                          : "DOB not found"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.height),
                      title: const Text('Height'),
                      subtitle: Text(getUserProfileData != null
                          ? "${getUserProfileData["height"]} ft"
                          : "Height not found"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.line_weight),
                      title: const Text('Weight'),
                      subtitle: Text(getUserProfileData != null
                          ? "${getUserProfileData["weight"]} kg"
                          : "Weight not found"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.bloodtype),
                      title: const Text('Blood Group'),
                      subtitle: Text(
                        getUserProfileData == null ||
                                getUserProfileData.isEmpty ||
                                getUserProfileData["bloodGroup"] == null ||
                                getUserProfileData["bloodGroup"].isEmpty
                            ? "Bloodgroup not found"
                            : "(${getUserProfileData["bloodGroup"].toString()})",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.fit_screen),
                      title: const Text('Body Type'),
                      subtitle: Text(
                        getUserProfileData == null ||
                                getUserProfileData.isEmpty ||
                                getUserProfileData["bloodType"] == null ||
                                getUserProfileData["bloodType"].isEmpty
                            ? "Bloodgroup not found"
                            : "(${getUserProfileData["bloodType"].toString()})",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.compare_outlined),
                      title: const Text('Complexion'),
                      subtitle: Text(
                        getUserProfileData == null ||
                                getUserProfileData.isEmpty ||
                                getUserProfileData["complexion"] == null ||
                                getUserProfileData["complexion"].isEmpty
                            ? "Complexion not found"
                            : getUserProfileData["complexion"].toString(),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.folder_special),
                      title: const Text('Special Cases'),
                      subtitle: Text(
                        getUserProfileData == null ||
                                getUserProfileData.isEmpty ||
                                getUserProfileData["specialCases"] == null ||
                                getUserProfileData["specialCases"].isEmpty
                            ? "Special cases not found"
                            : getUserProfileData["specialCases"].toString(),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Mother Tongue'),
                      subtitle: Text(
                        getUserProfileData == null ||
                                getUserProfileData.isEmpty ||
                                getUserProfileData["motherTongue"] == null ||
                                getUserProfileData["motherTongue"].isEmpty
                            ? "Mothertongue not found"
                            : getUserProfileData["motherTongue"].toString(),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.category),
                      title: const Text('Religion'),
                      subtitle: Text(
                        getUserProfileData == null ||
                                getUserProfileData.isEmpty ||
                                getUserProfileData["religion"] == null ||
                                getUserProfileData["religion"].isEmpty
                            ? "Religion not found"
                            : getUserProfileData["religion"].toString(),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.cast_for_education),
                      title: const Text('Caste'),
                      subtitle: Text(getUserProfileData == null ||
                              getUserProfileData.isEmpty ||
                              getUserProfileData["caste"] == null ||
                              getUserProfileData["caste"].isEmpty
                          ? "Caste not found"
                          : getUserProfileData["caste"].toString()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.subdirectory_arrow_left),
                      title: const Text('Sub Caste'),
                      subtitle: Text(getUserProfileData == null ||
                              getUserProfileData.isEmpty ||
                              getUserProfileData["subCaste"] == null ||
                              getUserProfileData["subCaste"].isEmpty
                          ? "Subcaste not found"
                          : getUserProfileData["subCaste"].toString()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.place),
                      title: const Text('Place Of Birth'),
                      subtitle: Text(getUserProfileData == null ||
                              getUserProfileData.isEmpty ||
                              getUserProfileData["placeOfBirth"] == null ||
                              getUserProfileData["placeOfBirth"].isEmpty
                          ? "Placeofbirth not found"
                          : getUserProfileData["placeOfBirth"].toString()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.punch_clock),
                      title: const Text('Time Of Birth'),
                      subtitle: Text(getUserProfileData == null ||
                              getUserProfileData.isEmpty ||
                              getUserProfileData["timeOFBirth"] == null ||
                              getUserProfileData["timeOFBirth"].isEmpty
                          ? "Timeofbirth not found"
                          : getUserProfileData["timeOFBirth"].toString()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.food_bank),
                      title: const Text('diet'),
                      subtitle: Text(getUserProfileData == null ||
                              getUserProfileData.isEmpty ||
                              getUserProfileData["diet"] == null ||
                              getUserProfileData["diet"].isEmpty
                          ? "Diet not found"
                          : getUserProfileData["diet"].toString()),
                    ),
                    ListTile(
                        leading: const Icon(Icons.unarchive),
                        title: const Text('Education'),
                        subtitle: Text(getUserProfileData == null ||
                                getUserProfileData.isEmpty ||
                                getUserProfileData["education"] == null ||
                                getUserProfileData["education"].isEmpty
                            ? "Education not found"
                            : getUserProfileData["education"].toString())),
                    ListTile(
                        leading: const Icon(Icons.work),
                        title: const Text('Profession'),
                        subtitle: Text(getUserProfileData == null ||
                                getUserProfileData.isEmpty ||
                                getUserProfileData["profession"] == null ||
                                getUserProfileData["profession"].isEmpty
                            ? "Profession not found"
                            : getUserProfileData["profession"].toString())),
                    ListTile(
                      leading: const Icon(Icons.comment_outlined),
                      title: const Text('Company'),
                      subtitle: Text(getUserProfileData == null ||
                              getUserProfileData.isEmpty ||
                              getUserProfileData["companyName"] == null ||
                              getUserProfileData["companyName"].isEmpty
                          ? "Company name not found"
                          : getUserProfileData["companyName"].toString()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.currency_rupee),
                      title: const Text('Annual Income'),
                      subtitle: Text(getUserProfileData == null ||
                              getUserProfileData.isEmpty ||
                              getUserProfileData["annualIncome"] == null ||
                              getUserProfileData["annualIncome"].isEmpty
                          ? "Annual Income  not found"
                          : getUserProfileData["annualIncome"].toString()),
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
              buildInfoItem(
                  'Family Name :',
                  getUserData == null
                      ? "No Data found"
                      : getUserData["fullName"].toString()),
              ListTile(
                leading: const Icon(Icons.star_outline_sharp),
                title: const Text('Family Status'),
                subtitle: Text(getUserProfileData == null ||
                        getUserProfileData.isEmpty ||
                        getUserProfileData["familyValues"] == null ||
                        getUserProfileData["familyValues"].isEmpty
                    ? "Family status not found"
                    : getUserProfileData["familyValues"].toString()),
              ),
              ListTile(
                leading: const Icon(Icons.person_2_rounded),
                title: const Text('Father\'s Name'),
                subtitle: Text(getUserProfileData == null ||
                        getUserProfileData.isEmpty ||
                        getUserProfileData["fatherName"] == null ||
                        getUserProfileData["fatherName"].isEmpty
                    ? "Father's name not found"
                    : getUserProfileData["fatherName"]
                        .toString()
                        .capitalizeFirst!),
              ),
              ListTile(
                leading: const Icon(Icons.face_2_rounded),
                title: const Text('Mother\'s Name'),
                subtitle: Text(getUserProfileData == null ||
                        getUserProfileData.isEmpty ||
                        getUserProfileData["motherName"] == null ||
                        getUserProfileData["motherName"].isEmpty
                    ? "Mother's name not found"
                    : getUserProfileData["motherName"]
                        .toString()
                        .capitalizeFirst!),
              ),
              ListTile(
                leading: const Icon(Icons.numbers),
                title: const Text('No of Brothers'),
                subtitle: Text(getUserProfileData == null ||
                        getUserProfileData.isEmpty ||
                        getUserProfileData["numberOfBrother"] == null ||
                        getUserProfileData["numberOfBrother"].isEmpty
                    ? "Data Not found"
                    : getUserProfileData["numberOfBrother"].toString()),
              ),
              ListTile(
                leading: const Icon(Icons.confirmation_number_sharp),
                title: const Text('No of Sisters'),
                subtitle: Text(getUserProfileData == null ||
                        getUserProfileData.isEmpty ||
                        getUserProfileData["numberOfSister"] == null ||
                        getUserProfileData["numberOfSister"].isEmpty
                    ? "Number of sister not found"
                    : getUserProfileData["numberOfSister"].toString()),
              ),
              ListTile(
                leading: const Icon(Icons.contact_emergency),
                title: const Text('Contact Person Number'),
                subtitle: Text(getUserProfileData == null ||
                        getUserProfileData.isEmpty ||
                        getUserProfileData["contactPersonPhoneNumber"] ==
                            null ||
                        getUserProfileData["contactPersonPhoneNumber"].isEmpty
                    ? "Contact Person PhoneNumber not found"
                    : getUserProfileData["contactPersonPhoneNumber"]
                        .toString()),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Contact Person Name'),
                subtitle: Text(getUserProfileData == null ||
                        getUserProfileData.isEmpty ||
                        getUserProfileData["contactPersonName"] == null ||
                        getUserProfileData["contactPersonName"].isEmpty
                    ? "Person name not found "
                    : getUserProfileData["contactPersonName"].toString()),
              ),
              ListTile(
                leading: const Icon(Icons.real_estate_agent),
                title: const Text('Contact Person RelationShip'),
                subtitle: Text(getUserProfileData == null ||
                        getUserProfileData.isEmpty ||
                        getUserProfileData["contactPersonRelationShip"] ==
                            null ||
                        getUserProfileData["contactPersonRelationShip"].isEmpty
                    ? "RelationShip not found"
                    : getUserProfileData["contactPersonRelationShip"]
                        .toString()),
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
                              getUserProfileData == null ||
                                      getUserProfileData.isEmpty ||
                                      getUserProfileData["hobbies"] == null ||
                                      getUserProfileData["hobbies"].isEmpty
                                  ? "Hobbies not found"
                                  : getUserProfileData["hobbies"].toString(),
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
                              getUserProfileData == null ||
                                      getUserProfileData.isEmpty ||
                                      getUserProfileData["interests"] == null ||
                                      getUserProfileData["interests"].isEmpty
                                  ? "Interests not found"
                                  : getUserProfileData["interests"].toString(),
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
                              if (getUserProfileData != null) {
                                String facebookUrl =
                                    getUserProfileData['facebookUrl']
                                            .toString() ??
                                        "No Data found";
                                if (facebookUrl.isNotEmpty) {
                                  launchUrl(Uri.parse(facebookUrl));
                                } else {
                                  print('facebook URL is empty.');
                                }
                              } else {
                                print('getUserData is null.');
                              }
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
                              if (getUserProfileData != null) {
                                String linkedInUrl =
                                    getUserProfileData['linkedinUrl']
                                            .toString() ??
                                        "No Data found";

                                if (linkedInUrl.isNotEmpty) {
                                  launchUrl(Uri.parse(linkedInUrl));
                                } else {
                                  print('LinkedIn URL is empty.');
                                }
                              } else {
                                print('getUserData is null.');
                              }
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
  return 'No Date found';
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
                  width: 200,
                  height: mediaQueryData.size.height * 0.3,
                  fit: BoxFit.cover,
                  imagePath: ImageConstant.couple1);
            },
          )
        : CustomImageView(
            width: 200,
            height: mediaQueryData.size.height * 0.3,
            fit: BoxFit.cover,
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}
