import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listings_model.dart';
import 'package:di360_flutter/feature/talent_listing/view_model/talent_listing_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class TalentListingCard extends StatelessWidget with BaseContextHelpers {
  final TalentListingProfiles? jobProfiles;
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

    final ImageProvider image =
        (jobProfiles?.profileImage != null && jobProfiles!.profileImage!.isNotEmpty)
            ? NetworkImage(jobProfiles!.profileImage!.first.toString())
            : const AssetImage("assets/pngs/avatar_placeholder.png");

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
                    image,
                    jobProfiles?.fullName ?? '',
                    jobProfiles?.jobDesignation?.toString() ?? '',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        _statusChip(jobProfiles?.adminStatus ?? ''),
                        addHorizontal(4),
                        _TalentMenu(),
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
                  child: _WorkTypes(jobProfiles?.workType?.toString() ?? ''),
                ),
                _TalentTimeChip(time),
              ],
            ),
            addVertical(6),
            _descriptionWidget(
              jobProfiles?.aboutYourself?.toString() ??
                  "No description available.",
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

  Widget _logoWithTitle(
      BuildContext context, ImageProvider image, String name, String title) {
    return Row(
      children: [
        CircleAvatar(radius: 22, backgroundImage: image),
        addHorizontal(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyles.medium2(color: AppColors.black)),
              addVertical(2),
              Text(title, style: TextStyles.regular2(color: AppColors.black)),
            ],
          ),
        ),
      ],
    );
  }

  
  Widget _WorkTypes(String workType) {
    final types = workType.isNotEmpty
        ? workType.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList()
        : <String>[];

    if (types.isEmpty) {
      return const SizedBox(); 
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Wrap(
        spacing: 3,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: List.generate(types.length * 2 - 1, (index) {
          if (index.isEven) {
            final type = types[index ~/ 2];
            return Text(
              type,
              style: TextStyles.semiBold(
                fontSize: 14,
                color: AppColors.primaryBlueColor,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.blueColor,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                '•',
                style: TextStyles.semiBold(
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _statusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(253, 245, 229, 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: TextStyles.semiBold(
          fontSize: 12,
          color: const Color.fromRGBO(225, 146, 0, 1),
        ),
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
  Widget _descriptionWidget(String description) {
    return Text(
      description,
      style: TextStyles.regular1(color: AppColors.bottomNavUnSelectedColor),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
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

  Widget _TalentMenu() {
    return PopupMenuButton<String>(
      iconColor: Colors.grey,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (value) {
        if (value == "Preview") {
          navigationService.navigateToWithParams(
            RouteList.JobListingDetailsScreen,
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "Preview",
          child: _buildRow(Icons.remove_red_eye, AppColors.black, "Preview"),
        ),
        PopupMenuItem(
          value: "Cancel",
          child: _buildRow(Icons.cancel, AppColors.redColor, "Cancel"),
        ),
      ],
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
