import 'package:flutter/material.dart';

class ExperienceAccordionItem extends StatelessWidget {
  final Widget? details;
   final bool? isExpanded;
  // final String title;
  // final String descriptions;
  // final bool isExpanded;
  // final VoidCallback onToggle;
  // final int? count;

  const ExperienceAccordionItem({
    super.key, this.details, this.isExpanded,
    // required this.title,
    // required this.descriptions,
    // required this.isExpanded,
    // required this.onToggle, this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      width: double.infinity,
      child: details
    );
    
  }
}
