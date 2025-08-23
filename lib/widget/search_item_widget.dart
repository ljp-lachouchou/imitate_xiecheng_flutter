import 'package:flutter/material.dart';
import 'package:flutter_learn/util/navigator_util.dart';

import '../model/search_model.dart';

const types = [
  'channelgroup',
  'channelgs',
  'channelplane',
  'channeltrain',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup',
];

class SearchItemWidget extends StatelessWidget {
  final SearchModel searchModel;
  final SearchItem searchItem;
  const SearchItemWidget({
    super.key,
    required this.searchItem,
    required this.searchModel,
  });

  get _item => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey)),
    ),
    child: Row(
      children: [
        _iconContainer,
        Column(
          children: [
            SizedBox(width: 300, child: _title),
            Container(
              width: 300,
              margin: const EdgeInsets.only(top: 5),
              child: _subTitle,
            ),
          ],
        ),
      ],
    ),
  );

  get _title {
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(searchItem.word, searchModel.keyword ?? ''));
    spans.add(
      TextSpan(
        text: ' ${searchItem.districtname ?? ''} ${searchItem.zonename ?? ''}',
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
    return RichText(text: TextSpan(children: spans));
  }

  get _subTitle => RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: searchItem.price ?? "",
          style: const TextStyle(fontSize: 16, color: Colors.orange),
        ),
        TextSpan(
          text: ' ${searchItem.star ?? ''}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    ),
  );

  get _iconContainer => Container(
    margin: const EdgeInsets.all(1),
    child: Image(
      width: 26,
      height: 26,
      image: AssetImage(_typeImage(searchItem.type)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.jumpH5(url: searchItem.url, title: '详情');
      },
      child: _item,
    );
  }

  //根据item数据类型动态返回图标
  String _typeImage(String? type) {
    if (type == null) return 'image/type_travelgroup.png';
    String path = 'travelgroup';
    for (final val in types) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  List<TextSpan> _keywordTextSpans(String? word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.isEmpty) return spans;
    String wordL = word.toLowerCase(), keywordL = keyword.toLowerCase();
    const TextStyle normalTextStyle = TextStyle(
      fontSize: 16,
      color: Colors.black87,
    );
    const TextStyle keywordTextStyle = TextStyle(
      fontSize: 16,
      color: Colors.orange,
    );
    List<String> arr = wordL.split(keywordL);
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if (i != 0) {
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(
          TextSpan(
            style: keywordTextStyle,
            text: word.substring(preIndex, preIndex + keywordL.length),
          ),
        );
      }
      String val = arr[i];
      if (val.isNotEmpty) {
        spans.add(TextSpan(text: val, style: normalTextStyle));
      }
    }
    return spans;
  }
}
