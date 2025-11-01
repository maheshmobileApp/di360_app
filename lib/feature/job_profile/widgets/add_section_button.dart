import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class AddSectionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AddSectionButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        minimumSize: const Size(140, 40), 
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: TextStyles.clashMedium(fontSize: 12, color: AppColors.whiteColor),
      ),
      onPressed: onPressed,
      child: Text(
        "+ $label",
        style: TextStyles.clashMedium(fontSize: 14,color: AppColors.whiteColor),
      ),
    );
  }
}
