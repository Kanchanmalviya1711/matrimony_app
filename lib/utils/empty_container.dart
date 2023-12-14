import 'package:flutter_svg/svg.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/theme/custom_text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';

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
          SvgPicture.asset(
            "assets/svg/empty2.svg",
            height: 200,
            width: 200,
          ),
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
                  "Retry",
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
