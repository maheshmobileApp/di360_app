import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/my_favourites/view_model/my_favourites_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/widgets/app_button.dart';

class FavouriteFilterView extends StatelessWidget {
  const FavouriteFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MyFavouritesViewModel>();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        title: "My Favourites Filters",
        notification: false,
        logo: false,
        searchWidget: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SearchWidget(
              controller: vm.searchController,
              hintText: "Search product name etc...",
              searchButton: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  _supplierName(vm),
                  SizedBox(height: 16),
                  _availableStock(vm),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppButton(
                  text: 'Clear',
                  btnColor: AppColors.whiteColor,
                  btnTextColor: AppColors.primaryColor,
                  height: 40,
                  width: 150,
                  onTap: () async {
                    await vm.clearFilters();
                    vm.setFilterApply(false);
                    await vm.getSupplyFavourites(context);
                    navigationService.goBack();
                  },
                ),
                AppButton(
                  text: 'Apply',
                  height: 40,
                  width: 150,
                  onTap: () async {
                    await vm.getSupplyFavourites(context);
                    vm.setFilterApply(true);
                    navigationService.goBack();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _supplierName(MyFavouritesViewModel vm) {
  // Build unique supplier id->name map from favourites
  final Map<String, String> supplierMap = {};
  for (final a in vm.supplyFavouritesData?.supplyFavorites ?? []) {
    final supplier = a.supply?.dentalSupplier;
    if (supplier?.id != null && supplier?.businessName != null) {
      supplierMap[supplier!.id!] = supplier.businessName!;
    }
  }

  final items = [
    const DropdownMenuItem<String>(value: null, child: Text('All Suppliers')),
    ...supplierMap.entries.map(
      (e) => DropdownMenuItem<String>(value: e.key, child: Text(e.value)),
    ),
  ];

  return CustomDropDown<String>(
    value: vm.selectedSupplierId,
    title: "",
    onChanged: (v) =>
        vm.setSelectedSupplier(v, v != null ? supplierMap[v] : null),
    items: items,
    hintText: "Select supplier name",
  );
}

Widget _availableStock(MyFavouritesViewModel vm) {
  final items = vm.stockOptions
      .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
      .toList();

  return CustomDropDown<String>(
    value: vm.selectedStock,
    title: "",
    onChanged: (v) => vm.setSelectedStock(v),
    items: items,
    hintText: "Select stock availability",
  );
}
