import 'package:flutter/material.dart';

///间距
///SizedBox是具有宽和高占位的盒子，可通过其设定值一定的间距
SizedBox hiSpace({double height = 1, double width = 1}) {
  return SizedBox(height: height, width: width);
}

///添加阴影
Widget shadowWrap({required Widget child, EdgeInsetsGeometry? padding}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0x66000000), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  );
}
