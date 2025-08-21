import 'package:flutter/material.dart';
import 'package:flutter_learn/dao/login_dao.dart';
import 'package:flutter_learn/widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  static const appbarScrollOffset = 100;
  final bannerList = [
    "https://www.devio.org/io/flutter_app/img/banner/100h10000000q7ght9352.jpg",
    "https://o.devio.org/images/fa/cat-4098058__340.webp",
    "https://o.devio.org/images/fa/photo-1601513041797-a79a526a521e.webp",
    "https://o.devio.org/images/other/as-cover.png",
    "https://o.devio.org/images/other/rn-cover2.png",
  ];
  double appBarOpacity = 0;
  get _logoutBtn => Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Container(
      color: Colors.blue,
      child: TextButton(
        onPressed: () {
          LoginDao.logout();
        },
        child: Text("登出"),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
            removeTop: true, //移除顶部空白
            context: context,
            child: NotificationListener(
              child: _listView,
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.depth == 0) {
                  //滚动更新通知 注意 只要有滚动更新就会回调此方法
                  //notification.depth == 0表示只监听listView的滚动
                  _onScroll(notification.metrics.pixels); //当前滚动的像素距离
                }
                return false; //只监听 不消费
              },
            ), //监听滚动
          ),
          _appBar,
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  get _appBar => Opacity(
    opacity: appBarOpacity,
    child: Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.white),
      child: const Center(
        child: Padding(padding: EdgeInsets.only(top: 20), child: Text("首页")),
      ),
    ),
  );

  get _listView => ListView(
    children: [
      BannerWidget(bannerList: bannerList),
      _logoutBtn,
      const SizedBox(height: 800, child: ListTile(title: Text("hhh"))),
    ],
  );

  void _onScroll(double offset) {
    print('offset: $offset');
    double alpha = offset / appbarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    print('alpha:$alpha');
    setState(() {
      appBarOpacity = alpha;
    });
  }
}
