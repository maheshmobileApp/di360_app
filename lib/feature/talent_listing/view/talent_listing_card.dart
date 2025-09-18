import 'package:cached_network_image/cached_network_image.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/talent_listing/view_model/talent_listing_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import '../../talents/model/job_profile.dart';

class TalentListingCard extends StatelessWidget with BaseContextHelpers {
  final JobProfile? jobProfiles;
  final TalentListingViewModel vm;
  final int? index;

  const TalentListingCard({
    super.key,
    required this.jobProfiles,
    required this.vm,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(jobProfiles?.createdAt ?? '') ?? '';
    final String? profileImageUrl =
        (jobProfiles?.profileImage.isNotEmpty == true)
            ? jobProfiles!.profileImage.first.url
            : null;
          
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
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
                    jobProfiles?.fullName ?? '',
                    jobProfiles?.professionType ?? '',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _statusChip(jobProfiles?.adminStatus ?? ''),
                        addHorizontal(4),
                        _TalentMenu(jobProfiles?.adminStatus ?? ''),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            addVertical(8),
            Row(
              children: [
                Flexible(child: _chipWidget(jobProfiles?.workType ?? [])),
                const SizedBox(width: 200),
                _TalentTimeChip(time),
              ],
            ),
            addVertical(10),
            const Divider(),
            Row(
              children: [
               InkWell(
                  onTap: () async {
                    final profileId = jobProfiles?.id;
                    final jobId = jobProfiles?.jobDesignation;
                    if (profileId == null || jobId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Talent or Job ID not available"),
                        ),
                      );
                      return;
                    }
                    final userId = await LocalStorage.getStringVal(
                        LocalStorageConst.userId);
                    navigationService.navigateToWithParams(
                      RouteList.JobListingApplicantsMessege,
                      params: {
                        "jobId": jobId,
                        "applicantId": profileId,
                        "userId": userId,
                      },
                    );
                  },
                  child: _roundedButton("Message"),
                ),
                addHorizontal(10),
                _roundedButton("Enquiry"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoWithTitle(
      BuildContext context, String? imageUrl, String title, String role) {
    Widget avatarChild;
    if (imageUrl != null &&
        imageUrl.isNotEmpty &&
        Uri.tryParse(imageUrl)?.hasAbsolutePath == true) {
      avatarChild = CachedNetworkImage(
        imageUrl: imageUrl,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        placeholder: (_, __) => const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2)),
        errorWidget: (_, __, ___) => const Icon(Icons.error),
      );
    } else {
      avatarChild = const Icon(Icons.person, size: 30);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[200],
          child: ClipOval(child: avatarChild),
        ),
        addHorizontal(6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: getSize(context).width * 0.5,
              child: Text(title,
                  style:
                      TextStyles.semiBold(fontSize: 16, color: AppColors.black),
                  overflow: TextOverflow.ellipsis),
            ),
            addVertical(4),
            SizedBox(
              width: getSize(context).width * 0.5,
              child: Text(role,
                  style: TextStyles.regular2(color: AppColors.black),
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ],
    );
  }

  Widget _chipWidget(List<String> types) {
    if (types.isEmpty) return const SizedBox();
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: types
          .where((type) => type.isNotEmpty)
          .map((type) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBlueColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(type,
                    style: TextStyles.regular1(
                        fontSize: 12, color: AppColors.primaryBlueColor)),
              ))
          .toList(),
    );
  }

  Widget _statusChip(String adminStatus) {
    final status = adminStatus.toLowerCase();
    Color bgColor;
    Color textColor;
    switch (status) {
      case "pending":
        bgColor = const Color.fromRGBO(225, 146, 0, 0.1);
        textColor = const Color.fromRGBO(225, 146, 0, 1);
        break;
      case "approve":
        bgColor = const Color.fromRGBO(0, 147, 79, 0.1);
        textColor = const Color.fromRGBO(0, 147, 79, 1);
        break;
      case "rejected":
      case "reject":
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

  Widget _TalentTimeChip(String time) => Container(
        height: 19,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(116, 130, 148, 0.0),
            Color.fromRGBO(116, 130, 148, 0.2)
          ]),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.centerRight,
        child: Text(time.isEmpty ? '-' : time,
            style: TextStyles.semiBold(
                fontSize: 10, color: const Color(0xFF1E1E1E))),
      );

  String? _getShortTime(String createdAt) {
    if (createdAt.isEmpty) return null;
    try {
      return Jiffy.parse(createdAt).fromNow();
    } catch (_) {
      return null;
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

  Widget _TalentMenu(String adminStatus) {
    return PopupMenuButton<String>(
      iconColor: Colors.grey,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (value) {
        if (value == "Preview") {
          navigationService.navigateToWithParams(
            RouteList.talentdetailsScreen,
            params: jobProfiles,
          );
        } else if (value == "Cancel") {}
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "Preview",
          child: _buildRow(Icons.remove_red_eye, AppColors.black, "Preview"),
        ),
        PopupMenuItem(
          value: "Cancel",
          child: _buildRow(Icons.cancel, AppColors.redColor, "Delete"),
        ),
      ],
    );
  }

  Widget _buildRow(IconData icon, Color color, String title) => Row(children: [
        Icon(icon, color: color, size: 18),
        addHorizontal(8),
        Text(title, style: TextStyles.semiBold(fontSize: 14, color: color))
      ]);
}
