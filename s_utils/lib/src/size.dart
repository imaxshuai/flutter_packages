import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeExtension on num {
  static double get over => ScreenUtil().screenWidth - 1125 / 2436 * ScreenUtil().screenHeight;

  static double get scale {
    num length = (over >= 0 ? over : 0);
    return (ScreenUtil().screenWidth - length) / ScreenUtil().screenWidth;
  }

  double get w => ScreenUtil().setWidth(this * scale);

  double get s =>  ScreenUtil().setSp(this);

  double get ww => ScreenUtil().setWidth(this);
}
