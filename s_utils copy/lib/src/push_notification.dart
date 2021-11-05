import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'shared_prefs.dart';

import 'models/setting.dart';

class PushNotification {

  static late Function updateDeviceToken;
  static late Function redirectAction;
  static late Function refreshBadge;

  static Future<void> init() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(PushNotification.backgroundHandler);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static onMsg() async {
    // 清除通知
    FlutterAppBadger.removeBadge();

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        click(message.data);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      refreshBadge();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // 点击通知处理
      click(message.data);
    });

  }

  static updateToken(){
    FirebaseMessaging.instance.getToken().then((token) {
      SharedPrefs.putString("device_token", "$token");
      updateDeviceToken();
    });
  }

  static Future<void> requestPermission() async {
    // 等待两秒弹出通知授权提示
    await Future.delayed(Duration(seconds: 2));
    FirebaseMessaging.instance.requestPermission();
  }

  static void click(Map<dynamic, dynamic>? data) {
    if (SSetting.config['version'] == null) {
      SharedPrefs.putString("notification_link", jsonEncode(data));
      return;
    }

    // 先移除link url 缓存
    SharedPrefs.remove("notification_link");
    redirectAction(data);
  }

  static handleInitApp() async {
    // 处理通过点击通知,启动App处理
    RemoteMessage? m = await FirebaseMessaging.instance.getInitialMessage();
    if (m != null) {
      PushNotification.click(m.data);
    }
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    refreshBadge();
    return;
  }

}
