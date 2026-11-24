import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/widgets/network_image_widget.dart';
import 'package:di360_flutter/feature/supplies/widgets/quantity_stepper.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';

class PurchaseOrderItemCard extends StatelessWidget {
  final String productId;
  final String productName;
  final String addedOn;
  final int availability;
  final String price;
  final int quantity;
  final String? imageUrl;
  final VoidCallback? onFavourite;
  final VoidCallback? onCartTap;
  final ValueChanged<String>? onMenuSelected;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final bool checkbox;
  final bool menuOptions;
  final String? supplierName;
  final String? promotion;
  final String? orderedOn;
  final String? orderedQty;
  final String? status;

  const PurchaseOrderItemCard({
    super.key,
    required this.productId,
    required this.productName,
    required this.addedOn,
    required this.availability,
    required this.price,
    required this.quantity,
    this.imageUrl,
    this.onFavourite,
    this.onCartTap,
    this.onMenuSelected,
    this.onIncrease,
    this.onDecrease,
    this.checkbox = true,
    this.menuOptions = true,
    this.supplierName = " ",
    this.promotion = " ",
    this.orderedOn = " ",
    this.orderedQty = " ",
    this.status = " ",
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
                const SizedBox(width: 10),

                Column(
                  children: [
                    _field("Product", productName),
                    _field("Supplier Name", supplierName ?? ""),
                  ],
                ),

                

                /// Details
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _field("Promotion", promotion ?? "")),
                    Expanded(child: _field("Ordered on", DateFormatUtils.formatDateOnly(orderedOn ?? ""))),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _field("Ordered QTY", orderedQty ?? "")),
                    Expanded(child: _field("Availbility Status", status ?? "")),
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

  Widget _field(String key, String value, {bool box = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 2),
        box
            ? _chip(
                value,
                _getColor(value).withValues(alpha: 0.1),
                _getColor(value),
              )
            : Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
      ],
    );
  }

  Color _getColor(String text) {
    if (text == "ACTIVE") {
      return AppColors.greenColor;
    } else if (text == "EXPIRED") {
      return AppColors.redColor;
    } else if (text == "INACTIVE") {
      return AppColors.blueColor;
    } else {
      return AppColors.primaryColor;
    }
  }

  Widget _chip(
    String text,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
