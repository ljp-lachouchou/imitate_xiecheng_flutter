import 'package:flutter/material.dart';

///旅拍页面
class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPagePageState();
}

class _TravelPagePageState extends State<TravelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("旅拍")),
      body: Column(children: [const Text("旅拍")]),
    );
  }
}
