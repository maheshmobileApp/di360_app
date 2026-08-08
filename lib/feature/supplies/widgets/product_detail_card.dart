import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/app_button.dart';
import 'package:di360_flutter/feature/supplies/widgets/quantity_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailCard extends StatelessWidget {
  final Supplies? suppliesDetails;

  const ProductDetailCard({
    required this.suppliesDetails,
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
                  Text(suppliesDetails?.name ?? '',
                      style: TextStyles.clashSemiBold(fontSize: 18)),
                  _infoDetailColumn(suppliesDetails),
                  _priceInfoCard(suppliesDetails),
                  _quantityCard(vm, suppliesDetails?.id ?? ""),
                  SizedBox(height: 8),
                  AppButton(
                    height: 40,
                    title: "Add to Cart",
                    prefixIcon: Icons.shopping_cart,
                    onPressed: () async{
                      final supplyId = suppliesDetails?.id ?? "";
                  final variantId =
                      suppliesDetails?.supplyVariants?.firstOrNull?.id ?? "";
                  final quantity = vm.getQuantity(supplyId);

                  final cartItem = vm.getCartItemBySupplyId(supplyId);

                  if (cartItem != null) {
                    await vm.increaseQuantityById(
                      context,
                      cartItem.id ?? "",
                      quantity,
                    );
                  } else {
                    await vm.addToCart(
                      context,
                      supplyId,
                      variantId,
                      quantity,
                    );
                  }

                  vm.resetQuantity(supplyId);
                  vm.getSuppliesCart(context);
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          height: 40,
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          title: "Add to Wishlist",
                          fontSize: 12,
                          prefixIcon: Icons.favorite,
                          outlined: true,
                          backgroundColor: Colors.white,
                          borderColor: Colors.red.shade300,
                          textColor: Colors.red,
                          iconColor: Colors.red,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: AppButton(
                          height: 40,
                          title: "Save for Later",
                          fontSize: 12,
                          prefixIcon: Icons.bookmark_border,
                          outlined: true,
                          backgroundColor: Colors.white,
                          borderColor: Colors.grey.shade300,
                          textColor: Colors.black87,
                          iconColor: Colors.black87,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _iconWithText(Icons.mail_outlined, "Send Enquiry"),
                      SizedBox(width: 10),
                      _iconWithText(Icons.share, "Share Product Link"),
                    ],
                  ),
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

_infoDetailColumn(Supplies? suppliesDetails) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
