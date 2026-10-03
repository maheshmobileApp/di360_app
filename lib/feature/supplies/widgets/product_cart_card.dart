import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/model/get_supply_carts.dart';
import 'package:di360_flutter/feature/supplies/widgets/network_image_widget.dart';
import 'package:di360_flutter/feature/supplies/widgets/quantity_stepper.dart';
import 'package:flutter/material.dart';

class ProductCartCard extends StatelessWidget {
  final SupplyCarts item;
  final bool isSelected;
  final String productId;
  final String productName;
  final String price;
  final int quantity;
  final String? imageUrl;

  final ValueChanged<bool?>? onChecked;
  final ValueChanged<String>? onMenuSelected;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final bool checkbox;

  const ProductCartCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    this.imageUrl,
    this.onChecked,
    this.onMenuSelected,
    this.onIncrease,
    this.onDecrease,
    this.checkbox = true,
  });

  @override
  Widget build(BuildContext context) {
    final total = (double.tryParse(price) ?? 0) * quantity;

    return Card(
      elevation: 2,
      color: AppColors.whiteColor,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            /// Top Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(checkbox)
                Checkbox(
                  activeColor: AppColors.primaryColor,
                  value: isSelected,
                  onChanged: (value) {
                    onChecked?.call(value);
                  },
                ),

                /// Image
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: NetworkImageWidget(
                    imageUrl: imageUrl ?? "",
                    fit: BoxFit.contain,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.bold2(),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Product ID: $productId",
                        style: TextStyles.medium2(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Price: AUD $price",
                        style: TextStyles.bold2(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

                PopupMenuButton<String>(
                  onSelected: onMenuSelected,
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: "wishlist",
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border),
                          SizedBox(width: 10),
                          Text("Save for Later"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "remove",
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          SizedBox(width: 10),
                          Text("Remove"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 14,
              ),
              child: Divider(height: 1),
            ),

            /// Bottom Section
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: QuantityStepper(
                    quantity: quantity,
                    onIncrease: onIncrease,
                    onDecrease: onDecrease,
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Total",
                      style: TextStyles.medium2(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "AUD ${total.toStringAsFixed(2)}",
                      style: TextStyles.bold3(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
