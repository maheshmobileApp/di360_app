import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/feature/job_profile_listing/widget/availibility_caleder_card.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/job_time_chip.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class JobProfileCard extends StatelessWidget with BaseContextHelpers {
  final JobProfiles jobsListingData;
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
    String resolveAvailabilityType(dynamic jobProfile) {
      final raw = (jobProfile?.availabilityType ?? '').toString().toLowerCase();
      if (['days', 'dates', 'both'].contains(raw)) return raw;
      final hasDates =
          (jobProfile?.availabilityDate as List?)?.isNotEmpty == true;
      final hasDays =
          (jobProfile?.availabilityDay as List?)?.isNotEmpty == true;
      if (hasDates && hasDays) return 'both';
      if (hasDates) return 'dates';
      if (hasDays) return 'days';
      return 'none';
    }

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
                  ],
                ),
                addVertical(10),
                Row(
                  children: [
                    _statusChip(jobsListingData.adminStatus ?? ''),
                    addHorizontal(10),
                    availabilityChip(
                      label: 'Availability',
                      onTap: () => _showAvailabilityOptions(context, resolveAvailabilityType(jobsListingData)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              navigationService.navigateToWithParams(
                RouteList.MyJobProfileScreen,
                params: jobsListingData,
              );
              
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(116, 130, 148, 0.15),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "${jobsListingData.jobHirings.length} requests, "
                  "${jobsListingData.talentEnquiries?.length ?? 0} enquiry for this job profile",
                  style: TextStyles.medium1(color: AppColors.black),
                ),
              ),
            ),
          )
        ],
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
              onBack: () async {
            await vm.removeJobsProfileData(context, jobProfileId: id);
            navigationService.goBack();
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
        } else if (value == "Edit") {
          final profileData = vm.allJobProfiles.first;
          print("Edit preload data: $profileData");
          vm.setEditProfileEnable(true);
          navigationService
              .navigateToWithParams(RouteList.JobProfileView, params: {
            "profileData": profileData,
            "isEdit": true,
          });
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
            child:
                _buildRow(Icons.delete_outline, AppColors.redColor, "Delete"),
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

  void _showAvailabilityOptions(BuildContext context, String availabilityType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Availability Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today, color: AppColors.primaryColor),
              title: const Text('Availability'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AvailabilityCalendarDialog(
                    availabilityType: availabilityType,
                    availabilityDays: (jobsListingData.availabilityDay as List?)
                            ?.map((e) => e?.toString() ?? '')
                            .where((s) => s.isNotEmpty)
                            .toList() ?? <String>[],
                    availabilityDates: (jobsListingData.availabilityDate as List?)
                            ?.map((e) => e?.toString() ?? '')
                            .where((s) => s.isNotEmpty)
                            .toList() ?? <String>[],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_calendar, color: Color(0xFF2E7D32)),
              title: const Text('Update Availability'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement update availability functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.event_busy, color: Color(0xFFD32F2F)),
              title: const Text('Update Unavailability'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement update unavailability functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget availabilityChip({
    required String label,
    Color backgroundColor = const Color(0xFFFFF1E5),
    Color textColor = AppColors.primaryColor,
    double fontSize = 13,
    double height = 30,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 8),
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today, size: 20, color: AppColors.primaryColor),
            const SizedBox(width: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
