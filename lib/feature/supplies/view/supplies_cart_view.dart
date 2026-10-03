import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/supplies/model/get_supply_carts.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/app_button.dart';
import 'package:di360_flutter/feature/supplies/widgets/product_cart_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuppliesCartView extends StatefulWidget {
  const SuppliesCartView({super.key});

  @override
  State<SuppliesCartView> createState() => _SuppliesCartViewState();
}

class _SuppliesCartViewState extends State<SuppliesCartView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    
  }

  

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesViewModel>();

    final cartItems = vm.suppliesCartData?.supplyCarts ?? [];

    final groupedCart = <String, List<SupplyCarts>>{};

    for (final item in cartItems) {
      final business =
          item.supply?.dentalSupplier?.businessName ?? "Unknown Supplier";

      groupedCart.putIfAbsent(business, () => []);
      groupedCart[business]!.add(item);
    }

    final supplierEntries = groupedCart.entries.toList();

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            leading: IconButton(
                onPressed: () {
                  navigationService.goBack();
                },
                icon: Icon(Icons.arrow_back_ios)),
            title: Text(
              "Cart",
              style: TextStyles.bold3(),
            )),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ListView(controller: scrollController, children: [
              Card(
                color: const Color.fromARGB(255, 237, 236, 235),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("You have selected Multiple Items From Multiple Vendors !", style: TextStyles.semiBold(fontSize: 12, color: AppColors.redColor),),
                      Text("You can place order from one vendor at once", style: TextStyles.medium1( color: AppColors.redColor),),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ...supplierEntries.map(
                (supplier) {
                  return Card(
                    color: Colors.grey.shade100,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: AppColors.primaryColor,
                                      tristate: true,
                                      value:
                                          vm.isSupplierSelected(supplier.key),
                                      onChanged: (value) {
                                        vm.toggleSupplier(
                                          supplier.key,
                                          value ?? false,
                                        );
                                      },
                                    ),
                                    Text(
                                      supplier.key,
                                      style: TextStyles.bold2(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            SizedBox(
                              width: 120,
                              child: AppButton(
                                height: 40,
                                title: "Proceed",
                                onPressed: () {
                                  navigationService.navigateToWithParams(RouteList.orderRequestReviewView, params: {"selected_products": vm.selectedProducts});
                                },
                              ),
                            ),
                            SizedBox(width: 16)
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// Products
                        ...supplier.value.map(
                          (item) => ProductCartCard(
                            item: item,
                            isSelected: vm.isProductSelected(item.id!),
                            imageUrl: item.supply?.image?.isNotEmpty == true
                                ? item.supply!.image!.first.url ?? ""
                                : "",
                            productId: item.supplyVariant?.skuCode ?? "",
                            productName: item.supply?.name ?? "",
                            price:
                                item.supplyVariant?.sellingPrice?.toString() ??
                                    "",
                            quantity: item.quantity ?? 0,
                            onChecked: (value) {
                              vm.toggleProduct(
                                item,
                                value ?? false,
                              );
                            },
                            onMenuSelected: (action) {},
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ])));
  }
}
