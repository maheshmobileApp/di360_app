import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/app_button.dart';
import 'package:di360_flutter/feature/supplies/widgets/quantity_stepper.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailCardOne extends StatelessWidget {
  final Supplies? suppliesDetails;

  const ProductDetailCardOne({
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
                  if ((suppliesDetails
                              ?.supplyVariants?.firstOrNull?.availableStock ??
                          0) >
                      0)
                    _quantityCard(vm, suppliesDetails?.id ?? ""),
                  SizedBox(height: 8),
                  AppButton(
                    height: 40,
                    title: "Add to Cart",
                    prefixIcon: Icons.shopping_cart,
                    onPressed: () async {
                      if ((suppliesDetails?.supplyVariants?.firstOrNull
                                  ?.availableStock ??
                              0) <
                          0) {
                        scaffoldMessenger("Out of stock");
                      } else {
                        final supplyId = suppliesDetails?.id ?? "";
                        final variantId =
                            suppliesDetails?.supplyVariants?.firstOrNull?.id ??
                                "";
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
                      }
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
                          backgroundColor: Colors.white,
                          borderColor: vm.checkFavouriteKey(suppliesDetails?.id ?? "")? AppColors.primaryColor: Colors.grey.shade300,
                          textColor: vm.checkFavouriteKey(suppliesDetails?.id ?? "")? AppColors.primaryColor: Colors.black87,
                          iconColor: vm.checkFavouriteKey(suppliesDetails?.id ?? "")? AppColors.primaryColor: Colors.black87,
                          onPressed: () {
                            vm.checkFavouriteKey(suppliesDetails?.id ?? "" ?? "")
                                ? vm.deleteFavourites(
                                    suppliesDetails?.id ?? "" ?? "",
                                    suppliesDetails?.supplyVariants?.first.id ?? "",
                                    context)
                                : vm.addFavourites(
                                    suppliesDetails?.id ?? "",
                                    suppliesDetails?.supplyVariants?.first.id ?? "",
                                    context);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: AppButton(
                          height: 40,
                          title: "Save for Later",
                          fontSize: 12,
                          prefixIcon: Icons.bookmark_border,
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
                "\$ ${suppliesDetails?.supplyVariants?.firstOrNull?.sellingPrice ?? 'N/A'}",
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
            color:
                (suppliesDetails?.supplyVariants?.firstOrNull?.availableStock ??
                            0) <
                        0
                    ? AppColors.redColor.withOpacity(0.1)
                    : AppColors.greenColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: (suppliesDetails
                                ?.supplyVariants?.firstOrNull?.availableStock ??
                            0) <
                        0
                    ? AppColors.redColor
                    : AppColors.greenColor,
                width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          child: Text(
              (suppliesDetails?.supplyVariants?.firstOrNull?.availableStock ??
                          0) <
                      0
                  ? "Out of stock"
                  : "In Stock",
              style: TextStyles.semiBold(
                  color: (suppliesDetails?.supplyVariants?.firstOrNull
                                  ?.availableStock ??
                              0) <
                          0
                      ? AppColors.redColor
                      : AppColors.greenColor,
                  fontSize: 12)),
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

_varientText(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyles.medium2(color: Colors.grey.shade700)),
        Text(value, style: TextStyles.bold2()),
      ],
    ),
  );
}
