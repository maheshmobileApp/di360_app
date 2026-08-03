import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  final String supplierName;
  final int totalSelectedItems;
  final double subtotal;
  final double discount;
  final double freightCharges;
  final double estimatedTotal;

  final TextEditingController? couponController;

  final VoidCallback? onApplyCoupon;
  final VoidCallback? onViewCoupons;
  final VoidCallback? onSubmitOrder;
  final VoidCallback? onBackToCart;

  const OrderSummaryCard({
    super.key,
    required this.supplierName,
    required this.totalSelectedItems,
    required this.subtotal,
    required this.discount,
    required this.freightCharges,
    required this.estimatedTotal,
    this.couponController,
    this.onApplyCoupon,
    this.onViewCoupons,
    this.onSubmitOrder,
    this.onBackToCart,
  });

  Widget _row(String title, String value,
      {bool highlight = false, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: bold
                  ? TextStyles.bold3()
                  : TextStyles.medium2(color: Colors.grey.shade700),
            ),
          ),
          Text(
            value,
            style: bold
                ? TextStyles.bold3(
                    color: highlight
                        ? AppColors.primaryColor
                        : AppColors.black,
                  )
                : TextStyles.bold3(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Order Summary",
              style: TextStyles.bold4(),
            ),

            const SizedBox(height: 20),

            _row("Supplier", supplierName),

            _row(
              "Total Selected Items",
              totalSelectedItems.toString(),
            ),

            const Divider(height: 28),

            _row(
              "Subtotal",
              "AUD ${subtotal.toStringAsFixed(2)}",
            ),

            _row(
              "Discount",
              "(-) AUD ${discount.toStringAsFixed(2)}",
            ),

            _row(
              "Freight Charges",
              "AUD ${freightCharges.toStringAsFixed(2)}",
            ),

            const Divider(height: 28),

            _row(
              "Estimated Total",
              "AUD ${estimatedTotal.toStringAsFixed(2)}",
              bold: true,
              highlight: true,
            ),

            const SizedBox(height: 28),

            Text(
              "Have Promo Code?",
              style: TextStyles.bold3(),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: couponController,
                    decoration: InputDecoration(
                      hintText: "Enter Coupon Code",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onApplyCoupon,
                    child: const Text("Apply"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            InkWell(
              onTap: onViewCoupons,
              child: Text(
                "View Coupons",
                style: TextStyles.bold3(),
              ),
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info,
                    color: Colors.deepOrange,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "This is an order request. The supplier will confirm availability and dispatch details.",
                      style: TextStyles.medium2(
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: onSubmitOrder,
                icon: const Icon(Icons.send),
                label: const Text("Submit Order Request"),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: onBackToCart,
                icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                label: const Text("Back to Cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}