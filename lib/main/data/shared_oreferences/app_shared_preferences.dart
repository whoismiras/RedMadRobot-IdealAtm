import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  AppSharedPreferences(this.locale);

  String? locale;

  static Future<AppSharedPreferences> init() async {
    String? locale1 = await loadLocale();
    return AppSharedPreferences(locale1);
  }

  static saveLocale(String locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', locale);
  }

  static Future<String?> loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? locale = prefs.getString('locale');
    return locale;
  }
}
