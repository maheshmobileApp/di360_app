import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class CartSummaryCard extends StatelessWidget {
  final int totalSuppliers;
  final int totalActiveItems;
  final int totalSelectedItems;

  const CartSummaryCard({
    super.key,
    required this.totalSuppliers,
    required this.totalActiveItems,
    required this.totalSelectedItems,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      elevation: 0,
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SummaryItem(
              icon: Icons.storefront_outlined,
              title: "Total Suppliers",
              value: totalSuppliers,
            ),

            _SummaryItem(
              icon: Icons.shopping_cart_outlined,
              title: "Total Active Items",
              value: totalActiveItems,
            ),

            _SummaryItem(
              icon: Icons.check_circle,
              title: "Total Selected Items",
              value: totalSelectedItems,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int value;

  const _SummaryItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 22,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 8),

        Flexible(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title: ",
                  style: TextStyles.regular2().copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                TextSpan(
                  text: value.toString(),
                  style: TextStyles.bold3().copyWith(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}