import 'package:flutter/material.dart';

///我的页面
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPagePageState();
}

class _MyPagePageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我的")),
      body: Column(children: [const Text("我的")]),
    );
  }
}
