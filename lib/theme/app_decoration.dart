// import 'package:hr_management/core/app_export.dart';

// class AppDecoration {
//   // Fill decorations

//   static BoxDecoration get cardDecoration => BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//                 color: appTheme.gray500.withOpacity(0.1),
//                 spreadRadius: 0,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3))
//           ],
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(10.v),
//               bottomRight: Radius.circular(10.v)));

//   static InputDecoration customInputDecoration(
//       Color fillColor,  bool isPrefixIcon,
//       {IconButton? iconButton,
//       String? hintText,
//       Widget? prefixIcon,
//       Widget? suffixIcon,
//       String? counterText,
//       bool? offStage,
//       bool? isDense,
//       TextStyle? counterStyle,
//       String? labelText,
//       String? errorText}) {
//     double radius = 10;
//     return InputDecoration(
//       contentPadding: EdgeInsets.symmetric(vertical: 10.v, horizontal: 20.h),
      
//       labelText: labelText,
//       counterStyle: CustomTextStyles.titleSmall14,
//       counterText: counterText,
//       isDense: isDense ?? false,
      
//       errorText: errorText,
//       hintText: hintText,
//       hintStyle: CustomTextStyles.titleSmall14,
//       labelStyle: CustomTextStyles.titleSmall14,
    
//       prefixIcon: isPrefixIcon == false
//           ? null
//           : Padding(
//               padding: EdgeInsets.only(top: 20.v, bottom: 20.v),
//               child: prefixIcon,
//             ),
//       suffixIcon: Padding(
//         padding: EdgeInsets.only(
//           top: 20.v,
//           bottom: 20.v,
//         ),
//         child: suffixIcon,
//       ),
//       filled: true,
//       fillColor: fillColor,
//       counter: Offstage(
//         offstage: offStage ?? true,
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(radius),
//         borderSide:
//             BorderSide(color: appTheme.orange.withOpacity(0.2), width: 1),
//       ),
//       focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(radius),
//           borderSide:
//               BorderSide(color: appTheme.orange.withOpacity(0.2), width: 1)),
//       errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(radius),
//           borderSide: BorderSide(color: Colors.red.withOpacity(0.8), width: 1)),
//       focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(radius),
//           borderSide: BorderSide(color: Colors.red.withOpacity(0.8), width: 1)),
//       disabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(radius),
//           borderSide: const BorderSide(color: Colors.grey, width: 1)),
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(radius),
//           borderSide: const BorderSide(color: Colors.grey, width: 1)),
//     );
//   }
// }

// // Comment/Uncomment the below code based on your Flutter SDK version.

// // For Flutter SDK Version 3.7.2 or greater.

// double get strokeAlignInside => BorderSide.strokeAlignInside;

// double get strokeAlignCenter => BorderSide.strokeAlignCenter;

// double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// // For Flutter SDK Version 3.7.1 or less.

// // StrokeAlign get strokeAlignInside => StrokeAlign.inside;
// //
// // StrokeAlign get strokeAlignCenter => StrokeAlign.center;
// //
// // StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
