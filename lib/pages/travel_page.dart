import 'package:flutter/material.dart';
import 'package:flutter_learn/controller/travel_controller.dart';
import 'package:flutter_learn/pages/travel_tab_page.dart';
import 'package:get/get.dart';
import 'package:underline_indicator/underline_indicator.dart';

///旅拍页面
class TravelPage extends StatelessWidget {
  const TravelPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(TravelController());
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: top),
            child: _tabBar(),
          ),
          Flexible(child: _tabBarView()),
        ],
      ),
    );
  }

  _tabBar() {
    return GetBuilder<TravelController>(
      builder: (TravelController controller) {
        return TabBar(
          tabAlignment: TabAlignment.start, //tab左对齐
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: UnderlineIndicator(
            borderSide: BorderSide(color: Colors.blue, width: 3),
            insets: const EdgeInsets.only(bottom: 10),
          ),
          controller: controller.controller,
          isScrollable: true,
          labelColor: Colors.black,
          tabs:
              controller.tabs.map<Tab>((tab) {
                return Tab(text: tab.labelName);
              }).toList(),
        );
      },
    );
  }

  _tabBarView() {
    return GetBuilder<TravelController>(
      builder: (TravelController controller) {
        return TabBarView(
          controller: controller.controller,
          children:
              controller.tabs.map((tab) {
                return TravelTabPage(groupChannelCode: tab.groupChannelCode);
              }).toList(),
        );
      },
    );
  }
}
