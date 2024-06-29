import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences? _shared;

  static Future<void> initialize() async =>
      _shared ??= await SharedPreferences.getInstance();

  // Example method to demonstrate usage
  Future<void> setString({required String key, required String value}) async =>
      await _shared!.setString(key, value);

  Future<void> setBool({required String key, required bool value}) async =>
      await _shared!.setBool(key, value);

  String? getString({required String key}) => _shared!.getString(key);
  bool? getBool({required String key}) => _shared!.getBool(key);

  static Future<void> signOut() async {
    await _shared!.remove('userID');
    await _shared!.remove('userType');
  }
}
