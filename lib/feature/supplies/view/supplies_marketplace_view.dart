import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/supplies/model/product_model.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/product_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuppliesMarketplaceView extends StatefulWidget {
  const SuppliesMarketplaceView({super.key});

  @override
  State<SuppliesMarketplaceView> createState() =>
      _SuppliesMarketplaceViewState();
}

class _SuppliesMarketplaceViewState extends State<SuppliesMarketplaceView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SuppliesViewModel>().getSuppliers(context);
    });

    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      context.read<SuppliesViewModel>().getSuppliers(
            context,
            isLoadMore: true,
          );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesViewModel>();

    final supplies = vm.supplyData?.supplies ?? [];

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
            IconButton(
              onPressed: () async {
                await vm.getSuppliesCart(context);
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
                        '${vm.suppliesCartData?.supplyCarts?.length ?? 0}',
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
            "All Products",
            style: TextStyles.bold3(),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GridView.builder(
          controller: scrollController,
          itemCount: supplies.length + (vm.isLoadingMore ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.60,
          ),
          itemBuilder: (context, index) {
            if (index == supplies.length) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final supply = supplies[index];

            return ProductCard(
                product: Product(
                  id: supply.id ?? "",
                  image: supply.image?.firstOrNull?.url ?? "",
                  name: supply.name ?? "",
                  brand: supply.dentalSupplier?.businessName ?? "",
                  price: supply.supplyVariants?.firstOrNull?.sellingPrice
                          ?.toString() ??
                      "",
                  inStock:
                      (supply.supplyVariants?.firstOrNull?.availableStock ??
                              0) >
                          0,
                  quantity: vm.getQuantity(supply.id ?? ""),
                  isSpotOn: true,
                  supplyBrand: supply.supplyBrand?.name ?? "",
                ),
                onFavorite: () {},
                onIncrease: () {
                  vm.increaseQuantity(supply.id ?? "");
                },
                onDecrease: () {
                  vm.decreaseQuantity(supply.id ?? "");
                },
                onAddToCart: () async {
                  final supplyId = supply.id ?? "";
                  final variantId =
                      supply.supplyVariants?.firstOrNull?.id ?? "";
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
                onDetailView: () async {
                  print(
                      "Navigating to details view for supply ID: ${supply.id}");
                  await vm.getSuppliesDetails(context, supply.id ?? "");
                  navigationService.navigateTo(RouteList.suppliesDetailsView);
                });
          },
        ),
      ),
    );
  }
}
