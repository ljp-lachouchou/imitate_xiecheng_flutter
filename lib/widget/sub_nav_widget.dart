import 'package:flutter/material.dart';
import 'package:flutter_learn/model/home_model.dart';

class SubNavWidget extends StatelessWidget {
  final List<CommonModel> subNavList;
  const SubNavWidget({super.key, required this.subNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 4, 7, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(padding: const EdgeInsets.all(7), child: _items(context)),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = [];
    for (var model in subNavList) {
      items.add(_item(context, model));
    }
    //计算出第一行显示的数量
    int separate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, items.length),
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          //todo:跳转到h5
        },
        child: Column(
          children: [
            Image.network(model.icon!, width: 18, height: 18),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(model.title!, style: const TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
