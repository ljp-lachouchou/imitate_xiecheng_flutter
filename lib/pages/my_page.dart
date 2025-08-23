import 'package:flutter/material.dart';
import 'package:flutter_learn/widget/hi_webview.dart';

///我的页面
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPagePageState();
}

class _MyPagePageState extends State<MyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(
      body: HiWebView(
        url: 'https://m.ctrip.com/webapp/myctrip/',
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '0176ac',
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
