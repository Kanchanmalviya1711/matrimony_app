import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/presentation/allProfiles/controller/allProfiles_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewAllProfiles extends StatefulWidget {
  const ViewAllProfiles({Key? key}) : super(key: key);
  @override
  State<ViewAllProfiles> createState() => _ViewAllProfilesState();
}

class _ViewAllProfilesState extends State<ViewAllProfiles> {
  AllProfilesListController allProfilesListController =
      Get.find<AllProfilesListController>();
  var data = Get.arguments;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    print("data ${data[0]}");

    var singleId = data.isNotEmpty ? data[0] : null;
    if (singleId != null) {
      singleProfiles = data[0]; // Update the UI after data retrieval
    }
  }

  var singleProfiles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.allProfilesScreen);
          },
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.whiteA700,
          ),
        ),
        title: "VIEW DETAILS",
      ),
      body: singleProfiles == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : singleProfiles.isEmpty
              ? const Center(
                  child: Text('No data available'),
                )
              : SingleChildScrollView(
                  child: Column(children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                MyImageWidget(
                                    height: mediaQueryData.size.height * 0.5,
                                    width: double.infinity,
                                    imageUrl: singleProfiles["user"] == null
                                        ? ImageConstant.couple1
                                        : ApiNetwork.imageUrl +
                                            singleProfiles["user"]
                                                ["imagePath"]),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 10,
                          child: Container(
                            color: appTheme.whiteA700,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    singleProfiles["user"] == null
                                        ? "No such name"
                                        : singleProfiles["user"]["fullName"]
                                            .toString()
                                            .capitalizeFirst!,
                                    style: TextStyle(
                                      color: appTheme.black900,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    singleProfiles["profession"] == null
                                        ? "No prof found"
                                        : singleProfiles["profession"]
                                            .toString()
                                            .capitalizeFirst!,
                                    style: TextStyle(
                                        color: appTheme.heading,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
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
                              singleProfiles == null ||
                                      singleProfiles.isEmpty ||
                                      singleProfiles["aboutYourself"] == null ||
                                      singleProfiles["aboutYourself"].isEmpty
                                  ? "About information not available"
                                  : singleProfiles["aboutYourself"].toString(),
                              style: TextStyle(
                                  color: appTheme.heading,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  height: 1.4),
                            ),
                          ),
                        ]),
                    const Divider(),
                    const SizedBox(height: 20),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MyImageWidget(
                                            height: mediaQueryData.size.height *
                                                0.3,
                                            width: 200,
                                            imageUrl: singleProfiles == null
                                                ? ImageConstant.couple1
                                                : singleProfiles["photo1"] ==
                                                        null
                                                    ? ImageConstant.couple1
                                                    : ApiNetwork.imageUrl +
                                                        singleProfiles[
                                                            "photo1"]),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        MyImageWidget(
                                            height: mediaQueryData.size.height *
                                                0.3,
                                            width: 200,
                                            imageUrl: singleProfiles == null
                                                ? ImageConstant.couple1
                                                : singleProfiles["photo2"] ==
                                                        null
                                                    ? ImageConstant.couple1
                                                    : ApiNetwork.imageUrl +
                                                        singleProfiles[
                                                            "photo2"]),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        MyImageWidget(
                                            height: mediaQueryData.size.height *
                                                0.3,
                                            width: 200,
                                            imageUrl: singleProfiles == null
                                                ? ImageConstant.couple1
                                                : singleProfiles["photo3"] ==
                                                        null
                                                    ? ImageConstant.couple1
                                                    : ApiNetwork.imageUrl +
                                                        singleProfiles[
                                                            "photo3"]),
                                      ]),
                                )
                              ])),
                    ),
                    const SizedBox(height: 40),
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
                          subtitle: Text(singleProfiles["user"] != null
                              ? singleProfiles["user"]["phone"].toString()
                              : "No phone number found"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text('Email'),
                          subtitle: Text(singleProfiles["user"] != null
                              ? singleProfiles["user"]["emailAddress"]
                                  .toString()
                              : "No email found"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.map_rounded),
                          title: const Text('Address'),
                          subtitle: Text(singleProfiles["user"] != null
                              ? singleProfiles["user"]["address"].toString()
                              : "no address found"),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Personal Information',
                            style: TextStyle(
                                color: appTheme.heading,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "CinzelDecorative"),
                          ),
                          const SizedBox(height: 15),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text('FullName'),
                            subtitle: Text(singleProfiles["user"] == null
                                ? "No such name"
                                : singleProfiles["user"]["fullName"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.date_range),
                            title: const Text('Date of birth'),
                            subtitle: Text(singleProfiles["user"] == null
                                ? "No date found"
                                : _formatDateOfBirth(
                                    singleProfiles["user"]["dateOfBirth"])),
                          ),
                          ListTile(
                            leading: const Icon(Icons.line_weight),
                            title: const Text('Weight'),
                            subtitle: Text(
                              '${singleProfiles["weight"].toString()} kg',
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.height),
                            title: const Text('Height'),
                            subtitle: Text(
                              '${singleProfiles["height"].toString()} ft',
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.bloodtype),
                            title: const Text('Blood Group'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["bloodGroup"] == null ||
                                    singleProfiles["bloodGroup"].isEmpty
                                ? "Bloodgroup not found"
                                : singleProfiles["bloodGroup"].toString()),
                          ),
                          ListTile(
                            leading: const Icon(Icons.fit_screen),
                            title: const Text('Body Type'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["bodyType"] == null ||
                                    singleProfiles["bodyType"].isEmpty
                                ? "Bodytype not found"
                                : singleProfiles["bodyType"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.compare_outlined),
                            title: const Text('Complexion'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["complexion"] == null ||
                                    singleProfiles["complexion"].isEmpty
                                ? "Complexion not found"
                                : singleProfiles["complexion"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.folder_special),
                            title: const Text('Special Cases'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["specialCases"] == null ||
                                    singleProfiles["specialCases"].isEmpty
                                ? "Specialcases not found"
                                : singleProfiles["specialCases"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.language),
                            title: const Text('Mother Tongue'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["motherTongue"] == null ||
                                    singleProfiles["motherTongue"].isEmpty
                                ? "Mothertougue not found"
                                : singleProfiles["motherTongue"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.category),
                            title: const Text('Religion'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["religion"] == null ||
                                    singleProfiles["religion"].isEmpty
                                ? "Religion not found"
                                : singleProfiles["religion"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.cast_for_education),
                            title: const Text('Caste'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["caste"] == null ||
                                    singleProfiles["caste"].isEmpty
                                ? "Caste not found"
                                : singleProfiles["caste"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.subdirectory_arrow_left),
                            title: const Text('Sub Caste'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["subCaste"] == null ||
                                    singleProfiles["subCaste"].isEmpty
                                ? "Subcaste  not found"
                                : singleProfiles["subCaste"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.place),
                            title: const Text('Place Of Birth'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["placeOfBirth"] == null ||
                                    singleProfiles["placeOfBirth"].isEmpty
                                ? "Place of birth not found"
                                : singleProfiles["placeOfBirth"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.punch_clock),
                            title: const Text('Time Of Birth'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["timeOFBirth"] == null ||
                                    singleProfiles["timeOFBirth"].isEmpty
                                ? "Time of birth not found"
                                : singleProfiles["timeOFBirth"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.food_bank),
                            title: const Text('diet'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["diet"] == null ||
                                    singleProfiles["diet"].isEmpty
                                ? "Diet not found"
                                : singleProfiles["diet"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.unarchive),
                            title: const Text('Education'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["education"] == null ||
                                    singleProfiles["education"].isEmpty
                                ? "Education not found"
                                : singleProfiles["education"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.work),
                            title: const Text('Profession'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["profession"] == null ||
                                    singleProfiles["profession"].isEmpty
                                ? "Profession not found"
                                : singleProfiles["profession"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Family Details",
                            style: TextStyle(
                                color: appTheme.heading,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "CinzelDecorative"),
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            leading: const Icon(Icons.star_outline_sharp),
                            title: const Text('Family Status'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["familyValues"] == null ||
                                    singleProfiles["familyValues"].isEmpty
                                ? "Familyvalues not found"
                                : singleProfiles["familyValues"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.person_2_rounded),
                            title: const Text('Father\'s Name'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["fatherName"] == null ||
                                    singleProfiles["fatherName"].isEmpty
                                ? "Father name not found"
                                : singleProfiles["fatherName"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.face_2_rounded),
                            title: const Text('Mother\'s Name'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["motherName"] == null ||
                                    singleProfiles["motherName"].isEmpty
                                ? "Mother name not found"
                                : singleProfiles["motherName"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.numbers),
                            title: const Text('No of Brothers '),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["numberOfBrother"] == null ||
                                    singleProfiles["numberOfBrother"].isEmpty
                                ? "Number of brother not found"
                                : singleProfiles["numberOfBrother"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.confirmation_number_sharp),
                            title: const Text('No of Sisters '),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["numberOfSister"] == null ||
                                    singleProfiles["numberOfSister"].isEmpty
                                ? "Number of sister not found"
                                : singleProfiles["numberOfSister"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.contact_emergency),
                            title: const Text('Contact Person Number'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles[
                                            "contactPersonPhoneNumber"] ==
                                        null ||
                                    singleProfiles["contactPersonPhoneNumber"]
                                        .isEmpty
                                ? "Contactperson number not found"
                                : singleProfiles["contactPersonPhoneNumber"]
                                    .toString()),
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text('Contact Person Name'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles["contactPersonName"] ==
                                        null ||
                                    singleProfiles["contactPersonName"].isEmpty
                                ? "Contactperson name not found"
                                : singleProfiles["contactPersonName"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.real_estate_agent),
                            title: const Text('Contact Person RelationShip'),
                            subtitle: Text(singleProfiles == null ||
                                    singleProfiles.isEmpty ||
                                    singleProfiles[
                                            "contactPersonRelationShip"] ==
                                        null ||
                                    singleProfiles["contactPersonRelationShip"]
                                        .isEmpty
                                ? "contactperson relationShip not found"
                                : singleProfiles["contactPersonRelationShip"]
                                    .toString()
                                    .capitalizeFirst!),
                          ),
                          ListTile(
                            leading: const Icon(Icons.language),
                            title: const Text('Language Known'),
                            subtitle: singleProfiles["languageSelectedList"] ==
                                        null ||
                                    singleProfiles["languageSelectedList"]
                                        .isEmpty
                                ? const Text("No language found")
                                : SingleChildScrollView(
                                    child: Text(
                                        singleProfiles["languageSelectedList"]
                                                [0]["language"]["name"]
                                            .toString()
                                            .capitalizeFirst!),
                                  ),
                          ),
                        ]),
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
                                        singleProfiles == null ||
                                                singleProfiles.isEmpty ||
                                                singleProfiles["hobbies"] ==
                                                    null ||
                                                singleProfiles["hobbies"]
                                                    .isEmpty
                                            ? "Hobbies not found"
                                            : singleProfiles["hobbies"]
                                                .toString()
                                                .capitalizeFirst!,
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
                                        singleProfiles == null ||
                                                singleProfiles.isEmpty ||
                                                singleProfiles["interests"] ==
                                                    null ||
                                                singleProfiles["interests"]
                                                    .isEmpty
                                            ? "Interests not found"
                                            : singleProfiles["interests"]
                                                .toString()
                                                .capitalizeFirst!,
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
                              "CONNECT WITH",
                              style: TextStyle(
                                  color: appTheme.heading,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "CinzelDecorative"),
                            ),
                            Text(
                              "SOCIAL MEDIA",
                              style: TextStyle(
                                  color: appTheme.heading,
                                  fontSize: 20,
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomIconButton(
                                        child: SvgPicture.asset(
                                          ImageConstant.linkedin,
                                        ),
                                        onTap: () {
                                          launch('https://linkedin.com');
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: appTheme.hobbies,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomIconButton(
                                        child: SvgPicture.asset(
                                          ImageConstant.facebook,
                                        ),
                                        onTap: () {
                                          launch('https://facebook.com');
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: appTheme.hobbies,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomIconButton(
                                        child: SvgPicture.asset(
                                          ImageConstant.whatsapp,
                                        ),
                                        onTap: () {
                                          launch('https://whatsapp.com');
                                        },
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
                    const SizedBox(height: 20),
                  ]),
                ),
    );
  }
}

// add personal details
Widget buildInfoItem(String title, String value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
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

class MyImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  MyImageWidget({required this.imageUrl, this.width, this.height});
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
                imagePath: ImageConstant.couple1,
              );
            },
          )
        : CustomImageView(
            width: 200,
            height: mediaQueryData.size.height * 0.3,
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
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
        return '${DateFormat('dd/MMM/yyyy').format(parsedDate)} (Age: $age)';
      }
    }
  } catch (e) {
    print("Error formatting date of birth: $e");
  }
  return 'No Date Found';
}
