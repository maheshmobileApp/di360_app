import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomChipView extends StatelessWidget {
  final String? label;
  final List<dynamic> typesList;
  const CustomChipView({
    super.key,
    this.label,
    required this.typesList,
  });
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 1,
      runSpacing: 2,
      children: typesList.map<Widget>((type) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppColors.secondaryBlueColor,
              borderRadius: BorderRadius.circular(16), // Adjust radius here
            ),
            child: Text(
              "${type?.toString() == 'null' ? 'N/A' : type?.toString()}",
              style: TextStyle(color: AppColors.primaryBlueColor),
            ),
          ),
        );
      }).toList(),
    );
  }
}
