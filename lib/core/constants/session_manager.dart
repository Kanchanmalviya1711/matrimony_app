import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static SharedPreferences? preferences;
  static const _user = "access_token";
  static const _token = "token";
  static const _userId = "userId";
  static const _role = "role";
  static const _gender = "gender";
  static const _interestedGender = "gender";
  static const _userProfile = "userProfile";
  static const _profileCreated = "profileCreated";
  static const _myConnections = "myConnections";

  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  static dynamic setUser(String user) {
    return preferences!.setString(_user, user);
  }

  static dynamic getUser() {
    return preferences!.getString(_user);
  }

  // MY CONNECTIONS
  static dynamic setMyConnections(String myConnections) {
    return preferences!.setString(_myConnections, myConnections);
  }

  static dynamic getMyConnections() {
    return preferences!.getString(_myConnections);
  }

  static dynamic setUserProfileData(String userProfile) {
    return preferences!.setString(_userProfile, userProfile);
  }

  static dynamic getUserProfileData() {
    return preferences!.getString(_userProfile);
  }

  static dynamic setUserId(String userId) {
    return preferences!.setString(_userId, userId);
  }

  static String? getUserId() {
    return preferences!.getString(_userId);
  }

  static dynamic setToken(String token) {
    return preferences!.setString(_token, token);
  }

  static dynamic getToken() {
    return preferences!.getString(_token);
  }

  static dynamic setRole(String role) {
    return preferences!.setString(_role, role);
  }

  static dynamic getRole() {
    return preferences!.getString(_role);
  }

  static dynamic removeToken() {
    return preferences!.remove(_token);
  }

  static dynamic setGender(String gender) {
    return preferences!.setString(_gender, gender);
  }

  static String? getGender() {
    return preferences!.getString(_gender);
  }

  static dynamic setInterestedGender(String interestedGender) {
    return preferences!.setString(_interestedGender, interestedGender);
  }

  static String? getInterestedGender() {
    return preferences!.getString(_interestedGender);
  }

  static bool isProfileCreated() {
    return preferences!.getBool(_profileCreated) ?? false;
  }

  static void setProfileCreated(bool created) {
    preferences!.setBool(_profileCreated, created);
  }
}

class AuthService {
  static Future<bool> loginUser(
      String username, String password, String userId, String token) async {
    // Perform authentication logic here
    bool authenticationSuccessful =
        true; // Define the variable authenticationSuccessful

    if (authenticationSuccessful) {
      // Set the user's profile as created
      SessionManager.setProfileCreated(true);

      // Other user-related settings (e.g., set user information)
      SessionManager.setUserId(userId);
      SessionManager.setUser(username);
      SessionManager.setToken(token);

      return true;
      // Remove the dead code block
      // } else {
      //   return false;
      // }
    }
  }
}
