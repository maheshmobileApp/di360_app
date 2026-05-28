import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/status_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterCourseCard extends StatelessWidget {
  final VoidCallback? onCardTap;
  final VoidCallback? onViewCourseTap;
  final VoidCallback? onDownloadTap;
  final CoursesListingDetails courseData;

  const RegisterCourseCard(
      {super.key,
      this.onCardTap,
      this.onViewCourseTap,
      this.onDownloadTap,
      required this.courseData});

  @override
  Widget build(BuildContext context) {
    final String time =
        DateFormatUtils.formatTwoDateTime(courseData.createdAt ?? "");
    final courseStatus = courseData.courseRegisteredUsers?.isNotEmpty == true
        ? courseData.courseRegisteredUsers?.first.status ?? ""
        : "";
    final expiryDate = DateFormatUtils.formatDateToDmy(
        courseData.courseRegisteredUsers?.first.courseExpiryAt ?? "");
    final today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final expiryStr =
        courseData.courseRegisteredUsers?.first.courseExpiryAt ?? "";
    DateTime? parsedExpiry;
    try {
      parsedExpiry = expiryStr.isNotEmpty
          ? DateFormat('dd/MM/yyyy').parse(expiryStr)
          : null;
    } catch (_) {}

    final isCourseExpiry = parsedExpiry != null && parsedExpiry.isBefore(today);

    final showViewCourse =
        (courseStatus == "APPROVED" || courseStatus == "COMPLETED") &&
            courseData.type == "Online Academy" &&
            !isCourseExpiry; // expiry is today or after today

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
                courseData.meetingLink ?? "",
                courseStatus,
                expiryDate),
            Divider(color: AppColors.borderColor),
            Row(
              mainAxisAlignment: (courseStatus == "COMPLETED")
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                if (courseStatus == "COMPLETED")
                  GestureDetector(
                    onTap: onDownloadTap,
                    child: Row(
                      children: [
                        _courseStatusWidget("Download Certificate"),
                      ],
                    ),
                  ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: onCardTap,
                      child: Row(
                        children: [
                          Text("View Details",
                              style: TextStyles.medium2(
                                  color: AppColors.primaryColor)),
                          SvgPicture.asset(
                            ImageConst.nextArrow,
                            width: 26,
                            height: 26,
                          ),
                        ],
                      ),
                    ),
                    if (showViewCourse)
                      GestureDetector(
                        onTap: onViewCourseTap,
                        child: Row(
                          children: [
                            Text("View Course",
                                style: TextStyles.medium2(
                                    color: AppColors.primaryColor)),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.visibility,
                              size: 24,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoWithTitle(
      String profilePic,
      String company,
      String title,
      String status,
      String types,
      String link,
      String courseStatus,
      String expiryDate) {
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
                    fit: BoxFit.cover,
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
                  style: TextStyles.regular2(color: AppColors.black)),
              const SizedBox(height: 2),
              Text("CPD Points: ${courseData.cpdPoints ?? ""}",
                  style: TextStyles.regular2(color: AppColors.black)),
              const SizedBox(height: 2),
              if (expiryDate.isNotEmpty)
                Text("Expires on: $expiryDate",
                    style: TextStyles.regular2(color: AppColors.black)),
              const SizedBox(height: 2),
              Row(
                children: [
                  _chipWidget(types),
                  const SizedBox(width: 4),
                  _courseStatusWidget(courseStatus),
                ],
              ),
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
            color: AppColors.black,
            fontSize: 12,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _courseStatusWidget(String status) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(229, 244, 237, 1),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.whiteColor, width: 1),
        ),
        child: Text(
          status,
          style: TextStyles.bold4(
            color: StatusColors.getColor(status),
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Widget courseStatusWidget({
    required String status,
    required Color color,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: color,
            ),
            const SizedBox(width: 5),
          ],
          Flexible(
            child: Text(
              status,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.medium1(
                color: color,
                fontSize: 12,
              ).copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
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
        "Posted on : $time",
        textAlign: TextAlign.right,
        style: TextStyles.semiBold(
            fontSize: 10, color: Color.fromRGBO(255, 112, 0, 1)),
      ),
    );
  }

  // String? _getShortTime(String createdAt) {
  //   try {
  //     return Jiffy.parse(createdAt).fromNow();
  //   } catch (_) {
  //     return '';
  //   }
  // }
}
