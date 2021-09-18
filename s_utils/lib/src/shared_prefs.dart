import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SharedPrefs {
  static SharedPrefs? _singleton;
  static late SharedPreferences _prefs;
  static Lock _lock = Lock();

  static Future<SharedPrefs?> getInstance() async {
    try {
      if (_singleton == null) {
        await _lock.synchronized(() async {
          if (_singleton == null) {
            // keep local instance till it is fully initialized.
            // 保持本地实例直到完全初始化。
            var singleton = SharedPrefs._();
            await singleton._init();
            _singleton = singleton;
          }
        });
      }
      return _singleton;
    } catch (e) {
      throw e;
    }
  }

  SharedPrefs._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// get string.
  static String getString(String key, {String? defValue = ''}) {
    return "${_prefs.getString(key) ?? ""}";
  }

  /// put string.
  static Future<bool>? putString(String key, String value) {
    return _prefs.setString(key, value);
  }

  /// get bool.
  static bool? getBool(String key, {bool? defValue = false}) {
    return _prefs.getBool(key) ?? defValue;
  }

  /// put bool.
  static Future<bool>? putBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  /// get int.
  static int? getInt(String key, {int? defValue = 0}) {
    return _prefs.getInt(key) ?? defValue;
  }

  static Map? getObject(String key) {
    String? _data = _prefs.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  /// put object.
  static Future<bool>? putObject(String key, Object value) {
    return _prefs.setString(key, json.encode(value));
  }

  /// put int.
  static Future<bool>? putInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  /// get double.
  static double? getDouble(String key, {double? defValue = 0.0}) {
    return _prefs.getDouble(key) ?? defValue;
  }

  /// put double.
  static Future<bool>? putDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  /// get string list.
  static List<String>? getStringList(String key, {List<String>? defValue = const []}) {
    return _prefs.getStringList(key) ?? defValue;
  }

  /// put string list.
  static Future<bool>? putStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  /// have key.
  static bool haveKey(String key) {
    return _prefs.containsKey(key);
  }
  /// get keys.
  static Set<String>? getKeys() {
    return _prefs.getKeys();
  }

  /// remove.
  static Future<bool>? remove(String key) {
    return _prefs.remove(key);
  }

  /// clear.
  static Future<bool>? clear() {
    return _prefs.clear();
  }

  /// Fetches the latest values from the host platform.
  static Future<void>? reload() {
    return _prefs.reload();
  }

}
