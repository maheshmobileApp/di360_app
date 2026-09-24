import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class SubscriptionExpiredDialog extends StatelessWidget {
  const SubscriptionExpiredDialog({
    super.key,
    this.title,
    this.message,
    this.cancelText,
    this.actionText,
    this.onAction,
    this.icon,
  });

  final String? title;
  final String? message;
  final String? cancelText;
  final String? actionText;
  final VoidCallback? onAction;
  final IconData? icon;

  static Future<void> show(
    BuildContext context, {
    String? title,
    String? message,
    String? cancelText,
    String? actionText,
    VoidCallback? onAction,
    IconData? icon,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return SubscriptionExpiredDialog(
          title: title ?? "Subscription Expired",
          message: message ??
              "Your current subscription has ended. \n \n To continue using this feature, please visit the web application to renew your plan or explore available upgrade options.",
          cancelText: cancelText ?? "Cancel",
          actionText: actionText ?? "View Plans",
          onAction: onAction,
          icon: icon,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 28, 12, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF4E5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.event_busy_outlined,
                size: 30,
                color: Color(0xFFFF7A00),
              ),
            ),

            const SizedBox(height: 28),

            // Title
            Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: TextStyles.bold3(),
            ),

            const SizedBox(height: 12),

            // Message
            Text(
              message ?? "",
              textAlign: TextAlign.center,
              style: TextStyles.medium2(),
            ),

            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFF8F8F8),
                        side: const BorderSide(
                          color: Color(0xFFE0E0E0),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        cancelText ?? "",
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ),
                  ),
                ),
                  /*Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onAction?.call();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B00),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            actionText,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
