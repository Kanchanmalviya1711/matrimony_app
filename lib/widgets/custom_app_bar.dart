import 'package:flutter/services.dart';
import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/theme/text_style.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/size_utils.dart';
import 'package:matrimony_app/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key? key,
      this.height,
      this.leadingWidth,
      this.leading,
      this.title,
      this.centerTitle,
      this.actions,
      this.scaffoldState})
      : super(
          key: key,
        );

  final double? height;

  final double? leadingWidth;

  final Widget? leading;

  final String? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  GlobalKey<ScaffoldState>? scaffoldState;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0,
      toolbarHeight: height ?? 80.v,
      automaticallyImplyLeading: false,
      // backgroundColor: const Color(0xFFFF9F43),
      backgroundColor: appTheme.black900,
      // leadingWidth: leadingWidth ?? 30,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: leading ??
            CustomIconButton(
              child: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onTap: () {
                scaffoldState!.currentState!.openDrawer();
              },
            ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          title ?? "",
          style:
              CustommTextStyle().titleStyle.copyWith(color: appTheme.whiteA700),
        ),
      ),
      //titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        mediaQueryData.size.width,
        height ?? 80.v,
      );
}
