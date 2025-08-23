import 'package:flutter/cupertino.dart';
import 'package:flutter_learn/model/travel_tab_model.dart';
import 'package:get/get.dart';

import '../dao/travel_dao.dart';

class TravelTabController extends GetxController {
  final String groupChannelCode;
  final travelItems = <TravelItem>[].obs;
  final loading = true.obs;
  int pageIndex = 1;
  TravelTabController(this.groupChannelCode);
  final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    loadingData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadingData(loadMore: true);
      }
    });
    super.onInit();
  }

  List<TravelItem> _filterItems(List<TravelItem>? list) {
    if (list == null) return [];
    List<TravelItem> filterItems = [];
    for (var item in list) {
      if (item.article != null) filterItems.add(item);
    }
    return filterItems;
  }

  Future<void> loadingData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    try {
      TravelTabModel model = await TravelDao.getTravels(
        groupChannelCode,
        pageIndex,
        10,
      );
      List<TravelItem> items = _filterItems(model.list);
      if (loadMore && items.isEmpty) pageIndex--;
      loading.value = false;
      if (!loadMore) {
        travelItems.clear();
      }
      travelItems.addAll(items);
    } catch (e) {
      debugPrint(e.toString());
      if (loadMore) pageIndex--;
    }
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
