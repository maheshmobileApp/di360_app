import 'package:flutter/material.dart';

class CloseButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const CloseButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.pinkAccent, width: 2),
        ),
        padding: const EdgeInsets.all(2), 
        child: const Icon(
          Icons.close,
          size: 16,
          color: Colors.pinkAccent,
        ),
      ),
    );
  }
}
