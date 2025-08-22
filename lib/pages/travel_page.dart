import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learn/dao/travel_dao.dart';
import 'package:flutter_learn/model/travel_category_model.dart';

///旅拍页面
class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPagePageState();
}

class _TravelPagePageState extends State<TravelPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelTab> tabs = [];
  TravelCategoryModel? travelCategoryModel;
  @override
  void initState() {
    super.initState();
    TravelDao.getCategory()
        .then((TravelCategoryModel model) {
          //执行成功
          setState(() {
            tabs = model.tabs;
            travelCategoryModel = model;
          });
          debugPrint('travelDao success ${jsonEncode(travelCategoryModel)}');
        })
        .catchError((e) {
          // 执行失败
          debugPrint('travelDao fail ${e.toString()}');
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text("旅拍")),
      body: Column(children: [Text(jsonEncode(travelCategoryModel))]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
