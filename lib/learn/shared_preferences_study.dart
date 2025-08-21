import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStudy extends StatefulWidget {
  const SharedPreferencesStudy({super.key});

  @override
  State<SharedPreferencesStudy> createState() => _SharedPreferencesStudyState();
}

class _SharedPreferencesStudyState extends State<SharedPreferencesStudy> {
  String countString = "";
  String localCount = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("基于shared_preferences实现的计数器")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _incrementCounter,
            child: const Text("增加计数"),
          ),
          ElevatedButton(
            onPressed: _getCounter,
            child: const Text('Get Counter'),
          ),
          Text(countString, style: const TextStyle(fontSize: 20)),
          Text(localCount, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  void _incrementCounter() async {
    SharedPreferences sps = await SharedPreferences.getInstance();
    setState(() {
      countString = "$countString 1";
    });
    int counter = (sps.getInt('counter') ?? 0) + 1;
    await sps.setInt('counter', counter);
  }

  _getCounter() async {
    SharedPreferences sps = await SharedPreferences.getInstance();
    setState(() {
      localCount = sps.getInt('counter').toString();
    });
  }
}
