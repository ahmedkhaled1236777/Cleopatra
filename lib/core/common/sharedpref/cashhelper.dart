import 'package:shared_preferences/shared_preferences.dart';

class cashhelper {
  static late SharedPreferences sharedPreferences;
  static initcashhelper() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setdata({required String key, required dynamic? value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    }
    if (value is List<String>) {
      return await sharedPreferences.setStringList(key, value);
    }
  }

  static getdata({required String key}) {
    return sharedPreferences.get(key);
  }

  static cleardata() async {
    return await sharedPreferences.clear();
  }
}
