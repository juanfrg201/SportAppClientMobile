import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static int? get userId => _preferences?.getInt('userId');

  static Future<void> setUserId(int userId) async {
    await _preferences?.setInt('userId', userId);
  }

  static Future<int?> verifyAndGetUserId() async {
    if (_preferences == null) {
      await init();
    }
    return _preferences?.getInt('userId');
  }
}
