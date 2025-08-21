import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learn/learn/data_model.dart';

//json解析与dart moel的使用
class JsonParsingPage extends StatefulWidget {
  const JsonParsingPage({super.key});

  @override
  State<JsonParsingPage> createState() => _JsonParsingPageState();
}

class _JsonParsingPageState extends State<JsonParsingPage> {
  var resultShow = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("json解析与drat model 的使用")),
      body: Column(
        children: [_json2MapBtn(), _json2ModelBtn(), Text("结果:$resultShow")],
      ),
    );
  }

  Widget _json2MapBtn() {
    return ElevatedButton(onPressed: _json2Map, child: const Text("json转Map"));
  }

  void _json2Map() {
    var jsonString =
        '{"code": 0,"data": {"code": 0,"method": "POST", "jsonParams": {"jsonData": "222"}},"msg": "SUCCESS." }';
    Map<String, dynamic> map = jsonDecode(jsonString);
    setState(() {
      resultShow =
          'code:${map['code']}; jsonParams: ${map['data']['jsonParams']}';
    });
  }

  void _json2Model() {
    var jsonString =
        '{"code": 0,"data": {"code": 0,"method": "POST", "jsonParams": {"jsonData": "222"}},"msg": "SUCCESS." }';
    Map<String, dynamic> map = jsonDecode(jsonString);
    DataModel model = DataModel.fromJson(map);
    setState(() {
      resultShow = model.toString();
    });
  }

  Widget _json2ModelBtn() {
    return ElevatedButton(
      onPressed: _json2Model,
      child: const Text("json转model"),
    );
  }
}
