import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listings_model.dart';
import 'package:di360_flutter/feature/talent_listing/view_model/talent_listing_view_model.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class TalentListingCard extends StatelessWidget with BaseContextHelpers {
  final JobProfiles? jobProfiles;
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
                    (jobProfiles?.profileImage?.isNotEmpty ?? false)
                        ? jobProfiles!.profileImage!.first.url ?? ''
                        : '',
                    jobProfiles?.jobDesignation ?? '',
                    jobProfiles?.professionType ?? '',
                    jobProfiles?.currentCompany ?? '',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _chipWidget(jobProfiles?.workType ?? []),
                ),
                _TalentTimeChip(time),
              ],
            ),
            addVertical(10),
            const Divider(),
            Row(
              children: [
                _roundedButton("Message"),
                addHorizontal(15),
                _roundedButton("Enquiry"),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios,
                    color: AppColors.primaryColor, size: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoWithTitle(BuildContext context, String imageUrl, String title,
      String role, String companyName) {
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
                title,
                style:
                    TextStyles.semiBold(fontSize: 16, color: AppColors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                role,
                style: TextStyles.regular2(color: AppColors.geryColor),
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
      color: bgColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      adminStatus, 
      style: TextStyles.semiBold(fontSize: 12, color: textColor),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

  Widget _TalentTimeChip(String time) {
    return Container(
      height: 19,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(116, 130, 148, 0.0),
            Color.fromRGBO(116, 130, 148, 0.2),
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
          color: const Color(0xFF1E1E1E),
        ),
      ),
    );
  }

  String? _getShortTime(String createdAt) {
    if (createdAt.isEmpty) return null;
    return Jiffy.parse(createdAt).fromNow();
  }

  Widget _roundedButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1E5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            label == "Message" ? Icons.chat : Icons.live_help_outlined,
            size: 20,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 2),
          Text(
            label,
            style: TextStyles.medium1(
              fontSize: 13,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

   Widget  _TalentMenu(String adminStatus) {
  final status = adminStatus.toLowerCase();

  return PopupMenuButton<String>(
    iconColor: AppColors.bottomNavUnSelectedColor,
    color: AppColors.whiteColor,
    padding: EdgeInsets.zero,
    onSelected: (value) {
      if (value == "Preview") {
    
      } else if (value == "Approve") {
       
      } else if (value == "Rejected") {
      
      } else if (value == "Pending") {

      }
    },
    itemBuilder: (context) {
      List<PopupMenuEntry<String>> items = [];
      items.add(
        PopupMenuItem(
          value: "Preview",
          child: _buildRow(Icons.remove_red_eye, AppColors.black, "Preview"),
        ),
      );

      if (status == "pending") {
        items.addAll([
          PopupMenuItem(
            value: "Approve",
            child: _buildRow(Icons.check_circle, AppColors.greenColor, "Approve"),
          ),
          PopupMenuItem(
            value: "Rejected",
            child: _buildRow(Icons.cancel, AppColors.redColor, "Rejected"),
          ),
        ]);
      } else if (status == "approve") {
        items.add(
          PopupMenuItem(
            value: "Rejected",
            child: _buildRow(Icons.cancel, AppColors.redColor, "Rejected"),
          ),
        );
      } else if (status == "rejected") {
        items.add(
          PopupMenuItem(
            value: "Approve",
            child: _buildRow(Icons.check_circle, AppColors.greenColor, "Approve"),
          ),
        );
      }

      return items;
    },
  );
}

Widget _buildRow(IconData icon, Color color, String title) {
  return Row(
    children: [
      Icon(icon, color: color, size: 18),
      addHorizontal(8),
      Text(title, style: TextStyles.semiBold(fontSize: 14, color: color)),
    ],
  );
}

}
