import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/widgets/network_image_widget.dart';
import 'package:di360_flutter/feature/supplies/widgets/quantity_stepper.dart';
import 'package:flutter/material.dart';

class PurchaseProductCard extends StatelessWidget {
  final String productName;
  final String sku;
  final String supplierName;
  final String orderedOn;
  final String orderedQTY;
  final int availability;
  final int quantity;
  final String? imageUrl;
  final VoidCallback? onCartTap;
  final ValueChanged<String>? onMenuSelected;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final bool checkbox;
  final bool menuOptions;

  const PurchaseProductCard({
    super.key,
    required this.sku,
    required this.supplierName,
    required this.orderedOn,
    required this.orderedQTY,
    required this.productName,
    required this.availability,
    required this.quantity,
    this.imageUrl,
    this.onCartTap,
    this.onMenuSelected,
    this.onIncrease,
    this.onDecrease,
    this.checkbox = true,
    this.menuOptions = true,
  });

  @override
  Widget build(BuildContext context) {
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
                      const SizedBox(height: 2),
                      _textWidget("SKU : ", sku),
                      const SizedBox(height: 2),
                      _textWidget("Supplier Name : ", supplierName),
                      const SizedBox(height: 2),
                      _textWidget("Ordered on : ", orderedOn),
                      const SizedBox(height: 2),
                      _textWidget("Ordered QTY : ", orderedQTY),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: (availability) < 0
                              ? Colors.red.shade100
                              : AppColors.greenColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          (availability) < 0 ? "Out of stock" : "Available",
                          style: TextStyles.medium2(
                            color: (availability) < 0
                                ? Colors.red.shade700
                                : AppColors.greenColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 14,
              ),
              child: Divider(height: 1),
            ),

            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: QuantityStepper(
                    quantity: quantity,
                    onIncrease: onIncrease,
                    onDecrease: quantity > 1 ? onDecrease : null,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: onCartTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.shopping_cart,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _textWidget(String title, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyles.medium2()),
      Expanded(
        child: Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.medium2(color: AppColors.black),
        ),
      ),
    ],
  );
}
