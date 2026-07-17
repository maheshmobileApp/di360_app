import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class EnableCommentsWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const EnableCommentsWidget({
    super.key,
    this.value = true,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Enable Comments",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Allow users to comment on this post.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.greenColor,
            activeTrackColor: AppColors.greenColor.withOpacity(0.4),
            inactiveTrackColor: AppColors.redColor.withOpacity(0.4),
            inactiveThumbColor: AppColors.redColor,
          ),
        ],
      ),
    );
  }
}