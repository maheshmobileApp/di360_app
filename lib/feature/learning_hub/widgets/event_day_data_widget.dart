import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:flutter/material.dart';

class EventDayDataWidget extends StatelessWidget {
  final String title;
  final List<CourseEventInfo> descriptions;

  const EventDayDataWidget({
    super.key,
    required this.title,
    required this.descriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.bold2(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 8),
        ...descriptions.map(
          (desc) => Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow("Name", desc.name ?? ""),
                const SizedBox(height: 6),
                _buildInfoRow("Date", desc.date ?? ""),
                const SizedBox(height: 6),
                _buildInfoRow("Info", desc.info ?? ""),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold, // label bold
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal, // value normal
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
