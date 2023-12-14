import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import '../core/app_export.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitFadingCircle(
      color: appTheme.orange,
      size: 40.v,
    ));
  }
}
