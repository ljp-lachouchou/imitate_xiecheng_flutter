import 'package:flutter/material.dart';
import 'package:flutter_learn/util/navigator_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

///h5容器
class HiWebView extends StatefulWidget {
  final String? url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool? backForbid;
  const HiWebView({
    super.key,
    this.url,
    this.statusBarColor,
    this.title,
    this.hideAppBar,
    this.backForbid,
  });

  @override
  State<HiWebView> createState() => _HiWebViewState();
}

class _HiWebViewState extends State<HiWebView> {
  //需要捕获的h5的网址
  final _catchUrls = [
    'm.ctrip.com/',
    'm.ctrip.com/html5/',
    'm.ctrip.com/html5',
  ];
  String? url;
  late WebViewController _webViewController;
  @override
  void initState() {
    super.initState();
    url = widget.url;
    if (url != null && url!.contains('ctrip.com')) {
      //fix  协程h5 http://无法打开
      url = url!.replaceAll("http://", "https://");
    }
    debugPrint("widgetUrl:$url");
    _initWebViewController();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor = Colors.white;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    }
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
        } else {
          if (context.mounted) {
            NavigatorUtil.pop(context); //在异步任务中防止widget已经被销毁而出现问题
          }
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            _appBar(
              Color(int.parse('0xff$statusBarColorStr')),
              backButtonColor,
            ),
            Expanded(child: WebViewWidget(controller: _webViewController)),
          ],
        ),
      ),
    );
  }

  void _initWebViewController() {
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                debugPrint("progress $progress");
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {
                //页面加载之后才能执行js
                _handleBackForbid();
              },
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                // if (_isToMain(request.url)) {
                //   debugPrint('widgetUrl 阻止跳转到request${request.url}');
                //   NavigatorUtil.pop(context);
                //   return NavigationDecision.prevent;
                // } else {
                //   debugPrint('允许跳转到request${request.url}');
                //   return NavigationDecision.navigate;
                // }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(url!));
  }

  @override
  void dispose() {
    _webViewController.clearCache();
    _webViewController.clearLocalStorage();
    super.dispose();
  }

  ///隐藏h5登录页返回键
  void _handleBackForbid() {
    const jsStr =
        "var element = document.querySelector('.animationComponent.rn-view'); element.style.display = 'none';";
    if (widget.backForbid ?? false) {
      _webViewController.runJavaScript(jsStr);
    }
  }

  bool _isToMain(String? url) {
    bool contain = false;
    for (final value in _catchUrls) {
      if (url?.contains(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    double top = MediaQuery.of(context).padding.top;
    if (widget.hideAppBar ?? false) {
      return Container(color: backgroundColor, height: top);
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, top, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [_backBtn(backButtonColor), _title(backButtonColor)],
        ),
      ),
    );
  }

  _backBtn(Color backButtonColor) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Icon(Icons.close, color: backButtonColor, size: 26),
      ),
    );
  }

  _title(Color backButtonColor) {
    return Positioned(
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          widget.title ?? "",
          style: TextStyle(color: backButtonColor, fontSize: 20),
        ),
      ),
    );
  }
}
