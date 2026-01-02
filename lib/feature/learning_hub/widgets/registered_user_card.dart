import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/status_colors.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';

class RegisteredUserCard extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String userName;
  final String userMail;
  final String description;
  final String userPhone;
  final String status;
  final String activeStatus;
  final Function(String action, String id)? onMenuAction;

  const RegisteredUserCard({
    super.key,
    required this.imageUrl,
    required this.userName,
    required this.userMail,
    required this.description,
    required this.userPhone,
    required this.status,
    required this.activeStatus,
    this.onMenuAction,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Image Container (1st column)
          Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.geryColor,
                radius: 30,
                child: ClipOval(
                  child: CachedNetworkImageWidget(
                      imageUrl: imageUrl ?? '',
                      fit: BoxFit.fill,
                      errorWidget: Image.asset(ImageConst.prfImg)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(229, 244, 237, 1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.whiteColor, width: 1),
                ),
                child: Text(
                  status,
                  style: TextStyles.bold4(
                    color: StatusColors.getColor(status),
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          // ✅ User details (2nd column)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName.toUpperCase(),
                    style: TextStyles.bold2(color: AppColors.black)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.email,
                        size: 16, color: AppColors.bottomNavUnSelectedColor),
                    const SizedBox(width: 4),
                    Text(
                      userMail,
                      style: TextStyles.regular2(
                          color: AppColors.bottomNavUnSelectedColor),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.phone,
                        size: 16, color: AppColors.bottomNavUnSelectedColor),
                    const SizedBox(width: 4),
                    Text(
                      userPhone,
                      style: TextStyles.regular2(
                          color: AppColors.bottomNavUnSelectedColor),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (description.isNotEmpty) ...[
                      Text(
                        "Description :",
                        style: TextStyles.bold2(color: AppColors.black),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.regular1(
                          color: AppColors.bottomNavUnSelectedColor,
                        ),
                      ),
                    ],
                  ],
                )
              ],
            ),
          ),

          (status == "PENDING" )? _menuWidget(context) : SizedBox.shrink(),
        ],
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
        _popupItem("Approve", Icons.check_circle, AppColors.greenColor),
        _popupItem("Cancel", Icons.cancel, AppColors.redColor),
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
}
