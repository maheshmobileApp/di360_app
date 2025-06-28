import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ExperienceAccordionItem extends StatelessWidget {
  final Widget? details;
  final bool? isExpanded;

  const ExperienceAccordionItem({
    super.key,
    this.details,
    this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.borderColor),
          color: Colors.white,
        ),
        width: double.infinity,
        child: details);
  }
}
