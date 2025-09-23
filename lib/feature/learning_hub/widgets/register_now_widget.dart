import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class RegisterNowWidget extends StatelessWidget {
  final String currentPrice;
  final String? oldPrice;
  final String? buttonText;
  final VoidCallback onPressed;

  const RegisterNowWidget({
    Key? key,
    required this.currentPrice,
    this.oldPrice,
     this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Prices
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AUD \$ ${currentPrice}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              if (oldPrice != null)
                Text(
                  "AUD \$ ${oldPrice}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
            ],
          ),

          // Register Button
          CustomRoundedButton(onPressed:onPressed ,backgroundColor: AppColors.primaryColor,text: "Register Now",width: 150,height: 42,textColor: AppColors.whiteColor,)
        ],
      ),
    );
  }
}
