import 'package:flutter/material.dart';

class RefreshLoadMorePage extends StatefulWidget {
  const RefreshLoadMorePage({super.key});

  @override
  State<RefreshLoadMorePage> createState() => _RefreshLoadMorePageState();
}

class _RefreshLoadMorePageState extends State<RefreshLoadMorePage> {
  final ScrollController _controller = ScrollController();
  List<String> cityNames = [
    '北京',
    '上海',
    '广州',
    '深圳',
    '杭州',
    '苏州',
    '唐山',
    '重庆',
    '拉萨',
    '青岛',
    '济南',
    '石家庄',
  ];
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const title = "上拉刷新和下拉加载";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(children: _buildList(), controller: _controller),
      ),
    );
  }

  _buildList() {
    return cityNames.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(color: Colors.redAccent),
      child: Text(city, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      cityNames = cityNames.reversed.toList();
    });
  }

  void _loadData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      List<String> list = List<String>.from(cityNames);
      list.addAll(cityNames);
      cityNames = list;
    });
  }
}
