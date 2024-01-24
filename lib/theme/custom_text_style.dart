import 'package:matrimony_app/core/app_export.dart';
import 'package:matrimony_app/theme/theme_helper.dart';
import 'package:matrimony_app/utils/size_utils.dart';

class CustomTextStyles {
  // Body text style
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900.withOpacity(0.85),
      );
  static get testingText => theme.textTheme.bodySmall!.copyWith(
      color: appTheme.whiteA700, fontSize: 20, fontWeight: FontWeight.bold);
  static get bodySmallBlack900_1 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900.withOpacity(0.7),
      );
  static get bodySmallBluegray900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray900.withOpacity(0.75),
        fontSize: 20.fSize,
      );
  static get bodySmallMulishBlack900 =>
      theme.textTheme.bodySmall!.mulish.copyWith(
        color: appTheme.black900.withOpacity(0.35),
      );
  static get bodySmallMulishBlack90010 =>
      theme.textTheme.bodySmall!.mulish.copyWith(
        color: appTheme.black900.withOpacity(0.75),
        fontSize: 10.fSize,
      );
  // Label text style
  static get labelLargeBlack900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 32.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeBlack90000 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.7),
        fontSize: 26.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeBlack900Bold => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 13.fSize,
        fontWeight: FontWeight.w700,
      );
  static get labelLargeBlack900SemiBold => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.85),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeBlack900SemiBold13 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.6),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeBlack900SemiBold13_1 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.5),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeBluegray900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray900,
      );
  static get labelLargeBluegray900SemiBold =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray900.withOpacity(0.75),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeBluegray900_1 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray900,
      );
  static get labelLargeMulishBlack900 =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: Colors.black,
        fontSize: 16,
      );
  static get labelLargeMulishBlack900SemiBold =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: appTheme.black900.withOpacity(0.85),
        fontWeight: FontWeight.w600,
      );
  static get labelLargeMulishBlack900SemiBold13 =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: appTheme.black900.withOpacity(0.75),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeMulishBlack900SemiBold_1 =>
      theme.textTheme.labelLarge!.mulish.copyWith(
          color: appTheme.whiteA700,
          fontWeight: FontWeight.w600,
          fontSize: 18.fSize);
  static get labelLargeMulishBlack900SemiBold_2 =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeMulishBlack900SemiBold_3 =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: appTheme.black900.withOpacity(0.85),
        fontWeight: FontWeight.w600,
      );
  static get labelLargeMulishBlack900SemiBold_4 =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: appTheme.black900.withOpacity(0.75),
        fontWeight: FontWeight.w600,
      );
  static get labelLargeMulishBlack900_1 =>
      theme.textTheme.labelLarge!.mulish.copyWith(
        color: appTheme.black900.withOpacity(0.75),
      );
  static get labelMediumBluegray900 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.blueGray900.withOpacity(0.7),
        fontSize: 11.fSize,
      );
  static get labelMediumMulishBlack900 =>
      theme.textTheme.labelMedium!.mulish.copyWith(
        color: appTheme.black900.withOpacity(0.75),
        fontWeight: FontWeight.w700,
      );
  static get labelMediumMulishBlack900Bold =>
      theme.textTheme.labelMedium!.mulish.copyWith(
        color: appTheme.black900.withOpacity(0.47),
        fontWeight: FontWeight.w700,
      );
  static get labelMediumMulishBlack900Bold_1 =>
      theme.textTheme.labelMedium!.mulish.copyWith(
        color: appTheme.black900.withOpacity(0.75),
        fontWeight: FontWeight.w700,
      );
  static get labelMediumMulishBlack900SemiBold =>
      theme.textTheme.labelMedium!.mulish.copyWith(
        color: appTheme.black900.withOpacity(0.85),
        fontWeight: FontWeight.w600,
      );
  // Title text style
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
      );
  static get titleLargeBlack90021 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.85),
        fontSize: 21.fSize,
      );
  static get titleLargeBlack900Bold => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.85),
        fontWeight: FontWeight.w700,
      );
  static get titleLargePoppinsPrimary =>
      theme.textTheme.titleLarge!.poppins.copyWith(
        color: theme.colorScheme.primary.withOpacity(0.85),
        fontWeight: FontWeight.w700,
      );
  static get titleMedium166 => theme.textTheme.titleMedium!.copyWith(
      fontSize: 25.fSize, color: theme.colorScheme.primary.withOpacity(0.85));

  static get titleMedium16 => theme.textTheme.titleMedium!
      .copyWith(fontSize: 29.fSize, color: appTheme.black900);

  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumLightblue500 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.lightBlue500.withOpacity(0.85),
      );
  static get titleMediumRed600d8 => theme.textTheme.titleMedium!
      .copyWith(color: Colors.red, fontWeight: FontWeight.w400, fontSize: 11);
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 16.fSize,
      );
  static get titleMediumBlackA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 16.fSize,
      );
  static get titleMediumWhiteA700Bold => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumWhiteA700Bold_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumWhiteA700Bold_2 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumBlackA700Bold_2 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
      );
  static get titleSmall14 => theme.textTheme.titleSmall!.copyWith(
        fontSize: 14.fSize,
      );
  static get titleSmallBlack => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w900,
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900.withOpacity(0.85),
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallBlack900ExtraBold =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900.withOpacity(0.64),
        fontWeight: FontWeight.w800,
      );
  static get titleSmallBlack900ExtraBold_1 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900.withOpacity(0.85),
        fontWeight: FontWeight.w800,
      );
  static get titleSmallBlue600 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blue600,
      );
  static get splashScreenPage => theme.textTheme.titleSmall!.copyWith(
      color: appTheme.orange, fontSize: 30, fontWeight: FontWeight.bold);
  static get titleSmallMedium => theme.textTheme.titleSmall!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.fSize,
      color: theme.colorScheme.onPrimary);
  static get titleSmallPoppinsPrimary =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallPoppinsPrimarySemiBold =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallPoppinsPrimarySemiBold_1 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary.withOpacity(0.85),
        fontSize: 14.fSize,
      );
  static get titleSmallPrimary_1 => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallSemiBold => theme.textTheme.titleSmall!.copyWith(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallSemiBold_1 => theme.textTheme.titleSmall!.copyWith(
        fontSize: 18.fSize,
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallWhiteA700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 30.fSize,
      );
  static get titleSmallBlackA700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
        fontSize: 30.fSize,
      );
  static get titleSmallBlackA500 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
        fontSize: 25.fSize,
      );
  static get titleLargeWhiteA600 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 23.fSize,
      );
  static get titleSubHeading => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.subHeadingColor,
        fontSize: 16.fSize,
      );
  static get titleMedium20 => theme.textTheme.titleMedium!.copyWith(
      fontSize: 25.fSize, color: theme.colorScheme.primary.withOpacity(0.85));
  static get titleSmall_1 => theme.textTheme.titleSmall!;
  static get titleSmall_2 => theme.textTheme.titleSmall!;
}

extension on TextStyle {
  TextStyle get mulish {
    return copyWith(
      fontFamily: 'Mulish',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}
