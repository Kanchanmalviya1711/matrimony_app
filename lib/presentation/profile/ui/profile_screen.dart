import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/session_manager.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_elevated_button.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
        title: "My Profile ",
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              CustomImageView(
                imagePath: ImageConstant.myProfile,
                height: 430,
                width: double.infinity,
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Mansi Jain',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Sr. Software Engineer",
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
          const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomCard(
                    imageAsset: 'assets/images/painting.png',
                    title: 'Painting',
                    subtitle: 'Beautiful Artwork',
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: CustomCard(
                    imageAsset: 'assets/images/couple.jpg',
                    title: 'Photo',
                    subtitle: 'Memorable Moments',
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: CustomCard(
                    imageAsset: 'assets/images/peoples.png',
                    title: 'Another Painting',
                    subtitle: 'More Art to Explore',
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
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
                    "It is a long established fact that a reader will be distracted by the readable "
                    "content of a page when looking at its layout. The point of using Lorem Ipsum is that,"
                    "it has a more-or-less normal distribution of letters, as opposed to using 'Content here, "
                    "content here', making it look like readable English.",
                    style: TextStyle(
                        color: appTheme.heading,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Many desktop publishing packages and web page editors"
                    "now use Lorem Ipsum as their default model text.",
                    style: TextStyle(
                        color: appTheme.heading,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.4),
                  ),
                )
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
                              CustomImageView(
                                imagePath: ImageConstant.aboutPicture,
                                width: 200,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.aboutPicture,
                                width: 200,
                              ),
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
              const ListTile(
                leading: Icon(Icons.phone_android),
                title: Text('Phone Number'),
                subtitle: Text('+977-984XXXXXX'),
              ),
              const ListTile(
                leading: Icon(Icons.email),
                title: Text('Email'),
                subtitle: Text('mansi@gmail.com'),
              ),
              const ListTile(
                leading: Icon(Icons.map_rounded),
                title: Text('Address'),
                subtitle: Text(
                    '28800 Orchard Lake Road, Suite 180 Farmington Hills, U.S.A.'),
              )
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
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
                  buildInfoItem('Name :', 'Angelina Jolie'),
                  buildInfoItem('Father\'s name :', 'John Smith'),
                  buildInfoItem('Family name :', 'Joney Family'),
                  buildInfoItem('Age :', '24'),
                  buildInfoItem('Date of birth :', '03 Jan 1998'),
                  buildInfoItem('Height :', '167cm'),
                  buildInfoItem('Weight :', '65kg'),
                  buildInfoItem('Degree :', 'MSC Computer Science'),
                  buildInfoItem('Religion :', 'Any'),
                  buildInfoItem('Profession :', 'Working'),
                  buildInfoItem('Company :', 'Google'),
                  buildInfoItem('Position :', 'Web Developer'),
                  buildInfoItem('Salary :', '\$1000 p/m'),
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
                              "Reading",
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
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: appTheme.hobbies),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Watching Movies",
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
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: appTheme.hobbies),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Writing",
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
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: appTheme.hobbies),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Travelling",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: appTheme.black900),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
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
                                ImageConstant.google,
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
                                ImageConstant.twitter,
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomElevatedButton(
              buttonStyle: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              text: "Logout",
              buttonTextStyle: CustomTextStyles.titleMediumBlackA700,
              onTap: () {
                SessionManager.removeToken();
                Get.offAllNamed(AppRoutes.loginScreen);
              },
            ),
          ),
        ]),
      ),

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
