import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/network_image_widget.dart';
import 'package:di360_flutter/feature/supplies/widgets/quantity_stepper.dart';
import 'package:di360_flutter/feature/supplies/widgets/stock_widget.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:provider/provider.dart';

class AvailableOptionsCard extends StatelessWidget {
  final Supplies? suppliesDetails;

  const AvailableOptionsCard({
    required this.suppliesDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final images = suppliesDetails?.image ?? [];
    final variants = suppliesDetails?.supplyVariants ?? <SupplyVariants>[];
    final vm = context.watch<SuppliesViewModel>();
    final total = variants.fold<double>(0, (sum, variant) {
      final rawPrice = variant.sellingPrice ?? variant.calaculatedPrice;
      final price = rawPrice is num
          ? rawPrice.toDouble()
          : double.tryParse(rawPrice?.toString() ?? '') ?? 0;
      return sum + price * vm.getQuantity(variant.id ?? '');
    });

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
                  Text("AVAILABLE OPTIONS",
                      style: TextStyles.clashSemiBold(fontSize: 18)),
                  const SizedBox(height: 8),
                  if (variants.isEmpty)
                    Text(
                      "No options available",
                      style: TextStyles.medium2(color: Colors.grey.shade700),
                    )
                  else
                    ...variants.map((variant) {
                      final imageUrl = variant.image?.isNotEmpty == true
                          ? variant.image!
                          : images.isNotEmpty
                              ? images.first.url ?? ""
                              : "";
                      return _varientCard(
                        variant,
                        imageUrl,
                        vm,
                      );
                    }),
                  _totalWidget(total.toStringAsFixed(2), () {
                    vm.addMultipleProductsToCart(
                      context,
                      suppliesDetails?.id ?? "",
                      variants,
                    );
                  })
                ]),
          )),
    );
  }
}

Widget _varientCard(SupplyVariants variant, String url, SuppliesViewModel vm) {
  final rawPrice = variant.sellingPrice ?? variant.calaculatedPrice;
  final price = rawPrice is num
      ? rawPrice.toDouble()
      : double.tryParse(rawPrice?.toString() ?? '') ?? 0;
  final variantName =
      variant.title ?? variant.attributes ?? variant.color ?? "-";

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.greysecond),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            NetworkImageWidget(
              imageUrl: url,
              fit: BoxFit.contain,
              width: 76,
              height: 76,
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            StockStatusWidget()
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _varientText("Code", variant.skuCode ?? "-"),
              _varientText("Variant", variantName),
              _varientText("Price", "\$ ${price.toStringAsFixed(2)}"),
              _varientText("Total",
                  "\$ ${(price * vm.getQuantity(variant.id ?? "")).toStringAsFixed(2)}"),
              _quantityCard(vm, variant.id ?? ""),
            ],
          ),
        ),
      ],
    ),
  );
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

_totalWidget(String total, VoidCallback onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Total : \$ ${total}",
        style: TextStyles.bold2(),
      ),
      GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AppColors.primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: AppColors.whiteColor,
                ),
                SizedBox(
                  width: 4,
                ),
                Text("Add selected to cart",
                    style: TextStyles.medium2(color: AppColors.whiteColor))
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

_quantityCard(SuppliesViewModel vm, String supplyId) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("Quantity", style: TextStyles.medium2(color: Colors.grey.shade700)),
    const SizedBox(width: 10),
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
  ]);
}

_priceInfoCard(Supplies? suppliesDetails) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 6,
      ),
      Text(
        "\$ ${suppliesDetails?.supplyVariants?.first.sellingPrice} - \$ ${suppliesDetails?.supplyVariants?.last.sellingPrice}",
        style: TextStyles.semiBold(fontSize: 20, color: AppColors.primaryColor),
      ),
      Text("Price varies by selected size",
          style: TextStyles.medium2(color: Colors.grey.shade700)),
    ],
  );
}

_infoDetailColumn(Supplies? suppliesDetails) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _infoRow("Product ID", "N/A"),
      _infoRow("Supplier", suppliesDetails?.dentalSupplier?.businessName ?? ''),
      _infoRow("Brand", suppliesDetails?.supplyBrand?.name ?? ''),
      _infoRow("Category", suppliesDetails?.supplyCategory?.name ?? ''),
      _infoRow("Sub Category", suppliesDetails?.supplySubCategory?.name ?? ''),
      _infoRow("Condition", suppliesDetails?.productCondition ?? ''),
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

_varientText(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 76,
          child: Text(title,
              style: TextStyles.medium2(color: Colors.grey.shade700)),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.bold2(),
          ),
        ),
      ],
    ),
  );
}
