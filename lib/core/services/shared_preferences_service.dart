import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService._();
  static late final SharedPreferences sp;
  static Future<void> init() async =>
      sp = await SharedPreferences.getInstance();

  static Future<void> setToken(String token) async {
    await sp.setString('token', token);
  }

  static void logOut() async {
    await sp.clear();
  }

  static String? getToken() {
    return sp.getString('token');
  }

  static Future<void> setFirstTime() async {
    await sp.setBool('first', false);
  }

  static bool? getFirstTime() {
    return sp.getBool('first');
  }
}
