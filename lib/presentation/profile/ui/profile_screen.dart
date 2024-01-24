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
    print("getUserData ${getUserData}");
  }

  getProfileData() async {
    getUserProfileData =
        json.decode(SessionManager.getUserProfileData().toString());
    print("getUserprofile ${getUserProfileData}");
    // print("getUserprofileData ${getUserProfileData["imagePath"]}");
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
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              MyImageWidget(
                height: 400,
                imageUrl: ApiNetwork.imageUrl + getUserProfileData["imagePath"],
                width: double.infinity,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.createProfileScreen,
                        arguments: [getUserData]);
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          getUserProfileData["firstName"] +
                                  " " +
                                  getUserProfileData["lastName"] ??
                              "No Name Found",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          getUserData == null
                              ? "No Profession Found"
                              : getUserData["profession"],
                          style: TextStyle(
                            color: appTheme.heading,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
                        : getUserData["aboutYourself"],
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
                              height: mediaQueryData.size.height * 0.3,
                              imageUrl: getUserData?["photo1"] == null
                                  ? ImageConstant.fakeProfile
                                  : ApiNetwork.imageUrl + getUserData["photo1"],
                              width: 200,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            MyImageWidget(
                              height: mediaQueryData.size.height * 0.3,
                              imageUrl: getUserData?["photo2"] == null
                                  ? ImageConstant.fakeProfile
                                  : ApiNetwork.imageUrl + getUserData["photo2"],
                              width: 200,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            MyImageWidget(
                              height: mediaQueryData.size.height * 0.3,
                              imageUrl: getUserData?["photo3"] == null
                                  ? ImageConstant.fakeProfile
                                  : ApiNetwork.imageUrl + getUserData["photo3"],
                              width: 200,
                            ),
                          ],
                        ),
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
                subtitle: Text(getUserData != null
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
                buildInfoItem(
                    'Name :',
                    getUserProfileData["firstName"] +
                            getUserProfileData["lastName"] ??
                        "No Name Found"),
                buildInfoItem('Family name :', getUserProfileData["userType"]),
                buildInfoItem(
                    'Date of birth :',
                    getUserData != null
                        ? _formatDateOfBirth(getUserProfileData["dateOfBirth"])
                        : "No Data Found"),
                buildInfoItem(
                    'Height :',
                    getUserData != null
                        ? "${getUserData["height"]} ft"
                        : "No Data Found"),
                buildInfoItem(
                    'Weight :',
                    getUserData != null
                        ? "${getUserData["weight"]} kg"
                        : "No Data Found"),
                buildInfoItem(
                  'Blood Group :',
                  getUserData != null
                      ? getUserData["bloodGroup"].toString()
                      : "No Data Found",
                ),
                buildInfoItem(
                  'Body Type :',
                  getUserData != null
                      ? getUserData["bodyType"].toString().toCapitalized()
                      : "No Data Found",
                ),
                buildInfoItem(
                  'Complexion :',
                  getUserData != null
                      ? getUserData["complexion"].toString().toCapitalized()
                      : "No Data Found",
                ),
                buildInfoItem(
                  'Special Cases :',
                  getUserData != null
                      ? getUserData["specialCases"].toString().toCapitalized()
                      : "No Data Found",
                ),
                buildInfoItem(
                  'Mother Tongue :',
                  getUserData != null
                      ? getUserData["motherTongue"].toString().toCapitalized()
                      : "No Data Found",
                ),
                buildInfoItem(
                  'Religion :',
                  getUserData != null
                      ? getUserData["religion"].toString().toCapitalized()
                      : "No Data Found",
                ),
                buildInfoItem(
                  'Caste :',
                  getUserData != null
                      ? getUserData["caste"].toString().toCapitalized()
                      : "No Data Found",
                ),
                buildInfoItem(
                  'Sub Caste :',
                  getUserData != null
                      ? getUserData["subCaste"].toString().toCapitalized()
                      : "No Data Found",
                ),
                buildInfoItem(
                  'Place Of Birth :',
                  getUserData != null
                      ? getUserData["placeOfBirth"].toString().toCapitalized()
                      : "No Data Found",
                ),
                buildInfoItem(
                  'Time Of Birth :',
                  getUserData == null
                      ? "Time not found"
                      : getUserData["timrOfBirth"].toString(),
                ),
                buildInfoItem(
                  'diet :',
                  getUserData != null
                      ? getUserData["diet"].toString().toCapitalized()
                      : "No Data Found",
                ),
                buildInfoItem(
                    'Education :',
                    getUserData != null
                        ? getUserData["education"]
                        : "No Data Found"),
                buildInfoItem(
                    'Profession :',
                    getUserData != null
                        ? getUserData["profession"]
                        : "No Data Found"),
                buildInfoItem(
                  'Company :',
                  getUserData != null && getUserData["companyName"] != null
                      ? getUserData["companyName"]
                      : "No Company Found ",
                ),
                buildInfoItem(
                    'Annual Income :',
                    getUserData != null
                        ? "${getUserData["annualIncome"]} LPA"
                        : "No Income Found"),
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
                      ? "No Data Found"
                      : getUserData["familyName"].toString().toCapitalized()),
              buildInfoItem(
                'Family Status :',
                getUserData == null
                    ? "No Data Found"
                    : getUserData["familyValues"].toString().toCapitalized(),
              ),
              buildInfoItem(
                'Father\'s Name :',
                getUserData == null
                    ? "No Data Found"
                    : getUserData["fatherName"].toString().capitalizeFirst!,
              ),
              buildInfoItem(
                'Mother\'s Name :',
                getUserData == null
                    ? "Data Not Found"
                    : getUserData["motherName"].toString().capitalizeFirst!,
              ),
              buildInfoItem(
                'No of Brothers :',
                getUserData == null
                    ? "Data Not found"
                    : getUserData["numberOfBrother"].toString(),
              ),
              buildInfoItem(
                'No of Sisters :',
                getUserData != null
                    ? getUserData["numberOfSister"].toString()
                    : "No Data Found",
              ),
              buildInfoItem(
                'contact Person Name :',
                getUserData == null
                    ? "No Data "
                    : getUserData["contactPersonName"]
                        .toString()
                        .toCapitalized(),
              ),
              buildInfoItem(
                'Contact Person RelationShip :',
                getUserData == null
                    ? "No Data "
                    : getUserData["contactPersonRelationShip"]
                        .toString()
                        .toCapitalized(),
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
                              if (getUserData != null) {
                                String facebookUrl =
                                    getUserData['facebookUrl'].toString() ??
                                        "No Data Found";
                                if (facebookUrl.isNotEmpty) {
                                  launchUrl(Uri.parse(facebookUrl));
                                } else {
                                  print('facebook URL is empty.');
                                }
                              } else {
                                print('getUserData is null.');
                              }
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
                              if (getUserData != null) {
                                String linkedInUrl =
                                    getUserData['linkedinUrl'].toString() ??
                                        "No Data Found";

                                if (linkedInUrl.isNotEmpty) {
                                  launchUrl(Uri.parse(linkedInUrl));
                                } else {
                                  print('LinkedIn URL is empty.');
                                }
                              } else {
                                print('getUserData is null.');
                              }
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
                width: 200,
                imagePath: ImageConstant.couple1,
              ); // Display an error icon if the image fails to load
            },
          )
        : CustomImageView(
            width: 200,
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}
