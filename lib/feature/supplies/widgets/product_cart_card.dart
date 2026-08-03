import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class ProductCartCard extends StatelessWidget {
  final bool isSelected;
  final String productId;
  final String productName;
  final String price;
  final int quantity;

  final ValueChanged<bool?>? onChecked;
  final ValueChanged<String>? onMenuSelected;

  const ProductCartCard({
    super.key,
    required this.isSelected,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    this.onChecked,
    this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Checkbox(
              value: isSelected,
              onChanged: onChecked,
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyles.bold3(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Product ID : $productId",
                    style: TextStyles.medium2(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        "AUD $price",
                        style: TextStyles.bold3(
                          color: AppColors.primaryColor,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Text(
                        "Qty : $quantity",
                        style: TextStyles.medium2(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            PopupMenuButton<String>(
              onSelected: onMenuSelected,
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: "edit",
                  child: Text("Edit"),
                ),
                PopupMenuItem(
                  value: "remove",
                  child: Text("Remove"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*ProductCartCard(
  isSelected: true,
  productId: "PRD-10001",
  productName: "Dental Composite Kit",
  price: "125.00",
  quantity: 3,
  onChecked: (value) {
    // Handle checkbox
  },
  onMenuSelected: (action) {
    switch (action) {
      case "edit":
        break;

      case "remove":
        break;
    }
  },
)*/