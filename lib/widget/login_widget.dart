import 'package:flutter/material.dart';

///带禁用功能的按钮
class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback? onPressed;

  const LoginButton({
    super.key,
    required this.title,
    this.enable = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      height: 45,

      onPressed: enable ? onPressed : null,
      disabledColor: Colors.white60,
      color: Colors.orange,
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
