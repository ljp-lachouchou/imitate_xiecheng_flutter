import 'package:flutter/cupertino.dart';

//扩展函数
extension NumFix on num {
  double get px {
    return ScreenHelper.getPx(toDouble());
  }
}

///屏幕适配工具类
class ScreenHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double ratio;
  static init(BuildContext context, {double baseWidth = 375}) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    ratio = screenWidth / baseWidth;
  }

  //获取设计稿对应的大小
  static double getPx(double size) {
    return ratio * size;
  }
}
