import 'package:flutter_svg/svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/routes/app_routes.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';

class EmptyContainer extends StatelessWidget {
  void Function() onTap;
  String? msg;
  EmptyContainer({required this.onTap, this.msg, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageView(
              width: 100, height: 100, imagePath: ImageConstant.noData),
          const SizedBox(
            height: 20,
          ),
          Text(
            msg ?? "Something went wrong",
            style: CustomTextStyles.bodySmallMulishBlack900,
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                  color: appTheme.orange,
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Text(
                  "Go to Homepage",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyNoDataScreen extends StatelessWidget {
  MyNoDataScreen({super.key});

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
              backgroundColor:
                  Colors.red, // Use backgroundColor instead of primary
              foregroundColor: Colors.white,
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
