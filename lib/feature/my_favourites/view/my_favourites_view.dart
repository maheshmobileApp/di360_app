import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/my_favourites/view_model/my_favourites_view_model.dart';
import 'package:di360_flutter/feature/my_favourites/widgets/favourite_card.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MyFavouritesView extends StatefulWidget {
  const MyFavouritesView({super.key});

  @override
  State<MyFavouritesView> createState() => _MyFavouritesViewState();
}

class _MyFavouritesViewState extends State<MyFavouritesView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<MyFavouritesViewModel>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MyFavouritesViewModel>(context);
    final supVM = context.watch<SuppliesViewModel>();
    final favourites = vm.favouritesList;

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
            "My Favourites",
            style: TextStyles.bold3(),
          )),
      body: favourites.isEmpty
          ? Center(child: Text("No Favourites"))
          : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: favourites.length + (vm.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == favourites.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final item = favourites[index];

                return FavouriteCard(
                  isSelected: false,
                  productId: '',
                  productName: item.supply?.name ?? "",
                  companyName: item.supply?.dentalSupplier?.businessName ?? "",
                  addedOn: item.updatedAt ?? "",
                  availability: item.supplyVariant?.availableStock ?? 0,
                  price: '',
                  quantity: vm.quantityFor(item.supply?.id ?? ''),
                  onDecrease: () {
                    vm.decreaseQuantity(item.supply?.id ?? '');
                  },
                  onIncrease: () {
                    vm.increaseQuantity(item.supply?.id ?? '');
                  },
                  onFavourite: () {
                    vm.deleteFavourite(context, item.supply?.id ?? '',
                        item.supplyVariant?.id ?? "");
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
