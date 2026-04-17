import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/gallery_img_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class EventDayDataWidget extends StatelessWidget {
  final List<CourseEventInfo> descriptions;
  final List<String> images;
  final String index;

  const EventDayDataWidget({
    super.key,
    required this.descriptions,
    required this.images,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // elevation: 2,
      // color:  AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...descriptions.map(
              (desc) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Day $index",
                    style: TextStyles.bold2(color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                            desc.name ?? "",
                            style: TextStyles.bold2(color: AppColors.black),
                          )),
                          Row(
                            children: [
                              Icon(Icons.calendar_month_outlined,
                                  color: AppColors.primaryColor, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                desc.date ?? "",
                                style: TextStyles.bold2(color: AppColors.black),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  HtmlWidget(desc.info ?? ""),
                ],
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

 /* Widget _buildInfoRow(String label, String value) {
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
  }*/
}
