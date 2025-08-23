import 'package:flutter/material.dart';
import 'package:flutter_learn/dao/travel_dao.dart';
import 'package:flutter_learn/widget/loading_container.dart';
import 'package:flutter_learn/widget/travel_item_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/travel_tab_model.dart';

class TravelTabPage extends StatefulWidget {
  final String groupChannelCode;
  const TravelTabPage({super.key, required this.groupChannelCode});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  bool _loading = true;
  final ScrollController _scrollController = ScrollController();
  get _gridView => MasonryGridView.count(
    controller: _scrollController,
    crossAxisCount: 2,
    itemCount: travelItems.length,
    itemBuilder:
        (context, index) =>
            TravelItemWidget(item: travelItems[index], index: index),
  );
  @override
  void initState() {
    _loadingData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadingData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
        isLoading: _loading,
        child: RefreshIndicator(
          onRefresh: _loadingData,
          color: Colors.blue,
          child: MediaQuery.removePadding(
            context: context,
            child: _gridView,
            removeTop: true,
          ),
        ),
      ),
    );
  }

  Future<void> _loadingData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    try {
      TravelTabModel model = await TravelDao.getTravels(
        widget.groupChannelCode,
        pageIndex,
        10,
      );
      List<TravelItem> items = _filterItems(model.list);
      if (loadMore && items.isEmpty) pageIndex--;
      setState(() {
        _loading = false;
        if (loadMore) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      if (loadMore) pageIndex--;
    }
  }

  List<TravelItem> _filterItems(List<TravelItem>? list) {
    if (list == null) return [];
    List<TravelItem> filterItems = [];
    for (var item in list) {
      if (item.article != null) filterItems.add(item);
    }
    return filterItems;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
