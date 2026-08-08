import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class QuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  final double height;
  final double width;
  final Color backgroundColor;
  final BorderRadius? borderRadius;

  const QuantityStepper({
    super.key,
    required this.quantity,
    this.onIncrease,
    this.onDecrease,
    this.height = 40,
    this.width = double.infinity,
    this.backgroundColor = AppColors.greyLightcolor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _actionButton(
            icon: Icons.remove,
            onTap: onDecrease,
          ),

          Expanded(
            child: Center(
              child: Text(
                quantity.toString(),
                style: TextStyles.bold3(),
              ),
            ),
          ),

          _actionButton(
            icon: Icons.add,
            onTap: onIncrease,
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    VoidCallback? onTap,
  }) {
    final isDisabled = onTap == null;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 45,
        height: double.infinity,
        child: Icon(
        icon,
        color: isDisabled
            ? Colors.grey.shade400
            : AppColors.black,
      ),
      ),
    );
  }
}