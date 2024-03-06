import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/data/apiClient/http_response.dart';
import 'package:matrimony_app/presentation/settings/controller/settings_controller.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_app_bar.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  var scaffoldKey = GlobalKey<ScaffoldState>();
  SettingsController settingsController = Get.put(SettingsController());

  @override
  void initState() {
    super.initState();
    settingsController.getFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAndToNamed(AppRoutes.homeScreen);
          },
          icon: Icon(
            Icons.arrow_back,
            color: appTheme.whiteA700,
          ),
        ),
        title: "Frequently Asked Questions",
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Obx(() {
            if (settingsController.rxRequestStatus.value == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (settingsController.rxRequestStatus.value ==
                Status.success) {
              return buildContent();
            } else if (settingsController.rxRequestStatus.value ==
                Status.error) {
              return const Center(child: Text("Something went wrong"));
            } else {
              return const Center(child: Text("No data found"));
            }
          }),
        ],
      ),
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: settingsController.allFaqs.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 10),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          settingsController.allFaqs[index]["question"] + "?",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          settingsController.allFaqs[index]["answer"],
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      fontFamily: 'CinzelDecorative',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: appTheme.heading,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomImageView(
                    imagePath: ImageConstant.logoImg,
                    width: 250,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Finding your life partner is a journey filled with excitement,"
                    "and we are here to make that journey smoother and more meaningful."
                    "Soulmate is a platform dedicated to helping individuals"
                    "discover their perfect match and embark on a lifelong journey of love"
                    "and companionship",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: appTheme.headerColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.allProfilesScreen);
                    },
                    child: const Text(
                      "Click here to start your matrimony service now.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
