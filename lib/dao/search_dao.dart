import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_learn/dao/header_util.dart';
import 'package:flutter_learn/model/search_model.dart';
import 'package:flutter_learn/util/navigator_util.dart';
import 'package:http/http.dart' as http;

class SearchDao {
  static Future<SearchModel> fetch(String text) async {
    var uri = Uri.parse("https://api.geekailab.com/uapi/ft/search?q=$text");
    final response = await http.get(uri, headers: hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyString = utf8decoder.convert(response.bodyBytes);
    debugPrint(bodyString);
    if (response.statusCode == 200) {
      var result = json.decode(bodyString);
      SearchModel searchModel = SearchModel.fromJson(result);
      searchModel.keyword = text;
      return searchModel;
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
      }
      throw Exception(bodyString);
    }
  }
}
