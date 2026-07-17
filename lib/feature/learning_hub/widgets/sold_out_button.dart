import 'package:flutter/material.dart';

class SoldOutButton extends StatelessWidget {
  const SoldOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: Colors.brown, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "SOLD OUT",
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.lock,
            color: Colors.white,
            size: 16,
          ),
        ],
      ),
    );
  }
}
