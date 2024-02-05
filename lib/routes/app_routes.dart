import 'package:get/get.dart';
import 'package:matrimony_app/presentation/about/binding/about_binding.dart';
import 'package:matrimony_app/presentation/about/ui/about_screen.dart';
import 'package:matrimony_app/presentation/allProfiles/binding/allProfiles_binding.dart';
import 'package:matrimony_app/presentation/allProfiles/ui/allProfiles_screen.dart';
import 'package:matrimony_app/presentation/allProfiles/ui/createProfile_screen.dart';
import 'package:matrimony_app/presentation/allProfiles/ui/viewAllProfiles.dart';
import 'package:matrimony_app/presentation/blog/binding/blog_binding.dart';
import 'package:matrimony_app/presentation/blog/ui/blog_screen.dart';
import 'package:matrimony_app/presentation/blog/ui/view_blog_screen.dart';
import 'package:matrimony_app/presentation/chats/binding/chat_binding.dart';
import 'package:matrimony_app/presentation/chats/ui/chat_screen.dart';
import 'package:matrimony_app/presentation/contact/binding/contact_binding.dart';
import 'package:matrimony_app/presentation/contact/contactusScreen.dart';
import 'package:matrimony_app/presentation/friendRequestScreen/binding/friendRequest_binding.dart';
import 'package:matrimony_app/presentation/friendRequestScreen/ui/friendRequest_screen.dart';
import 'package:matrimony_app/presentation/home/binding/home_binding.dart';
import 'package:matrimony_app/presentation/home/ui/home_screen.dart';
import 'package:matrimony_app/presentation/login/binding/login_binding.dart';
import 'package:matrimony_app/presentation/login/forgotPassword_screen.dart';
import 'package:matrimony_app/presentation/login/login_screen.dart';
import 'package:matrimony_app/presentation/login/update_otpverify_screen.dart';
import 'package:matrimony_app/presentation/notifications/binding/notifications_binding.dart';
import 'package:matrimony_app/presentation/notifications/ui/notifications_screen.dart';
import 'package:matrimony_app/presentation/ourServices/binding/ourServices_binding.dart';
import 'package:matrimony_app/presentation/ourServices/ui/ourServices_screen.dart';
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
  static const String blogScreen = "/blogScreen";
  static const String ourTeamScreen = "/ourTeamScreen";
  static const String ourServiceScreen = "/OurServiceScreen";
  static const String viewBlogScreen = "/viewBlogScreen";
  static const String createProfileScreen = "/createProfileScreen";
  static const String friendRequestScreen = "/friendRequestScreen";
  static const String forgotPasswordScreen = "/forgotPasswordScreen";
  static const String verifyOtpScreen = "/verifyOtpScreen";
  static const String notificationScreen = "/notificationScreen";
  static const String chatScreen = "/chatScreen";

  static List<GetPage> pages = [
    //splash screen
    GetPage(
      binding: SplashBinding(),
      name: initialRoute,
      page: () => SplashScreen(),
    ),
    //login screen
    GetPage(
      binding: LoginBinding(),
      name: loginScreen,
      page: () => const LoginScreen(),
    ),
    //register screen
    GetPage(
      binding: RegisterBinding(),
      name: registerScreen,
      page: () => const RegisterScreen(),
    ),
    //home screen
    GetPage(
      binding: HomeBinding(),
      name: homeScreen,
      page: () => const HomeScreen(),
    ),
    //about screen
    GetPage(
      binding: AboutBinding(),
      name: aboutScreen,
      page: () => const AboutScreen(),
    ),
    //profile screen
    GetPage(
      binding: ProfileBinding(),
      name: profileScreen,
      page: () => const ProfileScreen(),
    ),
    //testimonials screen
    GetPage(
      binding: TestimonialsBinding(),
      name: testimonialsScreen,
      page: () => const TestimonialsScreen(),
    ),
    //redirect to all profiles or posts based on the user type.
    GetPage(
      binding: AllProfilesBinding(),
      name: allProfilesScreen,
      page: () => const AllProfilesScreen(),
    ),
    //View all profile screen by there id
    GetPage(
      binding: AllProfilesBinding(),
      name: viewAllProfilesScreen,
      page: () => const ViewAllProfiles(),
    ),
    //contact screen
    GetPage(
      binding: ContactBinding(),
      name: contactUsScreen,
      page: () => const ContactUsScreen(),
    ),
    //blog screen
    GetPage(
      binding: BlogBinding(),
      name: blogScreen,
      page: () => const BlogScreen(),
    ),
    //our service screen
    GetPage(
      binding: OurServicesBinding(),
      name: ourServiceScreen,
      page: () => const OurServicesScreen(),
    ),
    //view blog screen
    GetPage(
      binding: BlogBinding(),
      name: viewBlogScreen,
      page: () => const ViewBlogScreen(),
    ),
    //create profile screen
    GetPage(
      binding: ProfileBinding(),
      name: createProfileScreen,
      page: () => const CreateProfileScreen(),
    ),
    //friend request screen
    GetPage(
      binding: FriendRequestBinding(),
      name: friendRequestScreen,
      page: () => const FriendRequestScreen(),
    ),
    //forgot password screen
    GetPage(
      binding: LoginBinding(),
      name: forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
    ),
    //verify otp screen
    GetPage(
      binding: LoginBinding(),
      name: verifyOtpScreen,
      page: () => const UpdateOtpVerifyScreen(),
    ),
    //notification screen
    GetPage(
        binding: NotificationsBinding(),
        name: notificationScreen,
        page: () => const Notifications()),
    //chat screen
    GetPage(
        binding: ChatBinding(),
        name: chatScreen,
        page: () => const ChatScreen()),
  ];
}
