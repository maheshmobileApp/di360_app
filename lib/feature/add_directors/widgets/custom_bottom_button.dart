import 'package:flutter/material.dart';

class CustomBottomButton extends StatelessWidget {
  final VoidCallback onFirst;
  final VoidCallback onSecond;
  final String firstLabel;
  final String secondLabel;
  final Color firstBgColor;
  final Color firstTextColor;
  final Color secondBgColor;
  final Color secondTextColor;

  const CustomBottomButton({
    super.key,
    required this.onFirst,
    required this.onSecond,
    required this.firstLabel,
    required this.secondLabel,
    required this.firstBgColor,
    required this.firstTextColor,
    required this.secondBgColor,
    required this.secondTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFEFEFEF))),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: firstBgColor,
                foregroundColor: firstTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              onPressed: onFirst,
              child: Text(firstLabel),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondBgColor,
                foregroundColor: secondTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              onPressed: onSecond,
              child: Text(secondLabel),
            ),
          ),
        ],
      ),
    );
  }
}
