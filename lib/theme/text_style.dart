import 'package:flutter/material.dart';
import 'package:matrimony_app/theme/theme_helper.dart';

class CustommTextStyle {
  var subtitleStyle = TextStyle(
    fontSize: 14,
    fontFamily: "OpenSans",
    color: appTheme.gray,
  );

  var titleStyle = TextStyle(
      fontSize: 18, color: appTheme.black900, fontWeight: FontWeight.bold);
  var normalText = TextStyle(
      fontSize: 14,
      fontFamily: "OpenSans",
      color: appTheme.black900,
      fontWeight: FontWeight.w500);
  var normalTextBold = TextStyle(
      fontSize: 14,
      fontFamily: "OpenSans",
      color: appTheme.black900,
      fontWeight: FontWeight.bold);
}
