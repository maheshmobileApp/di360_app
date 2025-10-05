import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/gallery_img_widget.dart';
import 'package:flutter/material.dart';

class EventDayDataWidget extends StatelessWidget {
  final String title;
  final List<CourseEventInfo> descriptions;
   final List<String> images;

  const EventDayDataWidget({
    super.key,
    required this.title,
    required this.descriptions, required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // elevation: 2,
      // color:  AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
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
                    _buildInfoRow("Session Name", desc.name ?? ""),
                    const SizedBox(height: 6),
                    _buildInfoRow("Session Date", desc.date ?? ""),
                    const SizedBox(height: 6),
                    _buildInfoRow("Session Info", desc.info ?? ""),
                  ],
                ),
              ),
            ),
            GalleryImgWidget(
              imageUrls: images,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label : ",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500, // label bold
              color: AppColors.primaryColor,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400, // value normal
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
