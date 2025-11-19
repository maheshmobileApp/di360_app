import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterNowWidget extends StatelessWidget {
  final String? currentPrice;
  final String? oldPrice;
  final String? buttonText;
  final VoidCallback? onPressed;
  final bool registerStatus;
  final String? earlyBirdEndDate;

  const RegisterNowWidget({
    Key? key,
    required this.currentPrice,
    this.oldPrice,
    this.buttonText,
    this.onPressed,
    required this.registerStatus,
    this.earlyBirdEndDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? earlyBirdEnd;

    if (earlyBirdEndDate != null && earlyBirdEndDate!.isNotEmpty) {
      try {
        earlyBirdEnd = DateFormat("dd/MM/yyyy").parse(earlyBirdEndDate!);
      } catch (e) {
        print("Date parse error: $e");
      }
    }

    final bool isEarlyBirdActive = earlyBirdEnd != null
        ? DateTime.now().isBefore(earlyBirdEnd!) ||
            DateTime.now().isAtSameMomentAs(earlyBirdEnd!)
        : false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Prices
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ⭐ Price Logic Here
              if (isEarlyBirdActive) ...[
                Text(
                  "AUD \$ ${oldPrice != null ? double.tryParse(oldPrice!)?.toStringAsFixed(0) ?? oldPrice : ''}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  "AUD \$ ${currentPrice != null ? double.tryParse(currentPrice!)?.toStringAsFixed(0) ?? currentPrice : ''}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.activesendary,
                  ),
                ),
              ] else ...[
                // EARLY BIRD EXPIRED → Show old & new prices
                if (oldPrice != null)
                  Text(
                  "AUD \$ ${oldPrice != null ? double.tryParse(oldPrice!)?.toStringAsFixed(0) ?? oldPrice : ''}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.activesendary,
                    ),
                  ),
              ],
            ],
          ),

          // Register Button
          CustomRoundedButton(
            onPressed: onPressed ?? () {},
            backgroundColor: AppColors.primaryColor,
            text: registerStatus ? "Registered" : "Register Now",
            width: 150,
            height: 42,
            textColor: AppColors.whiteColor,
          )
        ],
      ),
    );
  }
}
