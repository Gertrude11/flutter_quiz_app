import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAIL";

  static Future<bool> saveUserLoggedInSharedPreference(
     {required bool isUserLoggedIn}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        Constants.sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<Object?> getUerLoggedInSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(Constants.sharedPreferenceUserLoggedInKey);
  }
}