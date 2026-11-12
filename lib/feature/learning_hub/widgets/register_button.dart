import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isRegistered;
  final String courseStatus;
  final String type;

  const RegisterButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isRegistered,
    required this.courseStatus,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
            color: _getColor(text), borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(String text) {
    if (text == "REGISTER NOW") {
      return AppColors.black;
    } else if (text == "AWAITING APPROVAL") {
      return AppColors.redColor;
    } else if (text == "SOLD OUT") {
      return AppColors.brownColor;
    } else {
      return AppColors.primaryColor;
    }
  }
}
