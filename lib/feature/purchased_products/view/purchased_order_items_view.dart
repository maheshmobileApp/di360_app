import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/purchased_products/view_model/purchased_order_tems_view_model.dart';
import 'package:di360_flutter/feature/purchased_products/widgets/purchase_order_item_card.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PurchasedOrderItemsView extends StatefulWidget {
  const PurchasedOrderItemsView({super.key});

  @override
  State<PurchasedOrderItemsView> createState() =>
      _PurchasedOrderItemsViewState();
}

class _PurchasedOrderItemsViewState extends State<PurchasedOrderItemsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<PurchasedOrderTemsViewModel>().getPurchasedOrderItems(context);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PurchasedOrderTemsViewModel>().getPurchasedOrderItems(
            context,
            isLoadMore: true,
          );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PurchasedOrderTemsViewModel>(context);
    final supVM = Provider.of<SuppliesViewModel>(context);

    final orders = vm.purchasedOrderItemsData?.suppliesOrderItems ?? [];

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
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      navigationService
                          .navigateTo(RouteList.purchasedOrderItemsFilterView);
                    },
                    child: SvgPicture.asset(ImageConst.filter,
                        color: AppColors.black),
                  ),
                  if (vm.isFilterApplied)
                    GestureDetector(
                        onTap: () async {
                          await vm.clearFilters();
                          vm.getPurchasedOrderItems(context);
                        },
                        child: Icon(Icons.close, color: AppColors.black))
                ],
              ),
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
              "Purchased Order Items",
              style: TextStyles.bold3(),
            )),
        body: orders.isEmpty
            ? Center(child: Text("No items"))
            : ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: orders.length + (vm.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == orders.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final item = orders[index];

                  return PurchaseOrderItemCard(
                    productId: '',
                    productName: item.supply?.name ?? "",
                    imageUrl: item.supply?.image?.firstOrNull?.url ?? "",
                    addedOn: '',
                    availability: 0,
                    price: '',
                    quantity: vm.quantityFor(item.supply?.id ?? ""),
                    supplierName: item.suppliesOrder?.supplier?.businessName,
                    orderedOn: item.suppliesOrder?.createdAt,
                    orderedQty: item.quantity.toString(),
                    status: item.supplyVariant?.availableStock > 0
                        ? "Available"
                        : "",
                    onDecrease: () {
                      vm.decreaseQuantity(item.supply?.id ?? "");
                    },
                    onIncrease: () {
                      vm.increaseQuantity(item.supply?.id ?? "");
                    },
                    onCartTap: () async {
                      if ((item.supplyVariant?.availableStock ?? 0) > 0) {
                        if (vm.quantityFor(item.supply?.id ?? "") <= 0) {
                          scaffoldMessenger("Please add quantity");
                          return;
                        }
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
                }),
        );
  }
}
