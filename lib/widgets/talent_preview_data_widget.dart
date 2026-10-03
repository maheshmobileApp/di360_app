import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TalentPreviewDataWidget extends StatelessWidget {
  final String head;
  final String value;

  const TalentPreviewDataWidget({
    super.key,
    required this.head,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            head,style: TextStyles.medium1(color: AppColors.geryColor),
          ),
          const SizedBox(width: 8),
          Text(
            value.toString(),style: TextStyles.medium2(),
          ),
        ],
      ),
    );
  }
}
