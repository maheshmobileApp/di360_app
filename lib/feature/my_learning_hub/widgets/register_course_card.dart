import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterCourseCard extends StatelessWidget {
  final String logo;
  final String courseName;
  final String cpdPoints;
  final String name;
  final String status;
  final String types;
  final String link;

  final String createdAt;

  /// Callbacks (parent view passes these)
  final VoidCallback? onCardTap;
  final VoidCallback? onPreviewTap;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;
  final VoidCallback? onActivateTap;
  final VoidCallback? onDeactivateTap;

  const RegisterCourseCard({
    super.key,
    required this.logo,
    required this.courseName,
    required this.name,
    required this.status,
    required this.types,
    required this.link,
    required this.createdAt,
    this.onCardTap,
    this.onPreviewTap,
    this.onEditTap,
    this.onDeleteTap,
    this.onActivateTap,
    this.onDeactivateTap,
    required this.cpdPoints,
  });

  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(createdAt) ?? '';

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
                logo, courseName, name, status, types, link),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: onCardTap,
                  child: SvgPicture.asset(
                    ImageConst.nextArrow,
                    width: 26,
                    height: 26,
                  ),
                ),
              ],
            ),

            // right column
            /* SizedBox(
              // 👈 ensures column takes available vertical space
              height: 120, // or double.infinity if inside flexible parent
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // 👈 pushes apart
                crossAxisAlignment: CrossAxisAlignment.end, // 👈 right aligned
                children: [
                  _jobTimeChip(time),
                  GestureDetector(
                    onTap: onCardTap,
                    child: SvgPicture.asset(
                      ImageConst.nextArrow,
                      width: 26,
                      height: 26,
                    ),
                  ),
                ],
              ),
            ),*/
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
              backgroundImage:
                  profilePic.isNotEmpty ? NetworkImage(profilePic) : null,
              radius: 30,
              child: profilePic.isEmpty
                  ? const Icon(Icons.person,
                      size: 20, color: AppColors.lightGeryColor)
                  : null,
            ),
          ],
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(company,
                maxLines: 2, style: TextStyles.bold2(color: AppColors.black)),
            const SizedBox(height: 2),
            Text(title, style: TextStyles.regular2(color: AppColors.black)),
            const SizedBox(height: 2),
            Text("CPD Points: ${cpdPoints}",
                style: TextStyles.regular2(color: AppColors.black)),
            const SizedBox(height: 2),
            _chipWidget(types),
            const SizedBox(height: 4),
            if (link.isNotEmpty) _meetingLinkWidget(link)
          ],
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
            } else {
              // Handle if the URL can't be launched
              debugPrint('Could not launch $url');
            }
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
    return Container(
      height: 21,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.secondaryBlueColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
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

  Widget _menuWidget(String status) {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      onSelected: (value) {
        switch (value) {
          case "Preview":
            onPreviewTap?.call();
            break;
          case "Edit":
            onEditTap?.call();
            break;
          case "Delete":
            onDeleteTap?.call();
            break;
          case "Active":
            onActivateTap?.call();
            break;
          case "Inactive":
            onDeactivateTap?.call();
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "Preview",
          child: _buildRow(Icons.remove_red_eye, AppColors.black, "Preview"),
        ),
        PopupMenuItem(
          value: "Edit",
          child: _buildRow(Icons.edit_outlined, AppColors.blueColor, "Edit"),
        ),
        PopupMenuItem(
          value: "Delete",
          child: _buildRow(Icons.delete_outline, AppColors.redColor, "Delete"),
        ),
        if (status == "APPROVE")
          PopupMenuItem(
            value: "Inactive",
            child: _buildRow(
                Icons.nightlight_outlined, AppColors.primaryColor, "Inactive"),
          ),
        if (status == "REJECT")
          PopupMenuItem(
            value: "Active",
            child: _buildRow(
                Icons.nightlight_outlined, AppColors.primaryColor, "Active"),
          ),
      ],
    );
  }

  Widget _buildRow(IconData? icon, Color? color, String? title) {
    return Row(children: [
      Icon(icon, color: color),
      const SizedBox(width: 8),
      Text(title ?? '', style: TextStyles.semiBold(fontSize: 14, color: color)),
    ]);
  }

  String? _getShortTime(String createdAt) {
    try {
      return Jiffy.parse(createdAt).fromNow();
    } catch (_) {
      return '';
    }
  }
}
