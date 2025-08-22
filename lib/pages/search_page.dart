import 'package:flutter/material.dart';
import 'package:flutter_learn/dao/search_dao.dart';
import 'package:flutter_learn/util/navigator_util.dart';
import 'package:flutter_learn/util/view_util.dart';
import 'package:flutter_learn/widget/search_bar_widget.dart';
import 'package:flutter_learn/widget/search_item_widget.dart';

import '../model/search_model.dart';

///搜索页面
class SearchPage extends StatefulWidget {
  final String? keyword;
  final String? hint;
  final bool? hideLeft;
  const SearchPage({super.key, this.keyword, this.hint, this.hideLeft = false});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel? searchModel;
  String? keyword;
  @override
  void initState() {
    super.initState();
    if (widget.keyword != null) {
      _onTextChange(widget.keyword!);
    }
  }

  get _appbar {
    //获取刘海高度
    double paddingTop = MediaQuery.of(context).padding.top;
    return shadowWrap(
      child: Container(
        height: 55 + paddingTop,
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(top: paddingTop),
        child: SearchBarWidget(
          hideLeft: widget.hideLeft,
          defaultText: keyword,
          hint: widget.hint,
          leftButtonClick: () => NavigatorUtil.pop(context),
          rightButtonClick: () {
            //收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          onChanged: _onTextChange,
        ),
      ),
      padding: const EdgeInsets.only(bottom: 5),
    );
  }

  get _listView => MediaQuery.removePadding(
    removeTop: true,
    context: context,
    child: Expanded(
      flex: 1,
      child: ListView.builder(
        itemCount: searchModel?.data?.length ?? 0,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [_appbar, _listView]));
  }

  void _onTextChange(String value) async {
    try {
      var result = await SearchDao.fetch(value);
      if (result.keyword == value) {
        setState(() {
          searchModel = result;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget _item(int index) {
    var item = searchModel?.data?[index];
    if (item == null || searchModel == null) return Container();
    return SearchItemWidget(searchItem: item, searchModel: searchModel!);
  }
}
