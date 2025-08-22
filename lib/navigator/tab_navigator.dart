import 'package:flutter/material.dart';
import 'package:flutter_learn/pages/home_page.dart';
import 'package:flutter_learn/pages/my_page.dart';
import 'package:flutter_learn/pages/search_page.dart';
import 'package:flutter_learn/pages/travel_page.dart';

import '../util/navigator_util.dart';

///首页底部导航器
class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentIndex = 0;
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    NavigatorUtil.updateContext(context);
    return Scaffold(
      body: PageView(
        controller: _controller,
        //禁用左右滚动
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          SearchPage(hideLeft: true),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue, //文本默认颜色
        items: [
          _bottomItem("首页", Icons.home, 0),
          _bottomItem("搜索", Icons.search, 1),
          _bottomItem("旅拍", Icons.camera_alt, 2),
          _bottomItem("我的", Icons.account_circle, 3),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _controller.jumpToPage(index);
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
      label: title,
    );
  }
}
