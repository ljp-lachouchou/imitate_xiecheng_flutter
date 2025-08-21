import 'package:flutter/material.dart';
import 'package:flutter_learn/dao/login_dao.dart';
import 'package:flutter_learn/model/home_model.dart';
import 'package:flutter_learn/pages/search_page.dart';
import 'package:flutter_learn/util/navigator_util.dart';
import 'package:flutter_learn/widget/banner_widget.dart';
import 'package:flutter_learn/widget/grid_nav_widget.dart';
import 'package:flutter_learn/widget/loading_container.dart';
import 'package:flutter_learn/widget/local_nav_widget.dart';
import 'package:flutter_learn/widget/search_bar_widget.dart';
import 'package:flutter_learn/widget/sub_nav_widget.dart';

import '../dao/home_dao.dart';
import '../widget/sales_box_widget.dart';

const searchBarDefaultText = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {
  static Config? configModel;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;
  static const appbarScrollOffset = 100;
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNav? gridNavModel;
  SalesBox? salesBoxModel;
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
      backgroundColor: const Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Stack(children: [_contentView, _appBar]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  get _appBar {
    //获取刘海屏实际的top
    double top = MediaQuery.of(context).padding.top;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: top),
          height: 60 + top,
          decoration: BoxDecoration(
            color: Color.fromARGB((appBarOpacity * 255).toInt(), 255, 255, 255),
          ),
          child: SearchBarWidget(
            searchBarType:
                appBarOpacity > 0.2
                    ? SearchBarType.homeLight
                    : SearchBarType.home,
            inputBoxClick: _jumpToSearch,
            defaultText: searchBarDefaultText,
            rightButtonClick: LoginDao.logout,
          ),
        ),
        Container(
          height: appBarOpacity > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)],
          ),
        ),
      ],
    );
  }

  get _listView => ListView(
    children: [
      BannerWidget(bannerList: bannerList),
      LocalNavWidget(localNavList: localNavList),
      if (gridNavModel != null) GridNavWidget(gridNavModel: gridNavModel!),
      SubNavWidget(subNavList: subNavList),
      if (salesBoxModel != null) SalesBoxWidget(salesBox: salesBoxModel!),
      _logoutBtn,
    ],
  );

  get _contentView => MediaQuery.removePadding(
    removeTop: true, //移除顶部空白
    context: context,
    //NotificationListener 监听滚动
    child: RefreshIndicator(
      color: Colors.blue,
      onRefresh: _handleRefresh,
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
      ),
    ),
  );
  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  void _onScroll(double offset) {
    print('offset: $offset');
    double alpha = offset / appbarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    debugPrint('alpha:$alpha');
    setState(() {
      appBarOpacity = alpha;
    });
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        HomePage.configModel = model.config;
        localNavList = model.localNavList ?? [];
        subNavList = model.subNavList ?? [];
        bannerList = model.bannerList ?? [];
        gridNavModel = model.gridNav;
        salesBoxModel = model.salesBox;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _jumpToSearch() {
    NavigatorUtil.push(context, const SearchPage());
  }
}
