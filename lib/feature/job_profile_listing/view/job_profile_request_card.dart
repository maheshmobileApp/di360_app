import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/talents/model/job_profile.dart';
import 'package:di360_flutter/utils/job_time_chip.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class JobProfileRequestCard extends StatelessWidget with BaseContextHelpers {
  final JobProfile jobsListingData;
  final dynamic parmas;
  final int index; 

  const JobProfileRequestCard({
    super.key,
    required this.jobsListingData,
    required this.index,
    this.parmas,
  });

  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(jobsListingData.createdAt ?? '');
    final String? profileImageUrl = jobsListingData.profileImage.isNotEmpty
        ? jobsListingData.profileImage.first.url
        : '';
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
                    jobsListingData.emailAddress ?? '',
                    jobsListingData.mobileNumber ?? '',
                  ),
                ),
                Row(
                  children: [
                    JobTimeChip(time: time),
                    const SizedBox(width: 4),
                    menuWidget(
                      context,
                      index,
                      jobsListingData.id ?? '',
                      jobsListingData.activeStatus ?? '',
                    ),
                  ],
                ),
              ],
            ),
            addVertical(10),
            Row(
              children: [
                _statusChip(jobsListingData.adminStatus ?? ''),
                addHorizontal(10),
              ],
            ),
            addVertical(10),
            const Divider(),
            Row(children: [
              _roundedButton("Message"),
              addHorizontal(10),
              _roundedButton("Enquiry"),
            ])
          ],
        ),
      ),
    );
  }

  Widget _logoWithTitle(
    String imageUrl,
    String name,
    String emial,
    String phonenumber,
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
                style: TextStyles.semiBold(fontSize: 16, color: AppColors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                emial,
                style: TextStyles.regular2(color: AppColors.geryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                phonenumber,
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

  Widget menuWidget(
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
        if (value == "Accept") {
          // TODO
        } else if (value == "Reject") {
          // TODO
        } else if (value == "Preview") {
          // TODO
        }
      },
      itemBuilder: (context) {
        final items = <PopupMenuEntry<String>>[
          PopupMenuItem(
            value: "Preview",
            child: _buildRow(Icons.remove_red_eye, AppColors.black, "Preview"),
          ),
          PopupMenuItem(
            value: "Accept",
            child: _buildRow(Icons.check, AppColors.blueColor, "Accept"),
          ),
          PopupMenuItem(
            value: "Reject",
            child: _buildRow(Icons.cancel, AppColors.redColor, "Reject"),
          ),
        ];
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

  Widget _roundedButton(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFFFF1E5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(label == "Message" ? Icons.chat : Icons.live_help_outlined,
              size: 20, color: AppColors.primaryColor),
          const SizedBox(width: 2),
          Text(label,
              style: TextStyles.medium1(
                  fontSize: 13, color: AppColors.primaryColor)),
        ]),
      );
}
