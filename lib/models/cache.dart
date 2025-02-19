import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static late final SharedPreferences prefs;

  static void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveEligibilty() {
    prefs.setBool("OnBoarding", true);
  }

  static bool? getEligibilty() {
    return prefs.getBool("OnBoarding");
  }

  static void setToken(String token) {
    prefs.setString("auth_token", token);
  }

  static String? getToken() {
    return prefs.getString("auth_token");
  }

  static void removeToken() {
    prefs.remove("auth_token");
  }
}
