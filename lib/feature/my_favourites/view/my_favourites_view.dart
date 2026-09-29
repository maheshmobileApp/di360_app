import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_filter_widget.dart';
import 'package:di360_flutter/feature/my_favourites/view_model/my_favourites_view_model.dart';
import 'package:di360_flutter/feature/my_favourites/widgets/favourite_card.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFavouritesView extends StatelessWidget {
  const MyFavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MyFavouritesViewModel>(context);
    final supVM = context.watch<SuppliesViewModel>();
    final favourites = vm.supplyFavouritesData?.supplyFavorites;

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
      body: favourites?.length == 0
          ? Center(child: Text("No Favourites"))
          : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: favourites?.length,
            itemBuilder: (context, index) {
              final item = favourites?[index];
          
              return FavouriteCard(
                isSelected: false,
                productId: '',
                productName: item?.supply?.name ?? "",
                companyName:
                    item?.supply?.dentalSupplier?.businessName ?? "",
                addedOn: item?.updatedAt ?? "",
                availability:
                    item?.supplyVariant?.availableStock.toString() ?? "",
                price: '',
                quantity: vm.quantityFor(item?.supply?.id ?? ''),
                onDecrease: () {
                  vm.decreaseQuantity(item?.supply?.id ?? '');
                },
                onIncrease: () {
                  vm.increaseQuantity(item?.supply?.id ?? '');
                },
                onFavourite: () {
                  vm.deleteFavourite(context, item?.supply?.id ?? '',
                      item?.supplyVariant?.id ?? "");
                },
                imageUrl: item?.supply?.image?.first.url ?? "",
                onCartTap: () async {
                  final supplyId = item?.supply?.id ?? "";
                  final variantId = item?.supplyVariant?.id ?? "";
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
                },
              );
            },
          ),
    );
  }
}
