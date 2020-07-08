import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharePreferenceLoggedInKey = 'ISLOGIN';
  static String sharePreferenceUserNameKey = 'USERNAMEKEY';
  static String sharePreferenceEmailKey = 'EMAILKEY';
  static String sharePreferenceMediaUrlKey = 'MEDIAURLKEY';

//setData
  static Future<bool> saveUserLoggedInSharedPreference(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharePreferenceLoggedInKey, isLoggedIn);
  }

  static Future<bool> saveUserUserNameSharedPreference(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharePreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharePreferenceEmailKey, userEmail);
  }

  static Future<bool> saveUserMediaUrlSharedPreference(String mediaUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharePreferenceMediaUrlKey, mediaUrl);
  }

//getData

  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getBool(sharePreferenceLoggedInKey);
  }

  static Future<String> getEmailLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString(sharePreferenceEmailKey);
  }

  static Future<String> getUserUserNameSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString(sharePreferenceUserNameKey);
  }

  static Future<String> getUserMediaUrlSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString(sharePreferenceMediaUrlKey);
  }
}
