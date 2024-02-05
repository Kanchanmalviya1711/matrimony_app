import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import '../core/app_export.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitFadingCircle(
      color: color,
      size: size,
    ));
  }
}
