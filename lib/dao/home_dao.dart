import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_learn/dao/header_util.dart';
import 'package:flutter_learn/model/home_model.dart';
import 'package:flutter_learn/util/navigator_util.dart';
import 'package:http/http.dart' as http;

///首页接口
class HomeDao {
  static Future<HomeModel> fetch() async {
    var url = Uri.parse("https://api.geekailab.com/uapi/ft/home");
    final response = await http.get(url, headers: hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyString = utf8decoder.convert(response.bodyBytes);
    debugPrint(bodyString);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(bodyString);
      return HomeModel.fromJson(result['data']);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
      }
      throw Exception(bodyString);
    }
  }
}
