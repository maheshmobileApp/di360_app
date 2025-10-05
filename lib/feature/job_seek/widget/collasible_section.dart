import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class CollapsibleSection extends StatefulWidget {
  final String title;
  final Widget child;

  const CollapsibleSection({
    required this.title,
    required this.child,
  });

  @override
  State<CollapsibleSection> createState() => CollapsibleSectionState();
}

class CollapsibleSectionState extends State<CollapsibleSection> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          minTileHeight: 30,
          title: Text(
            widget.title,
            style: TextStyles.regular3(color: AppColors.black),
          ),
          trailing: InkWell(
            child: Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: AppColors.black,
            ),
            onTap: () => setState(() => _isExpanded = !_isExpanded),
          ),
        ),
        if (_isExpanded) widget.child,
        const SizedBox(height: 10),
      ],
    );
  }
}