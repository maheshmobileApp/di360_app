import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isRegistered;

  const RegisterButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isRegistered,
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
            color: isRegistered ? AppColors.primaryColor : AppColors.black,
            borderRadius: BorderRadius.circular(8)),
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
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
