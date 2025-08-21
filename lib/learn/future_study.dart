import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learn/learn/data_model.dart';
import 'package:http/http.dart' as http;

class FutureStudy extends StatefulWidget {
  const FutureStudy({super.key});

  @override
  State<FutureStudy> createState() => _FutureStudyState();
}

class _FutureStudyState extends State<FutureStudy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("future和futureBuilder实战应用")),
      body: FutureBuilder<DataModel>(
        future: fetchPost(),
        builder: (BuildContext context, AsyncSnapshot<DataModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text("state:none");
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return const Text("state:active");
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text(
                  "${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                );
              } else {
                return Column(
                  children: [
                    Text('code:${snapshot.data?.code}'),
                    Text('jsonParams:${snapshot.data?.data?.jsonParams}'),
                  ],
                );
              }
          }
        },
      ),
    );
  }

  Future<DataModel> fetchPost() async {
    var uri = Uri.parse("https://api.devio.org/uapi/test/testJson");
    Map<String, String> params = {"jsonData": "222"};
    final response = await http.post(
      uri,
      body: jsonEncode(params),
      headers: {"content-type": "application/json"},
    );
    Map<String, dynamic> map = jsonDecode(response.body);
    return DataModel.fromJson(map);
  }
}
