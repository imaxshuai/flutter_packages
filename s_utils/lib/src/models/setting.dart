import 'dart:ui';

import 'package:package_info/package_info.dart';
import 'package:uuid/uuid.dart';

class SSetting {
  static Map<String, dynamic> setting = {
    "uuid": Uuid().v1(),
    "name": "Setting",
    "local": Locale('en', 'US'),
    "user": null,
    "access_token": "",
  };

  static late dynamic user;

  static Map config = {};

  static late PackageInfo packageInfo;

  static late Function onSettingChange;

  static Map lastVersion = {};

  static late Map<String, String> enUS;

  static late Map<String, String> zhTW;
}
