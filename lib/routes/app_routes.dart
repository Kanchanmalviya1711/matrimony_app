import 'package:get/get.dart';
import 'package:matrimony_app/presentation/about/binding/about_binding.dart';
import 'package:matrimony_app/presentation/about/ui/about_screen.dart';
import 'package:matrimony_app/presentation/about/ui/viewOurTeam_screen.dart';
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
import 'package:matrimony_app/presentation/gallery/binding/gallery_binding.dart';
import 'package:matrimony_app/presentation/gallery/ui/gallery_screen.dart';
import 'package:matrimony_app/presentation/home/binding/home_binding.dart';
import 'package:matrimony_app/presentation/home/ui/home_screen.dart';
import 'package:matrimony_app/presentation/login/binding/login_binding.dart';
import 'package:matrimony_app/presentation/login/forgotPassword_screen.dart';
import 'package:matrimony_app/presentation/login/login_screen.dart';
import 'package:matrimony_app/presentation/login/update_otpverify_screen.dart';
import 'package:matrimony_app/presentation/notifications/binding/notifications_binding.dart';
import 'package:matrimony_app/presentation/notifications/ui/notifications_screen.dart';
import 'package:matrimony_app/presentation/ourServices/binding/ourServices_binding.dart';
import 'package:matrimony_app/presentation/ourServices/ui/ourServicesDetailsScreen.dart';
import 'package:matrimony_app/presentation/ourServices/ui/ourServices_screen.dart';
import 'package:matrimony_app/presentation/pageNotFound/binding/pageNotFound_binding.dart';
import 'package:matrimony_app/presentation/pageNotFound/ui/pageNotFound.dart';
import 'package:matrimony_app/presentation/plansAndPricing/binding/plans_binding.dart';
import 'package:matrimony_app/presentation/plansAndPricing/ui/plans_screen.dart';
import 'package:matrimony_app/presentation/profile/binding/profile.binding.dart';
import 'package:matrimony_app/presentation/profile/ui/profile_screen.dart';
import 'package:matrimony_app/presentation/register/binding/register_binding.dart';
import 'package:matrimony_app/presentation/register/ui/register_screen.dart';
import 'package:matrimony_app/presentation/settings/binding/settings_binding.dart';
import 'package:matrimony_app/presentation/settings/ui/settings_screen.dart';
import 'package:matrimony_app/presentation/sliders/binding/sliders_binding.dart';
import 'package:matrimony_app/presentation/sliders/ui/view_sliders_screen.dart';
import 'package:matrimony_app/presentation/splash/binding/splash_binding.dart';
import 'package:matrimony_app/presentation/splash/ui/splash_screen.dart';
import 'package:matrimony_app/presentation/suscriptions/binding/suscriptions_binding.dart';
import 'package:matrimony_app/presentation/suscriptions/ui/suscriptions_screen.dart';
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
  static const String galleryScreen = "/galleryScreen";
  static const String ourServicesDetailsScreen = "/ourServicesDetailsScreen";
  static const String suscriptionScreen = "/suscriptionScreen";
  static const String pageNotFound = "/pageNotFound";
  static const String viewSliderScreen = "/viewSliderScreen";
  static const String viewOurTeamDetailsScreen = "/viewOurTeamDetailsScreen";
  static const String plansAndPricingScreen = "/plansAndPricingScreen";
  static const String settings = "/setting";

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
    //view our team screen
    GetPage(
      binding: AboutBinding(),
      name: viewOurTeamDetailsScreen,
      page: () => const ViewOurTeamScreen(),
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
    //view blog screen
    GetPage(
      binding: BlogBinding(),
      name: viewBlogScreen,
      page: () => const ViewBlogScreen(),
    ),
    //our service screen
    GetPage(
      binding: OurServicesBinding(),
      name: ourServiceScreen,
      page: () => const OurServicesScreen(),
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
    //our service details screen
    GetPage(
      binding: OurServicesBinding(),
      name: ourServicesDetailsScreen,
      page: () => const OurServicesDetailsScreen(),
    ),
    //gallery screen
    GetPage(
      binding: GalleryBinding(),
      name: galleryScreen,
      page: () => const GalleryScreen(),
    ),
    //suscription screen
    GetPage(
      binding: SuscriptionBinding(),
      name: suscriptionScreen,
      page: () => const SuscriptionScreen(),
    ),
    //page not found screen
    GetPage(
      binding: PageNotFoundBinding(),
      name: pageNotFound,
      page: () => const PageNotFound(),
    ),
    //slider screen
    GetPage(
      binding: SlidersBinding(),
      name: viewSliderScreen,
      page: () => const ViewSliderScreen(),
    ),
    // plans and pricing screen
    GetPage(
      binding: PlansAndPricingBinding(),
      name: plansAndPricingScreen,
      page: () => const PlansAndPricingScreen(),
    ),
    //settings
    GetPage(
        binding: SettingsBinding(),
        name: settings,
        page: () => const SettingsScreen())
  ];
}
