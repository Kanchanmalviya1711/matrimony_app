import 'package:matrimony_app/presentation/splash/controller/splash_controller.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/utils/image_constant.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_image_view.dart';
import '../../../core/app_export.dart';

class SplashScreen extends GetWidget<SplashController> {
  SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 28.v),
            CustomImageView(
              imagePath: ImageConstant.logoImg,
            )
          ],
        ),
      ),
    );
  }
}
