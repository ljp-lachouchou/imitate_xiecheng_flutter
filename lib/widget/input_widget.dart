import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged; //回调函数 更改值
  final bool obscureText; //是否以密码形式展现
  final TextInputType? keyboardType; // 键盘类型
  const InputWidget({
    super.key,
    required this.hint,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _input(),
        Divider(color: Colors.white, height: 1, thickness: 0.5),
      ],
    );
  }

  _input() {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autofocus: !obscureText,
      cursorColor: Colors.white,
      style: TextStyle(
        fontSize: 17,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      //输入框样式
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
      ),
    );
  }
}
