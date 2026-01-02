import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampaignCard extends StatelessWidget {
  final String campaignName;
  final String type;
  final String createdBy;
  final String status;
  final String date;
  final String time;
  final String repeat;

  final VoidCallback? onApprove;
  final Function(String action)? onMenuAction;
  final VoidCallback? onReject;

  const CampaignCard({
    super.key,
    required this.campaignName,
    this.onApprove,
    this.onReject,
    this.onMenuAction, required this.type, required this.createdBy, required this.status, required this.date, required this.time, required this.repeat,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Name + Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Text(
                        "Campaign Name: ",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Text(
                          "$campaignName",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  color: AppColors.whiteColor,
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) => onMenuAction?.call(value),
                  itemBuilder: (context) => [
                     _popupItem("Preview", Icons.remove_red_eye, Colors.orange),
                    _popupItem("Repeat", Icons.repeat, AppColors.blueColor),
                    _popupItem("Delete", Icons.delete, AppColors.redColor),
                  ],
                ),

                /// 3 Dots Menu
              ],
            ),

            _infoRow("Type", type),
            _infoRow("Created by", createdBy),
            _infoRow("Scheduled date", date),
            _infoRow("Time", time),
            _infoRow("Repeat", (repeat=="")? "no": repeat),
            _infoRow("Status", status),
          ],
        ),
      ),
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

  Widget _infoRow(String title, String value) {
    String formattedValue = DateFormatUtils.formatDateTime(value);
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              formattedValue,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
