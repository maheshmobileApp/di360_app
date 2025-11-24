import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsFeedCategoryCard extends StatelessWidget {
  final String categoryName;
  final String createdAt;
  final String updatedAt;
  final VoidCallback? onApprove;
  final Function(String action)? onMenuAction;
  final VoidCallback? onReject;

  const NewsFeedCategoryCard({
    super.key,
    required this.categoryName,
    this.onApprove,
    this.onReject,
    this.onMenuAction,
    required this.createdAt,
    required this.updatedAt,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Name + Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$categoryName",
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /// 3 Dots Menu
                PopupMenuButton<String>(
                  color: AppColors.whiteColor,
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) => onMenuAction?.call(value),
                  itemBuilder: (context) => [
                    
                         _popupItem("Edit", Icons.edit, AppColors.blueColor),
                         _popupItem(
                            "Delete", Icons.delete, AppColors.redColor),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 2),

            _infoRow("Created At", createdAt),
            _infoRow("UpdatedAt", updatedAt),
           
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
    String formattedValue = _formatDateTime(value);
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
  
  String _formatDateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);
    } catch (e) {
      return dateTimeString; // Return original if parsing fails
    }
  }
}
