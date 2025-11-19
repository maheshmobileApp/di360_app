import 'package:cached_network_image/cached_network_image.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/status_colors.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class CouresListingCard extends StatelessWidget {
  final String id;
  final String logoUrl;
  final String companyName;
  final String courseTitle;
  final String status;
  final String activeStatus;
  final String description;
  final List<String> types;
  final String createdAt;
  final int registeredCount;
  final String meetingLink;
  final String chipTitle;

  final VoidCallback? onTapRegistered;
  final Function(String action, String id)? onMenuAction;
  final VoidCallback? onDetailView;

  const CouresListingCard({
    super.key,
    required this.id,
    required this.logoUrl,
    required this.companyName,
    required this.courseTitle,
    required this.status,
    required this.description,
    required this.types,
    required this.createdAt,
    required this.registeredCount,
    this.onTapRegistered,
    this.onMenuAction,
    this.onDetailView,
    required this.meetingLink,
    required this.activeStatus,
    required this.chipTitle,
  });

  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(createdAt) ?? '';

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // 🔹 Top Card
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Logo + Title + Menu
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _logoWithTitle(logoUrl, companyName, courseTitle,
                          status, activeStatus),
                    ),
                    Row(
                      children: [
                        _jobTimeChip(time),
                        _menuWidget(context),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                _chipWidget(types, meetingLink),
                const SizedBox(height: 8),

                _descriptionWidget(description),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: onTapRegistered,
                        child: _registeredChip(registeredCount, chipTitle)),
                    GestureDetector(
                      onTap: onDetailView,
                      child: Row(
                        children: [
                          Text(
                            "View Details",
                            style: TextStyles.medium1(
                                color: AppColors.primaryColor),
                          ),
                          SvgPicture.asset(
                            ImageConst.nextArrow,
                            width: 26,
                            height: 26,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoWithTitle(
    String logo,
    String company,
    String title,
    String status,
    String activeStatus,
  ) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.geryColor,
              child: ClipOval(
                child: logo.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: logo,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                        // No placeholder → uses default placeholder
                        placeholderFadeInDuration: Duration(milliseconds: 300),
                        errorWidget: (context, url, error) => Icon(
                          Icons.person_2_rounded,
                          size: 30,
                          color: AppColors.lightGeryColor,
                        ),
                      )
                    : Icon(
                        Icons.person_2_rounded,
                        size: 30,
                        color: AppColors.lightGeryColor,
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(229, 244, 237, 1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.whiteColor, width: 1),
                ),
                child: Text(
                  status == "APPROVE" ? activeStatus : status,
                  style: TextStyles.bold4(
                    color: StatusColors.getColor(status),
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(company, style: TextStyles.medium2(color: AppColors.black)),
              const SizedBox(height: 2),
              Text(title, style: TextStyles.regular2(color: AppColors.black)),
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

  Widget _chipWidget(List<String> types, String meetingLink) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: types.map((type) {
        final label = type.isEmpty ? 'N/A' : type;
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.secondaryBlueColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                child: Text(
                  label,
                  style: TextStyles.regular1(
                    color: AppColors.typeTextColor,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            (meetingLink != "" && types.first == "Webinar")
                ? _meetingLinkWidget(meetingLink)
                : SizedBox.shrink(),
          ],
        );
      }).toList(),
    );
  }

  Widget _meetingLinkWidget(String link) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: const Color.fromARGB(37, 255, 255, 255),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.HINT_COLOR)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        child: GestureDetector(
          onTap: () async {
            final url = Uri.parse(link);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              scaffoldMessenger("Invalid link !!");
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

  Widget _jobTimeChip(String time) {
    return Container(
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
        style: TextStyles.semiBold(
            fontSize: 10, color: const Color.fromRGBO(255, 112, 0, 1)),
      ),
    );
  }

  Widget _registeredChip(int registeredCount, String chipTitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "$registeredCount $chipTitle",
        style: TextStyles.semiBold(fontSize: 10, color: AppColors.black),
      ),
    );
  }

  Widget _menuWidget(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero, // removes inside padding
      constraints: const BoxConstraints(
        minWidth: 0,
        minHeight: 0,
      ), // remove default 48x48
      icon: Icon(
        Icons.more_vert,
        size: 20,
        color: AppColors.bottomNavUnSelectedColor,
      ),
      onSelected: (value) => onMenuAction?.call(value, id),
      itemBuilder: (context) => [
        _popupItem("Preview", Icons.remove_red_eye, AppColors.black),
        if (status != "EXPIRED")
          _popupItem("Edit", Icons.edit_outlined, AppColors.blueColor),
        if (status != "APPROVE" && status != "EXPIRED" && status != "REJECT")
          _popupItem("Delete", Icons.delete_outline, AppColors.redColor),
        if (activeStatus == "ACTIVE" && status == "APPROVE")
          _popupItem(
              "Inactive", Icons.nightlight_outlined, AppColors.primaryColor),
        if (activeStatus == "INACTIVE" && status == "APPROVE")
          _popupItem(
              "Active", Icons.nightlight_outlined, AppColors.primaryColor),
        if (status == "EXPIRED")
          _popupItem("Re-Listing", Icons.edit_outlined, AppColors.blueColor),
      ],
    );
  }

  PopupMenuItem<String> _popupItem(String label, IconData icon, Color color) {
    return PopupMenuItem(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(label, style: TextStyles.semiBold(color: color, fontSize: 14)),
        ],
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
