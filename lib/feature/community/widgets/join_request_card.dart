import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class JoinRequestCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String status;
  final String membership;
  final Function()? onApprove;
  final Function()? onReject;

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
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
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
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == "approve" && onApprove != null) {
                      onApprove!();
                    } else if (value == "reject" && onReject != null) {
                      onReject!();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: "approve",
                      child: Text("Approve"),
                    ),
                    const PopupMenuItem(
                      value: "reject",
                      child: Text("Reject"),
                    ),
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
