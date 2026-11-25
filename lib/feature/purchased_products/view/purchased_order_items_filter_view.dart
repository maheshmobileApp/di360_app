import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/purchased_products/view_model/purchased_order_tems_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/widgets/app_button.dart';

class PurchasedOrderItemsFilterView extends StatelessWidget {
  const PurchasedOrderItemsFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PurchasedOrderTemsViewModel>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        title: "Purchased Products Filters",
        notification: false,
        logo: false,
        searchWidget: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                    SizedBox(height: 8),
                    _brandName(vm),
                    SizedBox(height: 8),
                    _categoryName(vm),
                    SizedBox(height: 8),
                    _availableStock(vm),
                    SizedBox(height: 8),
                    CustomDatePicker(
                      controller: vm.startDateController,
                      title: "Start Date",
                      hintText: "Select start date",
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          vm.setStartDate(picked);
                        } else {
                          vm.clearDates();
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    CustomDatePicker(
                      controller: vm.startDateController,
                      title: "End Date",
                      hintText: "Select end date",
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          vm.setEndDate(picked);
                        } else {
                          vm.clearDates();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
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
                      await vm.getPurchasedOrderItems(context);
                      navigationService.goBack();
                    },
                  ),
                  AppButton(
                    text: 'Apply',
                    height: 40,
                    width: 150,
                    onTap: () async {
                      await vm.getPurchasedOrderItems(context);
                      vm.setFilterApply(true);
                      navigationService.goBack();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _supplierName(PurchasedOrderTemsViewModel vm) {
  final Map<String, String> supplierMap = {};
  for (final a in vm.purchasedOrderItemsData?.suppliesOrderItems ?? []) {
    final supplier = a.suppliesOrder?.supplier;
    if (supplier?.id != null && supplier?.businessName != null) {
      supplierMap[supplier!.id!] = supplier.businessName!;
    }
  }

  final selectedValue = vm.selectedSupplierId.isNotEmpty &&
          supplierMap.containsKey(vm.selectedSupplierId)
      ? vm.selectedSupplierId
      : null;

  final items = [
    const DropdownMenuItem<String>(value: null, child: Text('All Suppliers')),
    ...supplierMap.entries.map(
      (e) => DropdownMenuItem<String>(value: e.key, child: Text(e.value)),
    ),
  ];

  return CustomDropDown<String>(
    value: selectedValue,
    title: "",
    onChanged: (v) =>
        vm.setSelectedSupplier(v, v != null ? supplierMap[v] : null),
    items: items,
    hintText: "Select supplier name",
  );
}

Widget _brandName(PurchasedOrderTemsViewModel vm) {
  final brands = (vm.purchasedOrderItemsData?.suppliesOrderItems ?? [])
      .map((a) => a.supply?.supplyBrand?.name)
      .whereType<String>()
      .toSet()
      .toList();

  final selectedValue =
      vm.selectedBrand.isNotEmpty && brands.contains(vm.selectedBrand)
          ? vm.selectedBrand
          : null;

  return CustomDropDown<String>(
    value: selectedValue,
    title: "",
    onChanged: (v) => vm.setSelectedBrand(v),
    items: [
      const DropdownMenuItem<String>(value: null, child: Text('All Brands')),
      ...brands.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))),
    ],
    hintText: "Select brand",
  );
}

Widget _categoryName(PurchasedOrderTemsViewModel vm) {
  final categories = (vm.purchasedOrderItemsData?.suppliesOrderItems ?? [])
      .map((a) => a.supply?.supplyCategory?.name)
      .whereType<String>()
      .toSet()
      .toList();

  final selectedValue =
      vm.selectedCategory.isNotEmpty && categories.contains(vm.selectedCategory)
          ? vm.selectedCategory
          : null;

  return CustomDropDown<String>(
    value: selectedValue,
    title: "",
    onChanged: (v) => vm.setSelectedCategory(v),
    items: [
      const DropdownMenuItem<String>(
          value: null, child: Text('All Categories')),
      ...categories
          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e))),
    ],
    hintText: "Select category",
  );
}

Widget _availableStock(PurchasedOrderTemsViewModel vm) {
  final items = vm.stockOptions
      .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
      .toList();

  return CustomDropDown<String>(
    value: vm.selectedStock,
    title: "",
    onChanged: (v) => vm.setSelectedStock(v ?? ""),
    items: items,
    hintText: "Select stock availability",
  );
}
