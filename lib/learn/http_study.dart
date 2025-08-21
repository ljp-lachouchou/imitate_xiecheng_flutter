import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpStudy extends StatefulWidget {
  const HttpStudy({super.key});

  @override
  State<HttpStudy> createState() => _HttpStudyState();
}

class _HttpStudyState extends State<HttpStudy> {
  var resultShow = "";
  var resultShow2 = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("基于Http实现网络操作")),
      body: Column(
        children: [
          _doGetBtn(),
          Text("返回的结果:$resultShow"),
          Text("解析的msg:$resultShow2"),
          _doPostBtn(),
          _doPostJsonBtn(),
        ],
      ),
    );
  }

  Widget _doGetBtn() {
    return ElevatedButton(onPressed: _doGet, child: const Text("发送Get请求"));
  }

  //发送get请求
  void _doGet() async {
    //async异步关键字 ,await关键字的使用前提是 方法体被async修饰
    var uri = Uri.parse("https://api.devio.org/uapi/test/test?requestPrams=11");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        resultShow = response.body;
      });
    } else {
      setState(() {
        resultShow = "请求失败:code ${response.statusCode},body: ${response.body}";
      });
    }
  }

  //发送post请求
  void _doPost() async {
    var uri = Uri.parse("https://api.devio.org/uapi/test/test");
    var params = {"requestPrams": "doPost"}; //Map<String,String>
    var response = await http.post(uri, body: params);
    if (response.statusCode == 200) {
      setState(() {
        resultShow = response.body;
      });
    } else {
      setState(() {
        resultShow = "请求失败:code ${response.statusCode},body: ${response.body}";
      });
    }
  }

  void _doPostJson() async {
    var uri = Uri.parse("https://api.devio.org/uapi/test/testJson");
    var params = {"requestParams": "doPost"};
    var response = await http.post(
      uri,
      body: jsonEncode(params),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      setState(() {
        resultShow = response.body;
      });
      var map = jsonDecode(response.body);
      setState(() {
        resultShow2 = map['msg'];
      });
    } else {
      setState(() {
        resultShow = "请求失败:code ${response.statusCode},body: ${response.body}";
      });
    }
  }

  Widget _doPostBtn() {
    return ElevatedButton(onPressed: _doPost, child: const Text("发送Post请求"));
  }

  Widget _doPostJsonBtn() {
    return ElevatedButton(
      onPressed: _doPostJson,
      child: const Text("发送Post请求"),
    );
  }
}
