import 'package:flutter/material.dart';

class SafeAreaWrapper extends StatelessWidget {
  final Widget child;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final Color? backgroundColor;

  const SafeAreaWrapper({
    Key? key,
    required this.child,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: backgroundColor != null
          ? Container(
              color: backgroundColor,
              child: child,
            )
          : child,
    );
  }
}