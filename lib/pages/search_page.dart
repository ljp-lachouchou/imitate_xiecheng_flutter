import 'package:flutter/material.dart';
import 'package:flutter_learn/widget/search_bar_widget.dart';

///搜索页面
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('搜索')),
      body: Column(
        children: [
          SearchBarWidget(
            hideLeft: true,
            defaultText: '广州',
            hint: '请输入',
            leftButtonClick: () {
              Navigator.pop(context);
            },
            onChanged: _onTextChange,
          ),
        ],
      ),
    );
  }

  void _onTextChange(String value) {}
}
