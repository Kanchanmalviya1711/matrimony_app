import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/core/constants/api_network.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class OurServicesDetailsScreen extends StatefulWidget {
  const OurServicesDetailsScreen({super.key});

  @override
  State<OurServicesDetailsScreen> createState() =>
      _OurServicesDetailsScreenState();
}

class _OurServicesDetailsScreenState extends State<OurServicesDetailsScreen> {
  var data = Get.arguments;
  @override
  void initState() {
    print("OurServicesDetailsScreen test, $data");
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: "Our Services Details",
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.ourServiceScreen);
          },
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.whiteA700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  MyImageWidget(
                    width: double.infinity,
                    height: mediaQueryData.size.height * 0.4,
                    imageUrl: ApiNetwork.imageUrl + data[0]["image"],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: appTheme.black900.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(data[0]['title'.toString()],
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(data[0]['sub_title'.toString()],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      data[0]['description'].toString().capitalizeFirst!,
                      style: TextStyle(
                        fontSize: 16,
                        color: appTheme.heading,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          "Order Number: ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: appTheme.black900,
                          ),
                        ),
                        Card(
                          elevation: 5,
                          color: appTheme.orange,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              data[0]['order_number']
                                  .toString()
                                  .capitalizeFirst!,
                              style: TextStyle(
                                fontSize: 18,
                                color: appTheme.whiteA700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomImageView(
                    imagePath: ImageConstant.logoImg,
                    width: 300,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
                height: height,
                fit: BoxFit.cover,
                imagePath: ImageConstant.couple1,
              );
            },
          )
        : CustomImageView(
            width: 200,
            imagePath: ImageConstant.couple1,
          ); // Display a static image if imageUrl is null
  }
}
