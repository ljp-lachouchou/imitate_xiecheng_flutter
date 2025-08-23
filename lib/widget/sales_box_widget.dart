import 'package:flutter/material.dart';
import 'package:flutter_learn/model/home_model.dart';

import '../util/navigator_util.dart';

class SalesBoxWidget extends StatelessWidget {
  final SalesBox salesBox;
  const SalesBoxWidget({super.key, required this.salesBox});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(7, 0, 7, 4),
      decoration: BoxDecoration(color: Colors.white),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = [];
    items.add(
      _doubleItem(context, salesBox.bigCard1!, salesBox.bigCard2!, true, false),
    );
    items.add(
      _doubleItem(
        context,
        salesBox.smallCard1!,
        salesBox.smallCard2!,
        false,
        false,
      ),
    );
    items.add(
      _doubleItem(
        context,
        salesBox.smallCard3!,
        salesBox.smallCard4!,
        false,
        true,
      ),
    );
    return Column(children: [_titleItem(), ...items]);
  }

  Widget _doubleItem(
    BuildContext context,
    CommonModel leftItem,
    CommonModel rightItem,
    bool big,
    bool last,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _item(context, leftItem, big, true, last),
        _item(context, rightItem, big, false, last),
      ],
    );
  }

  Widget _item(
    BuildContext context,
    CommonModel model,
    bool big,
    bool left,
    bool last,
  ) {
    double width = MediaQuery.of(context).size.width / 2 - 10;
    BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: () {
        NavigatorUtil.jumpH5(
          url: model.url,
          statusBarColor: model.statusBarColor,
          title: model.title,
          hideAppBar: model.hideAppBar,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: left ? borderSide : BorderSide.none,
            bottom: last ? BorderSide.none : borderSide,
          ),
        ),
        child: Image.network(
          model.icon!,
          fit: BoxFit.fill,
          width: width,
          height: big ? 136 : 70,
        ),
      ),
    );
  }

  _titleItem() {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xfff2f2f2))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(salesBox.icon!, height: 15, fit: BoxFit.fill),
          _moreItem(),
        ],
      ),
    );
  }

  _moreItem() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xffff4e63), Color(0x9fff6cc9)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          //todp：跳转到h5
        },
        child: Text(
          '获取更多福利 >',
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }
}
