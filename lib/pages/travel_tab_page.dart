import 'package:flutter/material.dart';
import 'package:flutter_learn/controller/travel_tab_controller.dart';
import 'package:flutter_learn/widget/travel_item_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../widget/loading_container.dart';

class TravelTabPage extends StatefulWidget {
  final String groupChannelCode;
  const TravelTabPage({super.key, required this.groupChannelCode});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  late TravelTabController _controller;
  get _gridView => MasonryGridView.count(
    controller: _controller.scrollController,
    crossAxisCount: 2,
    itemCount: _controller.travelItems.length,
    itemBuilder:
        (context, index) => TravelItemWidget(
          item: _controller.travelItems[index],
          index: index,
        ),
  );
  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      TravelTabController(widget.groupChannelCode),
      tag: widget.groupChannelCode,
    );
    //增加tag，我需要的不是单例
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(body: _obx);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  get _obx => Obx(
    () => LoadingContainer(
      isLoading: _controller.loading.value,
      child: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Colors.blue,
        child: MediaQuery.removePadding(
          context: context,
          child: _gridView,
          removeTop: true,
        ),
      ),
    ),
  );

  Future<void> _handleRefresh() async {
    await _controller.loadingData();
    return;
  }
}
