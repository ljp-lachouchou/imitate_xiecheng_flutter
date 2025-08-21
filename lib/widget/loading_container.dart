import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;
  const LoadingContainer({
    super.key,
    required this.child,
    required this.isLoading,
    this.cover = false,
  });

  get _loadingView =>
      Center(child: CircularProgressIndicator(color: Colors.blue));

  @override
  Widget build(BuildContext context) {
    return cover
        ? Stack(
          //堆叠效果
          children: [child, isLoading ? _loadingView : Container()],
        )
        : (isLoading ? _loadingView : child);
  }
}
