import 'package:get/get.dart';
import 'package:matrimony_app/presentation/about/binding/about_binding.dart';
import 'package:matrimony_app/presentation/about/ui/about_screen.dart';
import 'package:matrimony_app/presentation/allProfiles/binding/allProfiles_binding.dart';
import 'package:matrimony_app/presentation/allProfiles/ui/allProfiles_screen.dart';

import 'package:matrimony_app/presentation/contact/binding/contact_binding.dart';
import 'package:matrimony_app/presentation/contact/contactusScreen.dart';
import 'package:matrimony_app/presentation/home/binding/home_binding.dart';
import 'package:matrimony_app/presentation/home/ui/home_screen.dart';
import 'package:matrimony_app/presentation/login/binding/login_binding.dart';
import 'package:matrimony_app/presentation/login/login_screen.dart';
import 'package:matrimony_app/presentation/profile/binding/profile.binding.dart';
import 'package:matrimony_app/presentation/profile/ui/profile_screen.dart';
import 'package:matrimony_app/presentation/register/binding/register_binding.dart';
import 'package:matrimony_app/presentation/register/ui/register_screen.dart';
import 'package:matrimony_app/presentation/splash/binding/splash_binding.dart';
import 'package:matrimony_app/presentation/splash/ui/splash_screen.dart';
import 'package:matrimony_app/presentation/testimonials/binding/testimonials_binding.dart';
import 'package:matrimony_app/presentation/testimonials/ui/testimonials_screen.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';
  static const String homeScreen = '/homeScreen';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = "/registerScreen";
  static const String aboutScreen = "/aboutScreen";
  static const String profileScreen = "/profileScreen";
  static const String profileListScreen = "/profileListScreen";
  static const String testimonialsScreen = "/testimonialsScreen";
  static const String allProfilesScreen = "/allProfilesScreen";
  static const String contactUsScreen = "/contactUsScreen";
  static const String viewAllProfilesScreen = "/viewAllProfilesScreen";

  static List<GetPage> pages = [
    GetPage(
      binding: SplashBinding(),
      name: initialRoute,
      page: () => SplashScreen(),
    ),
    GetPage(
      binding: LoginBinding(),
      name: loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      binding: RegisterBinding(),
      name: registerScreen,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      binding: HomeBinding(),
      name: homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      binding: AboutBinding(),
      name: aboutScreen,
      page: () => const AboutScreen(),
    ),
    GetPage(
      binding: ProfileBinding(),
      name: profileScreen,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      binding: TestimonialsBinding(),
      name: testimonialsScreen,
      page: () => const TestimonialsScreen(),
    ),
    GetPage(
      binding: AllProfilesBinding(),
      name: allProfilesScreen,
      page: () => const AllProfilesScreen(),
    ),
    GetPage(
      binding: ContactBinding(),
      name: contactUsScreen,
      page: () => const ContactUsScreen(),
    ),
    // GetPage(
    //   binding: AllProfilesBinding(),
    //   name: viewAllProfilesScreen,
    //   page: () => const ViewAllProfiles(),
    // ),
  ];
}
