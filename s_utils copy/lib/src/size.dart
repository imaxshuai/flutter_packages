import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Sizes {
  static double get statusBarHeight => ScreenUtil().statusBarHeight;

  static double get bottomBarHeight => ScreenUtil().bottomBarHeight;

  static double get screenWidth => ScreenUtil().screenWidth;

  static double get screenHeight => ScreenUtil().screenHeight;

  static double over =
      ScreenUtil().screenWidth - 1125 / 2436 * ScreenUtil().screenHeight;

  static double get scale {
    num length = (Sizes.over >= 0 ? Sizes.over : 0);
    return (ScreenUtil().screenWidth - length) / ScreenUtil().screenWidth;
  }

  static double get footer =>
      ScreenUtil().setWidth(147 * scale) +
      (ScreenUtil().bottomBarHeight == 0
          ? ScreenUtil().setWidth(35 * scale)
          : ScreenUtil().bottomBarHeight);

  static double get header =>
      ScreenUtil().setWidth(132 * scale) + ScreenUtil().statusBarHeight;
}

extension SizeExtension on num {
  static double get scale {
    num length = (Sizes.over >= 0 ? Sizes.over : 0);
    return (ScreenUtil().screenWidth - length) / ScreenUtil().screenWidth;
  }

  double get w => ScreenUtil().setWidth(this * scale);

  double get s => ScreenUtil().setSp(this);

  double get ww => ScreenUtil().setWidth(this);

  double get footer => MediaQuery.of(Get.context!).padding.bottom == 0.0
      ? ScreenUtil().setWidth(this * scale)
      : 0.0;
}
