import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/app_button.dart';
import 'package:di360_flutter/feature/supplies/widgets/quantity_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSummaryCard extends StatelessWidget {
  final String supplier;
  final String itemsCount;
  final String subTotal;
  final String discount;
  final String freightCharges;
  final String estimatedTotal;

  const OrderSummaryCard({
    required this.supplier,
    required this.itemsCount,
    required this.subTotal,
    required this.discount,
    required this.freightCharges,
    required this.estimatedTotal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Summary',
                      style: TextStyles.clashSemiBold(fontSize: 18)),
                  _infoDetailColumn(supplier, itemsCount, subTotal, discount,
                      freightCharges, estimatedTotal)
                ]),
          )),
    );
  }
}

_iconWithText(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, size: 16, color: Colors.grey.shade700),
      const SizedBox(width: 4),
      Text(text, style: TextStyles.medium2(color: Colors.grey.shade700)),
    ],
  );
}

_quantityCard(SuppliesViewModel vm, String supplyId) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("Quantity", style: TextStyles.medium2(color: Colors.grey.shade700)),
    const SizedBox(height: 4),
    QuantityStepper(
      width: 120,
      quantity: vm.getQuantity(supplyId),
      onIncrease: () {
        vm.increaseQuantity(supplyId);
      },
      onDecrease: () {
        vm.decreaseQuantity(supplyId);
      },
    ),
    const SizedBox(height: 4),
  ]);
}

_priceInfoCard(Supplies? suppliesDetails) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price", style: TextStyles.medium2(color: Colors.grey.shade700)),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                "AUD ${suppliesDetails?.supplyVariants?.firstOrNull?.sellingPrice ?? 'N/A'}",
                style: TextStyles.semiBold(
                    fontSize: 20, color: AppColors.primaryColor),
              ),
              Text(" / Piece",
                  style: TextStyles.medium2(color: Colors.grey.shade700)),
            ],
          ),
        ],
      ),
      Container(
        decoration: BoxDecoration(
            color: AppColors.greenColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.greenColor, width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          child: Text("In Stock",
              style: TextStyles.semiBold(
                  color: AppColors.greenColor, fontSize: 12)),
        ),
      )
    ],
  );
}

_infoDetailColumn(String? supplier, String? itemsCount, String? subtotal,
    String? discount, String freightCharges, String estimatedTotal) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _infoRow("Supplier", supplier ?? ''),
      _infoRow("Total Selected Items", itemsCount ?? ''),
      Divider(),
      _infoRow("Subtotal", "AUD $subtotal"),
      _infoRow("Discount", "(-) AUD $discount"),
      _infoRow("Freight Charges", "AUD $freightCharges"),
      Divider(),
      _infoRow2("Estimated Total", "AUD $subtotal")
    ],
  );
}

_infoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyles.medium2(color: Colors.grey.shade700)),
        Text(value, style: TextStyles.bold2()),
      ],
    ),
  );
}

_infoRow2(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyles.bold2(color: Colors.grey.shade700)),
        Text(value, style: TextStyles.bold3(color: AppColors.primaryColor)),
      ],
    ),
  );
}
