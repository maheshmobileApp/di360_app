import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../feature/job_profile/model/job_education.dart';

class EducationDataWithIcon extends StatelessWidget {
  final String iconPath;
  final String title;
  final List<Education> educationList;

  const EducationDataWithIcon({
    super.key,
    required this.iconPath,
    required this.title,
    required this.educationList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(
                  Colors.blueGrey,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyles.bold2(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (educationList.isEmpty)
            const Text(
              'No education details available',
              style: TextStyle(color: Colors.grey),
            )
          else
            Column(
              children: educationList.map((edu) {
                String? dateInfo;
                if (edu.finishDate != null && edu.finishDate!.isNotEmpty) {
                  dateInfo = 'Finished: ${edu.finishDate}';
                } else if (edu.expectedFinishDate != null &&
                    edu.expectedFinishDate!.isNotEmpty) {
                  dateInfo = 'Expected Finish: ${edu.expectedFinishDate}';
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (edu.qualification.isNotEmpty)
                        Text(
                          edu.qualification,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      if (edu.institution.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          'At ${edu.institution}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                      if (dateInfo != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          dateInfo,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                      if (edu.courseHighlights.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Highlights: ${edu.courseHighlights}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
