import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class ExerinaceInfoIcons extends StatelessWidget {
  final IconData icon;
  final String text;

  const ExerinaceInfoIcons({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.blueGrey,
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyles.medium2(color: AppColors.locationTextColor),
          ),
        ),
      ],
    );
  }
}
