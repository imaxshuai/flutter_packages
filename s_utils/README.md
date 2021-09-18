# s_utils

A new Flutter package project.

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/), a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on mobile development, and a
full API reference.

- Main 方法初始化

```dart
await initServices();

Future<void> initServices() async {
  print("initServices");
  WidgetsFlutterBinding.ensureInitialized();
  // 强制竖屏
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // 初始化Firebase
  PushNotification.init();
  // 初始化SettingsService
  await Get.putAsync(() => SettingsService().init());
}
```

- init get

```dart
import 'package:get/get.dart';

// MaterialApp 替换 GetMaterialApp
```

- init flutter_screenutil

```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
ScreenUtilInit(
  designSize: const Size(1125, 2436),
  builder: () => GetMaterialApp(),
)
*/

```

- PushNotification

```dart
  // PushNotification.init(); 最好在main方法中调用
PushNotification.init();

// 在tab page 调用
PushNotification.updateToken();
PushNotification.requestPermission();

void _handleNotificationLink() {
  Future.delayed(Duration(seconds: 2), () {
    String data = Hp.getString(Shares.notificationLink);
    if (data != "") {
      PushNotification.click(jsonDecode(data));
    }
  });
}

// PushNotification.onMsg(); 在app page 调用
PushNotification.onMsg();

static updateDeviceToken() {
  throw UnimplementedError();
}

static redirectAction() {
  throw UnimplementedError();
}

static updateDeviceToken() {
  throw UnimplementedError();
}


```

- UrlLink

```dart
// UrlLink.incomingLinks(); 在app page 调用
UrlLink.incomingLinks();

// 在tab page 调用 _handleLinkUrl
void _handleLinkUrl() {
  Future.delayed(Duration(seconds: 2), () {
    String uriStr = Hp.getString(Shares.linkUrl);
    if (uriStr != "") {
      UrlLink.handleUrl(Uri.parse(uriStr));
    }
  });
}

```