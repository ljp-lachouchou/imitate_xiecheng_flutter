import 'package:flutter/material.dart';

import '../navigator/tab_navigator.dart';
import '../pages/login_page.dart';

class NavigatorUtil {
  //用于获取不到context的地方
  static BuildContext? _context;
  static updateContext(BuildContext context) {
    _context = context;
    print("init:$_context");
  }

  ///跳转到指定界面
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  //跳转到首页
  static goToHome(BuildContext context) {
    //跳转到首页并且不能返回上一页
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TabNavigator()),
    );
  }

  //跳转到登录页
  static goToLogin() {
    Navigator.pushReplacement(
      _context!,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
