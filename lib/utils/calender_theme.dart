import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/string_capitalization.dart';
import '../core/app_export.dart';

calenderTheme(child, context) {
  return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: appTheme.black900,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                textStyle: const TextStyle(fontSize: 15)),
          )),
      child: child!);
}

dropDownError({msg}) {
  Fluttertoast.showToast(
      msg: msg.toString().toCapitalized(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
  return null;
}
