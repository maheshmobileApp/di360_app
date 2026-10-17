import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/my_favourites/widgets/favourite_card.dart';
import 'package:di360_flutter/feature/purchased_products/view_model/purchased_products_view_model.dart';
import 'package:di360_flutter/feature/purchased_products/widgets/purchase_product_card.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchasedProductsView extends StatefulWidget {
  const PurchasedProductsView({super.key});

  @override
  State<PurchasedProductsView> createState() => _PurchasedProductsViewState();
}

class _PurchasedProductsViewState extends State<PurchasedProductsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {}
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PurchasedProductsViewModel>(context);
    final supVM = context.watch<SuppliesViewModel>();
    final products = vm.purchasedProductsData?.suppliesOrderItems ?? [];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
              onPressed: () {
                navigationService.goBack();
              },
              icon: Icon(Icons.arrow_back_ios)),
          actions: [
            /*Row(
              children: [
                GestureDetector(
                    onTap: () async {
                      navigationService.navigateTo(RouteList.favouriteFilterView);
                    },
                    child:
                        SvgPicture.asset(ImageConst.filter, color: AppColors.black),
                  ),
                  if (vm.isFilterApplied)
                GestureDetector(
                    onTap: () async {
                      await vm.clearFilters();
                      vm.getSupplyFavourites(context);
                    },
                    child: Icon(Icons.close, color: AppColors.black))
              ],
            ),*/
            IconButton(
              onPressed: () async {
                await supVM.getSuppliesCart(context);
                supVM.clearSelectedSuppliersAndProducts();
                navigationService.navigateTo(RouteList.suppliesCartView);
              },
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.shopping_cart),
                  Positioned(
                    right: -6,
                    top: -6,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: AppColors.primaryColor,
                      child: Text(
                        '${supVM.suppliesCartData?.supplyCarts?.length ?? 0}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
          title: Text(
            "Purchased Products",
            style: TextStyles.bold3(),
          )),
      body: products.isEmpty
          ? Center(child: Text("No Purchased Products"))
          : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                if (index == products.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final item = products[index];

                return PurchaseProductCard(
                  
                  productName: item.supply?.name ?? "",
                  sku: item.supplyVariant?.skuCode?? "",
                  supplierName: item.suppliesOrder?.supplier?.businessName?? "",
                  orderedOn: DateFormatUtils.formatDateToDmy(item.createdAt?? ""),
                  orderedQTY: item.quantity.toString(),
                  availability: item.supplyVariant?.availableStock ?? 0,
                  quantity: vm.quantityFor(item.supply?.id ?? ''),
                  onDecrease: () {
                    vm.decreaseQuantity(item.supply?.id ?? '');
                  },
                  onIncrease: () {
                    vm.increaseQuantity(item.supply?.id ?? '');
                  },
                  imageUrl: item.supply?.image?.first.url ?? "",
                  onCartTap: () async {
                    
                    if ((item.supplyVariant?.availableStock ?? 0) > 0) {
                      final supplyId = item.supply?.id ?? "";
                      final variantId = item.supplyVariant?.id ?? "";
                      final quantity = vm.quantityFor(supplyId);

                      final cartItem = supVM.getCartItemBySupplyId(supplyId);

                      if (cartItem != null) {
                        await supVM.increaseQuantityById(
                          context,
                          cartItem.id ?? "",
                          quantity,
                        );
                      } else {
                        await supVM.addToCart(
                          context,
                          supplyId,
                          variantId,
                          quantity,
                        );
                      }

                      vm.resetQuantity(supplyId);
                      await supVM.getSuppliesCart(context);
                    } else {
                      scaffoldMessenger("Out of stock...");
                    }
                  },
                );
              },
            ),
    );
  }
}
