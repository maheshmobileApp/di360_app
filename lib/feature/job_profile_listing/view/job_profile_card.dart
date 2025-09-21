import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/feature/talents/model/job_profile.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/job_time_chip.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';


class JobProfileCard extends StatelessWidget with BaseContextHelpers {
  final JobProfile jobsListingData;
  final JobProfileListingViewModel vm;
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
    final String time = _getShortTime(jobsListingData.createdAt ?? '');
    final String? profileImageUrl = jobsListingData.profileImage.isNotEmpty
        ? jobsListingData.profileImage.first.url
        : '';
    final List<String> workTypes = jobsListingData.workType;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color.fromRGBO(220, 224, 228, 1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _logoWithTitle(
                    profileImageUrl ?? "",
                    jobsListingData.fullName ?? '',
                    jobsListingData.jobDesignation ?? '',
                    jobsListingData.currentCompany ?? '',
                  ),
                ),
                Row(
                  children: [
                    JobTimeChip(time: time),
                    const SizedBox(width: 4),
                    menuWidget(
                      vm,
                      context,
                      index!,
                      jobsListingData.id ?? '',
                      jobsListingData.activeStatus ?? '',
                    ),
                  ],
                ),
              ],
            ),
            addVertical(12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _chipWidget(workTypes)),
                addHorizontal( 8),
                _statusChip(jobsListingData.adminStatus ?? ''),
              ],
            ),
            addVertical(10),
            _descriptionWidget(jobsListingData.aboutYourself ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _logoWithTitle(
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
          addHorizontal( 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyles.semiBold(fontSize: 16, color: AppColors.black),
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
                style:
                    TextStyles.regular1(color: AppColors.lightGeryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
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

  Widget _descriptionWidget(String description) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        description.isNotEmpty ? description : '',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.regular1(
          color: AppColors.bottomNavUnSelectedColor,
        ),
      ),
    );
  }

  

  Widget menuWidget(
    JobProfileListingViewModel vm,
    BuildContext context,
    int index,
    String id,
    String activeStatus,
  ) {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      onSelected: (value) {
        if (value == "Delete") {
          showAlertMessage(context, 'Are you sure you want to delete this job?',
              onBack: () {
            navigationService.goBack();
            vm.removeJobsProfileData(context);
          });
        } else if (value == "Active") {
          showAlertMessage(
            context,
            'Do you really want to activate this job?',
            onBack: () {
              navigationService.goBack();
              vm.updateJobProfileStatus(context, id, "ACTIVE");
            },
          );
        } else if (value == "Inactive") {
          showAlertMessage(
            context,
            'Do you really want to deactivate this job?',
            onBack: () {
              navigationService.goBack();
              vm.updateJobProfileStatus(context, id, "INACTIVE");
            },
          );
        } else if (value == "Preview") {
          navigationService.navigateToWithParams(
            RouteList.talentdetailsScreen,
            params: jobsListingData,
          );
        }
      },
      itemBuilder: (context) {
        final items = <PopupMenuEntry<String>>[
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
        ];
        if (activeStatus.toUpperCase() == "ACTIVE") {
          items.add(PopupMenuItem(
            value: "Inactive",
            child: _buildRow(
                Icons.nightlight_outlined, AppColors.primaryColor, "Inactive"),
          ));
        } else if (activeStatus.toUpperCase() == "INACTIVE") {
          items.add(PopupMenuItem(
            value: "Active",
            child: _buildRow(
                Icons.wb_sunny_outlined, AppColors.primaryColor, "Active"),
          ));
        }
        return items;
      },
    );
  }

  Widget _buildRow(IconData icon, Color color, String title) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(
          title,
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

  String _getShortTime(String? createdAt) {
    if (createdAt == null || createdAt.isEmpty) return '';
    try {
      return Jiffy.parse(createdAt).fromNow();
    } catch (_) {
      return '';
    }
  }
}
