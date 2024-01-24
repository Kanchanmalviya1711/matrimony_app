import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class MyNoDataScreen extends StatelessWidget {
  const MyNoDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.noData,
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 20),
          const Text(
            'No Requests Found',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              Get.offNamed(
                AppRoutes.homeScreen,
              );
            },
            child: const Text('Go to Homepage'),
          ),
        ],
      ),
    );
  }
}
