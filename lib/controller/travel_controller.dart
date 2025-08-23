import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dao/travel_dao.dart';
import '../model/travel_category_model.dart';

class TravelController extends GetxController with GetTickerProviderStateMixin {
  List<TravelTab> tabs = [];
  late TabController controller;
  TravelCategoryModel? travelCategoryModel;
  @override
  void onInit() {
    super.onInit();
    controller = TabController(length: 0, vsync: this);
    TravelDao.getCategory()
        .then((TravelCategoryModel model) {
          //执行成功
          tabs = model.tabs;
          travelCategoryModel = model;
          controller = TabController(length: model.tabs.length, vsync: this);
          debugPrint('travelDao success ${jsonEncode(travelCategoryModel)}');
          update();
        })
        .catchError((e) {
          // 执行失败
          debugPrint('travelDao fail ${e.toString()}');
        });
  }

  @override
  void onClose() {
    super.onClose();
    controller.dispose();
  }
}
