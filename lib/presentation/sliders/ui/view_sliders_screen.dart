import 'package:intl/intl.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class ViewSliderScreen extends StatefulWidget {
  const ViewSliderScreen({Key? key}) : super(key: key);
  @override
  _ViewSliderScreenState createState() => _ViewSliderScreenState();
}

class _ViewSliderScreenState extends State<ViewSliderScreen> {
  bool isExpanded = false;
  late var data;

  @override
  void initState() {
    super.initState();
    data = Get.arguments;
    print("data is object $data");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed(AppRoutes.homeScreen);
          },
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.whiteA700,
          ),
        ),
        title: "VIEW COUPLES GOAL",
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFfdfcfb), Color(0xFFFFFBEE)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyImageWidget(
                imageUrl: ApiNetwork.imageUrl + data['image'],
                width: double.infinity,
                height: size.height * 0.5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: appTheme.headerColor,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            data['title'],
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          data["status"] == 0 ? "Active" : "Inactive",
                          style: TextStyle(
                            color:
                                data["status"] == 0 ? Colors.green : Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data['description'] + ".",
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date Of Post :",
                          style: TextStyle(
                            color: appTheme.black900,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Divider(
                          color: appTheme.heading,
                        ),
                        Text(
                          DateFormat('dd-MMM yyyy').format(
                            DateTime.parse(data["createdAt"].toString()),
                          ),
                          style: TextStyle(
                              color: appTheme.black900,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
    Size size = MediaQuery.of(context).size;
    return imageUrl != null
        ? Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            width: width,
            height: height,
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
                width: double.infinity,
                height: size.height * 0.4,
                fit: BoxFit.cover,
                imagePath: ImageConstant.couple1,
              ); // Display an error icon if the image fails to load
            },
          )
        : CustomImageView(
            width: double.infinity,
            height: size.height * 0.4,
            fit: BoxFit.cover,
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}
