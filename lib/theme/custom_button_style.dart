// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hr_management/theme/theme_helper.dart';

// /// A class that offers pre-defined button styles for customizing button appearance.
// class CustomButtonStyles {
//   // Filled button style
//   static ButtonStyle get fillLightBlue => ElevatedButton.styleFrom(
//         backgroundColor: appTheme.lightBlue500,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.h),
//         ),
//       );

//   // Outline button style
//   static ButtonStyle get outlinePrimary => OutlinedButton.styleFrom(
//         backgroundColor: appTheme.whiteA700.withOpacity(0.85),
//         side: BorderSide(
//           color: theme.colorScheme.primary.withOpacity(0.25),
//           width: 1,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.horizontal(
//             left: Radius.circular(
//               5.h,
//             ),
//           ),
//         ),
//       );
//   static ButtonStyle get outlinePrimaryTL10 => OutlinedButton.styleFrom(
//         backgroundColor: appTheme.whiteA700.withOpacity(0.85),
//         side: BorderSide(
//           color: theme.colorScheme.primary.withOpacity(0.25),
//           width: 1,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(
//               10.h,
//             ),
//             topRight: Radius.circular(
//               10.h,
//             ),
//             bottomLeft: Radius.circular(
//               10.h,
//             ),
//           ),
//         ),
//       );
//   static ButtonStyle get outlinePrimaryTL101 => OutlinedButton.styleFrom(
//         backgroundColor: theme.colorScheme.primary,
//         side: BorderSide(
//           color: theme.colorScheme.primary.withOpacity(0.1),
//           width: 1,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.h),
//         ),
//       );
//   static ButtonStyle get outlineRedD => OutlinedButton.styleFrom(
//         backgroundColor: appTheme.whiteA700,
//         side: BorderSide(
//           color: appTheme.red600D8,
//           width: 2,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.h),
//         ),
//       );
//   // text button style
//   static ButtonStyle get none => ButtonStyle(
//         backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
//         elevation: MaterialStateProperty.all<double>(0),
//       );
// }
