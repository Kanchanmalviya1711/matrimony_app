class ApiNetwork {
  // BASE URL
  static const String baseUrl = "http://192.168.1.43:9090/";
  static const String imageUrl = "http://192.168.1.43:9090";
  static const String fileDownloadUrl = "http://192.168.1.43:9090/";

  // LOGIN
  static const String login = "${baseUrl}login/jwt";
  static const String usersList = "${baseUrl}user/register/";
  static const String addUser = "${baseUrl}user/register";
  static const String viewUser = "${baseUrl}user/38";
  static const String uploadFile = "${baseUrl}file/fileupload";
  static const String loginVerify = "${baseUrl}login/verify";
  static const String forgotPassword = "${baseUrl}login/forgot-password";
  static const String slidersList = "${baseUrl}slider/";
  static const String testimonyList = "${baseUrl}testimony/";
  static const String menusList = "${baseUrl}menu/";
  static const String allProfilesList = "${baseUrl}profile/";
  static const String allProfilesListView = "${baseUrl}profile/";
  static const String blogsList = "${baseUrl}blog/";
  static const String getAboutDetails = "${baseUrl}about-us/";
  static const String getContactUsDetails = "${baseUrl}contact-us/";
  static const String getOurTeamDetails = "${baseUrl}our-team/";
  static const String getAppSettings = "${baseUrl}app-setting";
  static const String getOurServices = "${baseUrl}service/";
  static const String createProfile = "${baseUrl}profile";
  static const String getProfile = "${baseUrl}profile/";
  static const String friendRequest = "${baseUrl}friend-request";
}
