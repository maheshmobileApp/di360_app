import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FilterSection extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Widget? trailing;
  final bool initiallyExpanded;

  const FilterSection({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.trailing,
    this.initiallyExpanded = false,
  });

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  late bool expanded;

  @override
  void initState() {
    super.initState();
    expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() => expanded = !expanded);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 22,
              ),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    size: 18,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: expanded
                            ? AppColors.primaryColor
                            : AppColors.black,
                      ),
                    ),
                  ),
                  if (widget.trailing != null) ...[
                    widget.trailing!,
                    const SizedBox(width: 10),
                  ],
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.black,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (expanded) widget.child,
          const Divider(
            height: 1,
            color: Color(0xFFECEEF2),
          ),
        ],
      ),
    );
  }
}