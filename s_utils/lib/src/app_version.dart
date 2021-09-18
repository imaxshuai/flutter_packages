import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:url_launcher/url_launcher.dart';

class AppVersion {
  static void showLatestVersion(newVersion, old, {String? desc, String? downloadUrl}) {
    if (haveNewVersion(newVersion, old)) updateVersion(newVersion, old, desc: desc, downloadUrl: downloadUrl);
  }

  static bool haveNewVersion(newVersion, old) {
    print("newVersion: $newVersion, old: $old");
    int newVersionInt, oldVersion;
    var newList = newVersion.split('.');
    var oldList = old.split('.');
    if (newList.length == 0 || oldList.length == 0) {
      return false;
    }
    for (int i = 0; i < newList.length; i++) {
      newVersionInt = int.parse(newList[i]);
      oldVersion = int.parse(oldList[i]);
      if (newVersionInt > oldVersion) {
        return true;
      } else if (newVersionInt < oldVersion) {
        return false;
      }
    }

    return false;
  }

  static updateVersion(newVersion, old, {String? desc, String? downloadUrl}) {
    print("updateVersion");

    Get.defaultDialog(
      title: "New Version: $newVersion",
      onConfirm: () async {
        if (await canLaunch("$downloadUrl")) {
          await launch("$downloadUrl", forceSafariVC: false);
        }
        Get.back();
      },
      content: Container(
        alignment: Alignment.topLeft,
        child: Text("$desc"),
      ),
    );
  }
}
