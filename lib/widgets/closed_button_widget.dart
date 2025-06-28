import 'package:flutter/material.dart';

class CloseButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const CloseButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: GestureDetector(
        onTap: onTap,
        child: const CircleAvatar(
          radius: 14,
          backgroundColor: Colors.pinkAccent,
          child: Icon(
            Icons.close,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}