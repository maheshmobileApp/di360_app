import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_respo.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class JobProfileCard extends StatelessWidget with BaseContextHelpers {
  final JobProfileListing jobsListingData;
  final JobProfileViewModel vm;
  final dynamic parmas;
  final int? index;

  const JobProfileCard({
    super.key,
    required this.jobsListingData,
    required this.vm,
    this.index,
    this.parmas,
  });

  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(jobsListingData.createdAt ?? '') ?? '';
    final String profileImageUrl = (jobsListingData.profileImage != null &&
            jobsListingData.profileImage!.isNotEmpty)
        ? (jobsListingData.profileImage!.first.url ?? "")
        : "";
    final dentalProfessional = jobsListingData.dentalProfessional;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.greysecond, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _logoWithTitle(
                    context,
                    profileImageUrl,
                    dentalProfessional?.name ?? '',
                    jobsListingData.jobDesignation ?? '',
                    jobsListingData.currentCompany ?? '',
                  ),
                ),
                Row(
                  children: [
                    _jobProfileTimeChip(time),
                    addHorizontal(4),
                    menuWidget(jobsListingData.adminStatus ?? ''),
                  ],
                ),
              ],
            ),
            addVertical(12),
            Row(
              children: [
                 _chipWidget(jobsListingData.workType ?? []),
              addHorizontal(8),
                _statusChip(jobsListingData.adminStatus ?? ''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoWithTitle(
    BuildContext context,
    String imageUrl,
    String name,
    String designation,
    String companyName,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.geryColor,
          radius: 24,
          child: CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.whiteColor,
            child: (imageUrl.isNotEmpty)
                ? ClipOval(
                    child: CachedNetworkImageWidget(
                      width: 48,
                      height: 48,
                      imageUrl: imageUrl,
                      errorWidget: const CircleAvatar(
                        backgroundColor: AppColors.geryColor,
                        child: Icon(Icons.error),
                      ),
                    ),
                  )
                : const CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.geryColor,
                  ),
          ),
        ),
        addHorizontal(6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style:
                    TextStyles.semiBold(fontSize: 16, color: AppColors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                designation,
                style: TextStyles.regular2(color: AppColors.geryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                companyName,
                style: TextStyles.regular1(color: AppColors.lightGeryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chipWidget(List<dynamic> types) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: types.map((type) {
        final label = type?.toString() == 'null' ? 'N/A' : type.toString();
        return Container(
          height: 21,
          width: 71,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.secondaryBlueColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyles.regular1(
                color: AppColors.primaryBlueColor,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _jobProfileTimeChip(String time) {
    return Container(
      height: 19,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.timeblack,
            AppColors.timewhite,
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.centerRight,
      child: Text(
        time,
        textAlign: TextAlign.right,
        style: TextStyles.semiBold(
          fontSize: 10,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget menuWidget(String status) {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      onSelected: (value) {},
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
        if (status == "APPROVE" || status == "PendingApproval")
          PopupMenuItem(
            value: "Inactive",
            child: _buildRow(
                Icons.nightlight_outlined, AppColors.primaryColor, "Inactive"),
          ),
        if (status == "REJECT")
          PopupMenuItem(
            value: "Active",
            child: _buildRow(
                Icons.wb_sunny_outlined, AppColors.primaryColor, "Active"),
          ),
      ],
    );
  }

  Widget _buildRow(IconData? icon, Color? color, String? title) {
    return Row(
      children: [
        Icon(icon, color: color),
        addHorizontal(8),
        Text(
          title ?? '',
          style: TextStyles.semiBold(fontSize: 14, color: color),
        ),
      ],
    );
  }

  Widget _statusChip(String status) {
    Color bgColor;
    Color textColor;
    switch (status.toUpperCase()) {
      case "DRAFT":
        bgColor = AppColors.secondaryBlueColor;
        textColor = AppColors.primaryBlueColor;
        break;
      case "PENDING":
        bgColor = AppColors.pendingprimary;
        textColor = AppColors.pendingsendary;
        break;
      case "ACTIVE":
        bgColor = AppColors.activeprimary;
        textColor = AppColors.activesendary;
        break;
      case "INACTIVE":
        bgColor = AppColors.inactiveprimary;
        textColor = AppColors.inactivesendary;
        break;
      case "REJECTED":
        bgColor = AppColors.inactiveprimary;
        textColor = AppColors.inactivesendary;
        break;
      default:
        bgColor = AppColors.whiteColor;
        textColor = AppColors.pendingsendary;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: TextStyles.semiBold(fontSize: 12, color: textColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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
