import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class ViewAllProfiles extends StatefulWidget {
  const ViewAllProfiles({Key? key}) : super(key: key);

  @override
  State<ViewAllProfiles> createState() => _ViewAllProfilesState();
}

class _ViewAllProfilesState extends State<ViewAllProfiles>
    with SingleTickerProviderStateMixin {
  late var data;

  @override
  void initState() {
    super.initState();
    data = Get.arguments;
  }

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
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      MyImageWidget(
                          width: double.infinity,
                          imageUrl: ApiNetwork.imageUrl +
                                  data[0]["user"]["imagePath"] ??
                              "No such image"),
                    ],
                  ),
                ],
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
                          "${data[0]["user"]["firstName"].toString()} ${data[0]["user"]["lastName"].toString()}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data[0]["profession"] == null
                              ? "No prof found"
                              : data[0]["profession"]
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
                    data[0]["aboutYourself"].toString().capitalizeFirst!,
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
                                  imageUrl:
                                      ApiNetwork.imageUrl + data[0]["photo1"]),
                              const SizedBox(
                                width: 10,
                              ),
                              MyImageWidget(
                                  width: 200,
                                  imageUrl:
                                      ApiNetwork.imageUrl + data[0]["photo2"]),
                              const SizedBox(
                                width: 10,
                              ),
                              MyImageWidget(
                                  width: 200,
                                  imageUrl:
                                      ApiNetwork.imageUrl + data[0]["photo3"]),
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
                subtitle: Text(data[0]["user"]["phone"].toString()),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(data[0]["user"]["emailAddress"].toString()),
              ),
              ListTile(
                leading: const Icon(Icons.map_rounded),
                title: const Text('Address'),
                subtitle: Text(data[0]["user"]["address"].toString()),
              )
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Personal Information',
                      style: TextStyle(
                          color: appTheme.heading,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "CinzelDecorative"),
                    ),
                  ),
                  buildInfoItem('Name :',
                      "${data[0]["user"]["firstName"].toString()} ${data[0]["user"]["lastName"].toString()}"),
                  buildInfoItem(
                    'Father\'s Name :',
                    data[0]["fatherName"].toString(),
                  ),
                  buildInfoItem(
                    'Mother\'s Name :',
                    data[0]["motherName"].toString(),
                  ),
                  buildInfoItem('Family Name :', 'Joney Family'),
                  buildInfoItem('Date of birth :',
                      _formatDateOfBirth(data[0]["user"]["dateOfBirth"])),
                  buildInfoItem(
                    'Weight :',
                    '${data[0]["weight"].toString()}kg',
                  ),
                  buildInfoItem(
                    'Height :',
                    '${data[0]["height"].toString()}Cm',
                  ),
                  buildInfoItem('Degree :', data[0]["education"].toString()),
                  buildInfoItem('Religion :', data[0]["religion"].toString()),
                  buildInfoItem(
                      'Profession :',
                      data[0]["profession"] == null
                          ? "No prof found"
                          : data[0]["profession"].toString().capitalizeFirst!),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hobbies",
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
                              data[0]["interests"].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: appTheme.black900),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          Container(
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomIconButton(
                              child: SvgPicture.asset(
                                ImageConstant.linkedin,
                              ),
                              onTap: () {},
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
                              onTap: () {},
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
                              onTap: () {},
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
        ]),
      ),
    );
  }
}

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

class MyImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double width;
  // Make sure imageUrl is nullable

  MyImageWidget({required this.imageUrl, required this.width});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(
            imageUrl!,
            width: width,
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

// Function to format the date of birth
String _formatDateOfBirth(dynamic dateOfBirth) {
  try {
    if (dateOfBirth != null && dateOfBirth.toString().isNotEmpty) {
      DateTime? parsedDate = DateTime.tryParse(dateOfBirth.toString());
      if (parsedDate != null) {
        // Calculate age based on the parsed date of birth
        int age = DateTime.now().year - parsedDate.year;
        return '${DateFormat('dd,MMM-yyyy').format(parsedDate)} (Age: $age)';
      }
    }
  } catch (e) {
    print("Error formatting date of birth: $e");
  }
  return 'No Date Found';
}
