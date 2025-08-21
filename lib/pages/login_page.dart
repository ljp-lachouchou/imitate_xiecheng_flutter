import 'package:flutter/material.dart';
import 'package:flutter_learn/dao/login_dao.dart';
import 'package:flutter_learn/util/navigator_util.dart';
import 'package:flutter_learn/util/string_util.dart';
import 'package:flutter_learn/util/view_util.dart';
import 'package:flutter_learn/widget/input_widget.dart';
import 'package:flutter_learn/widget/login_widget.dart';
import 'package:url_launcher/url_launcher.dart';

//登录页
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginEnable = false;
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //防止弹起键盘影响布局
      body: Stack(
        children: [
          ..._backGround(), //...的语法表示：将返回的list展开
          _content(),
        ],
      ),
    );
  }

  _backGround() {
    return <Widget>[
      Positioned.fill(
        child: Image.asset('images/login-bg1.jpg', fit: BoxFit.cover),
      ),
      Positioned.fill(
        child: Container(decoration: BoxDecoration(color: Colors.black54)),
      ),
    ];
  }

  _content() {
    return Positioned.fill(
      left: 25,
      right: 25,
      child: ListView(
        children: [
          hiSpace(height: 100),
          const Text(
            "账号密码登录",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          hiSpace(height: 40),
          InputWidget(
            hint: "请输入账号",
            onChanged: (text) {
              userName = text;
              _checkInput();
            },
          ),
          hiSpace(height: 10),
          InputWidget(
            hint: "请输入密码",
            obscureText: true,
            onChanged: (text) {
              password = text;
              _checkInput();
            },
          ),
          hiSpace(height: 45),
          LoginButton(
            title: "登录",
            enable: loginEnable,
            onPressed: () => _login(context),
          ),
          hiSpace(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => _jumpRegistration(),
              child: Text("注册账号", style: TextStyle(color: Colors.white)),
            ),
          ), //InkWell实现长按、点击等的回调
        ],
      ),
    );
  }

  void _checkInput() {
    bool enable = false;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    }
    setState(() {
      loginEnable = enable;
    });
    print("loginEnable $loginEnable");
  }

  //todo:登录
  void _login(BuildContext context) async {
    try {
      var result = await LoginDao.login(
        userName: userName!,
        password: password!,
      );
      print("登录成功");
      NavigatorUtil.goToHome(context);
    } catch (e) {
      print(e);
    }
  }

  _jumpRegistration() async {
    //跳转接口的后台的注册页面
    Uri uri = Uri.parse(
      "http://api.devio.org/uapi/swagger-ui.html#/Account/registrationUsingPOST",
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      //不能打开web应用
      throw "can't open $uri";
    }
  }
}
