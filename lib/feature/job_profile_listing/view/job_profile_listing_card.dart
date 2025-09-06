import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_listing_respo.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_listing_view_model.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class JobProfileListingCard extends StatelessWidget with BaseContextHelpers {
  final JobProfileListing jobsListingData; // ✅ Non-nullable
  final JobProfileListingViewModel vm;
  final dynamic parmas;
  final int? index;

  const JobProfileListingCard({
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
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              border: Border(
                left: BorderSide(
                    color: Color.fromRGBO(220, 224, 228, 1), width: 1),
                right: BorderSide(
                    color: Color.fromRGBO(220, 224, 228, 1), width: 1),
                top: BorderSide(
                    color: Color.fromRGBO(220, 224, 228, 1), width: 1),
              ),
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
                        dentalProfessional?.professionType ?? '',
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
                 addVertical(12),
                _descriptionWidget("about your self"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoWithTitle(
    BuildContext context,
    String imageUrl,
    String name,
    String professionType,
    String designation,
    String companyName,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
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
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.error),
                      ),
                    ),
                  )
                : const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey,
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
                professionType,
                style: TextStyles.regular2(color: AppColors.geryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                designation,
                style: TextStyles.regular2(color: AppColors.lightGeryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                companyName,
                style: TextStyles.regular2(color: AppColors.lightGeryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _descriptionWidget(String description) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        description,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.regular1(color: AppColors.bottomNavUnSelectedColor),
      ),
    );
  }

  Widget _chipWidget(List<String> types) {
    if (types.isEmpty) return const SizedBox();
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: types.map((type) {
        final label = type.trim().isEmpty ? '' : type;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.secondaryBlueColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            style: TextStyles.regular1(
              fontSize: 12,
              color: AppColors.primaryBlueColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
            Color.fromRGBO(255, 241, 229, 0),
            Color.fromRGBO(255, 241, 229, 1),
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
          color: Color.fromRGBO(255, 112, 0, 1),
        ),
      ),
    );
  }

  Widget menuWidget(String status) {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      onSelected: (value) {
        // Handle actions
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
        bgColor = const Color.fromRGBO(4, 113, 222, 0.1);
        textColor = const Color.fromRGBO(4, 113, 222, 1);
        break;
      case "PENDING":
        bgColor = const Color.fromRGBO(225, 146, 0, 0.1);
        textColor = const Color.fromRGBO(225, 146, 0, 1);
        break;
      case "ACTIVE":
        bgColor = const Color.fromRGBO(0, 147, 79, 0.1);
        textColor = const Color.fromRGBO(0, 147, 79, 1);
        break;
      case "INACTIVE":
        bgColor = const Color.fromRGBO(215, 19, 19, 0.1);
        textColor = const Color.fromRGBO(215, 19, 19, 1);
        break;
      case "REJECTED":
        bgColor = const Color.fromRGBO(215, 19, 19, 0.1);
        textColor = const Color.fromRGBO(215, 19, 19, 1);
        break;
      default:
        bgColor = const Color.fromRGBO(253, 245, 229, 1);
        textColor = const Color.fromRGBO(225, 146, 0, 1);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(30)),
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
