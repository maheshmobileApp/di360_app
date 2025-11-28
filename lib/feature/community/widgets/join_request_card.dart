import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class JoinRequestCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String status;
  final String membership;
  final VoidCallback? onApprove;
  final Function(String action)? onMenuAction;
  final VoidCallback? onReject;

  const JoinRequestCard({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.status,
    required this.membership,
    this.onApprove,
    this.onReject,
    this.onMenuAction,
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
                  "$firstName $lastName",
                  style: const TextStyle(
                    fontSize: 14,
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
                    (status == "APPROVED")
                        ? _popupItem("Reject", Icons.close, AppColors.redColor)
                        : _popupItem(
                            "Approve", Icons.check, AppColors.greenColor),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 2),

            _infoRow("Email", email),
            _infoRow("Phone", phone),
            _infoRow("Status", status),
            _infoRow("Membership", membership),
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
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
