import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learn/dao/travel_dao.dart';
import 'package:flutter_learn/model/travel_category_model.dart';
import 'package:flutter_learn/pages/travel_tab_page.dart';
import 'package:underline_indicator/underline_indicator.dart';

///旅拍页面
class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPagePageState();
}

class _TravelPagePageState extends State<TravelPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<TravelTab> tabs = [];
  late TabController _controller;
  TravelCategoryModel? travelCategoryModel;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    TravelDao.getCategory()
        .then((TravelCategoryModel model) {
          //执行成功
          setState(() {
            tabs = model.tabs;
            travelCategoryModel = model;
            _controller = TabController(length: model.tabs.length, vsync: this);
          });
          debugPrint('travelDao success ${jsonEncode(travelCategoryModel)}');
        })
        .catchError((e) {
          // 执行失败
          debugPrint('travelDao fail ${e.toString()}');
        });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); //因为用到this所以需要dispose释放资源
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: top),
            child: _tabBar,
          ),
          Flexible(child: _tabBarView),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
  get _tabBar => TabBar(
    tabAlignment: TabAlignment.start, //tab左对齐
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: UnderlineIndicator(
      borderSide: BorderSide(color: Colors.blue, width: 3),
      insets: const EdgeInsets.only(bottom: 10),
    ),
    controller: _controller,
    isScrollable: true,
    labelColor: Colors.black,
    tabs:
        tabs.map<Tab>((tab) {
          return Tab(text: tab.labelName);
        }).toList(),
  );

  get _tabBarView => TabBarView(
    controller: _controller,
    children:
        tabs.map((tab) {
          return TravelTabPage(groupChannelCode: tab.groupChannelCode);
        }).toList(),
  );
}
