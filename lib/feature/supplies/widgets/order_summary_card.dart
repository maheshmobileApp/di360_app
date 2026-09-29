import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSummaryCard extends StatelessWidget {
  final String supplier;
  final String itemsCount;
  final String subTotal;
  final String total;
  final String gst;
  final String estimatedTotal;

  const OrderSummaryCard({
    required this.supplier,
    required this.itemsCount,
    required this.subTotal,
    required this.total,
    required this.gst,
    required this.estimatedTotal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesViewModel>();
    final shippingCost = vm.shippingMethod == "express" ? 25.00 : 15.00;
    final totalPrice =
        ((double.tryParse(total) ?? 0) + shippingCost).toStringAsFixed(2);
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
                  _infoDetailColumn(supplier, itemsCount, subTotal, gst,
                      shippingCost, estimatedTotal, vm, totalPrice)
                ]),
          )),
    );
  }
}

_infoDetailColumn(
    String? supplier,
    String? itemsCount,
    String? subtotal,
    String? gst,
    dynamic shippingCost,
    String estimatedTotal,
    SuppliesViewModel vm,
    String total) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _infoRow("Supplier", supplier ?? ''),
      _infoRow("Total Selected Items", itemsCount ?? ''),
      Divider(),
      _shippingMethod(vm, (3 - int.parse(itemsCount ?? "0")).toString()),
      Divider(),
      _infoRow("Subtotal (Exc GST)", "\$ $subtotal"),
      _infoRow("GST (10%)", "\$ $gst"),
      _infoRow("Shipping Cost", "\$ $shippingCost"),
      Divider(),
      _infoRow2("Total (Inc GST)", "\$ ${total}")
    ],
  );
}

_shippingMethod(SuppliesViewModel vm, String itemsCount) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Shipping Method', style: TextStyles.clashSemiBold(fontSize: 14)),
      SizedBox(
        height: 8,
      ),
      _methodCard(() {
        vm.setShippingMethod("standard");
      }, "Standard delivery", itemsCount == "0" ? "Free" : "\$ 15.00", "3 - 5",
          Icons.local_shipping,
          type: vm.shippingMethod == "standard", info: itemsCount),
      SizedBox(
        height: 8,
      ),
      _methodCard(() {
        vm.setShippingMethod("express");
      }, "Express delivery", "\$ 25.00", "1 - 3", Icons.bolt,
          type: vm.shippingMethod == "express")
    ],
  );
}

Widget _methodCard(
    VoidCallback onTap, String title, String cost, String time, IconData? icon,
    {required bool type, String? info = ""}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: type
              ? AppColors.primaryColor.withOpacity(0.1)
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: type ? AppColors.primaryColor : AppColors.greysecond)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: type ? AppColors.primaryColor : const Color(0xFFF5F6F8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: type ? AppColors.whiteColor : Color(0xFF7A8290),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$cost",
                        style: TextStyle(
                          color: cost == "Free"
                              ? AppColors.greenColor
                              : AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Estimated $time days",
                    style: TextStyle(
                      color: AppColors.geryColor,
                      fontSize: 14,
                    ),
                  ),
                  if (info != "")
                    Text(
                      cost == "Free"
                          ? "Free — 3+ different products in cart."
                          : "Add $info more different product for free shipping.",
                      style: TextStyle(
                        color: cost == "Free"
                            ? AppColors.greenColor
                            : AppColors.primaryColor,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
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
