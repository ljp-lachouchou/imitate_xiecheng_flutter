import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_learn/dao/header_util.dart';
import 'package:flutter_learn/model/travel_category_model.dart';
import 'package:flutter_learn/model/travel_tab_model.dart';
import 'package:flutter_learn/util/navigator_util.dart';
import 'package:http/http.dart' as http;

class TravelDao {
  static Future<TravelCategoryModel> getCategory() async {
    var url = Uri.parse("https://api.geekailab.com/uapi/ft/category");
    final response = await http.get(url, headers: hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyString = utf8decoder.convert(response.bodyBytes);
    debugPrint(bodyString);
    if (response.statusCode == 200) {
      var result = json.decode(bodyString);
      return TravelCategoryModel.fromJson(result['data']);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
      }
      throw Exception(bodyString);
    }
  }

  static Future<TravelTabModel> getTravels(
    String groupChannelCode,
    int pageIndex,
    int pageSize,
  ) async {
    Map<String, String> params = {};
    params['pageIndex'] = pageIndex.toString();
    params['pageSize'] = pageSize.toString();
    params['groupChannelCode'] = groupChannelCode;
    var uri = Uri.https('api.geekailab.com', '/uapi/ft/travels', params);
    final response = await http.get(uri, headers: hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyString = utf8decoder.convert(response.bodyBytes);
    debugPrint(bodyString);
    if (response.statusCode == 200) {
      var result = jsonDecode(bodyString);
      return TravelTabModel.fromJson(result['data']);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
      }
      throw Exception(bodyString);
    }
  }
}
