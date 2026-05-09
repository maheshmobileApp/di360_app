import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterCourseCard extends StatelessWidget {
  final VoidCallback? onCardTap;
  final CoursesListingDetails courseData;

  const RegisterCourseCard({
    super.key,
    this.onCardTap,
    required this.courseData,
  });

  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(courseData.createdAt ?? "") ?? '';

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.borderColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _jobTimeChip(time),
              ],
            ),
            _logoWithTitle(
                courseData.presenters?.first.presentedByImage?.url ?? "",
                courseData.courseName ?? "",
                courseData.presenters?.first.presentedByName ?? "",
                courseData.status ?? "",
                courseData.type ?? "",
                courseData.meetingLink ?? ""),
            GestureDetector(
              onTap: onCardTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("View Details",
                      style: TextStyles.medium2(color: AppColors.primaryColor)),
                  SvgPicture.asset(
                    ImageConst.nextArrow,
                    width: 26,
                    height: 26,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoWithTitle(String profilePic, String company, String title,
      String status, String types, String link) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.geryColor,
              radius: 25,
              child: ClipOval(
                child: CachedNetworkImageWidget(
                    width: 50,
                    height: 50,
                    imageUrl: profilePic,
                    fit: BoxFit.fill,
                    errorWidget: Image.asset(ImageConst.prfImg)),
              ),
            ),
          ],
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(company,
                  maxLines: 2, style: TextStyles.bold2(color: AppColors.black)),
              const SizedBox(height: 2),
              Text(title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.regular2(
                    color: AppColors.black,
                  )),
              const SizedBox(height: 2),
              Text("CPD Points: ${courseData.cpdPoints ?? ""}",
                  style: TextStyles.regular2(color: AppColors.black)),
              const SizedBox(height: 2),
              _chipWidget(types),
              const SizedBox(height: 4),
              if (link.isNotEmpty) _meetingLinkWidget(link)
            ],
          ),
        ),
      ],
    );
  }

  Widget _meetingLinkWidget(String link) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.borderColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: GestureDetector(
          onTap: () async {
            final url = Uri.parse(link);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {}
          },
          child: Text(
            "Meeting Link",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.regular1(
              color: AppColors.bottomNavUnSelectedColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _chipWidget(String types) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 21,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.secondaryBlueColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          types,
          style: TextStyles.regular1(
            color: AppColors.primaryBlueColor,
            fontSize: 12,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _jobTimeChip(String time) {
    return Container(
      height: 19,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(255, 241, 229, 0),
            Color.fromRGBO(255, 241, 229, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        time,
        textAlign: TextAlign.right,
        style: TextStyles.semiBold(
            fontSize: 10, color: Color.fromRGBO(255, 112, 0, 1)),
      ),
    );
  }

  String? _getShortTime(String createdAt) {
    try {
      return Jiffy.parse(createdAt).fromNow();
    } catch (_) {
      return '';
    }
  }
}
