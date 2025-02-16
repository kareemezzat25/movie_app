import 'package:easy_localization/easy_localization.dart';
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
}
