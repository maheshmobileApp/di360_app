import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/model/filter_category.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/filter_option_list.dart';
import 'package:di360_flutter/feature/supplies/widgets/filter_search_field.dart';
import 'package:di360_flutter/feature/supplies/widgets/filter_section.dart';
import 'package:di360_flutter/feature/supplies/widgets/nested_category_filter.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductFilterResult {
  final String search;
  final RangeValues? priceRange;

  const ProductFilterResult({
    required this.search,
    this.priceRange,
  });
}

class ProductFilterScreen extends StatefulWidget {
  
  final void Function(ProductFilterResult result)? onApply;

  const ProductFilterScreen({
    super.key,
    this.onApply,
  });

  @override
  State<ProductFilterScreen> createState() => _ProductFilterScreenState();
}

class _ProductFilterScreenState extends State<ProductFilterScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesViewModel>();
    final List<String> brands = vm.supplyBrandsData?.supplyBrands
            ?.map((i) => i.name ?? '')
            .where((name) => name.isNotEmpty)
            .toList() ??
        [];

    final categories = (vm.supplyCategoriesData?.supplyCategories ?? [])
        .map((c) => FilterCategory(
              id: c.id ?? '',
              name: c.name ?? '',
              children: (c.supplySubCategories ?? [])
                  .map((s) => FilterCategory(id: s.id ?? '', name: s.name ?? ''))
                  .toList(),
            ))
        .where((c) => c.id.isNotEmpty)
        .toList();

    final List<String> suppliers = vm.dentalSuppliersData?.dentalSuppliers
            ?.map((i) => i.businessName ?? '')
            .where((businessName) => businessName.isNotEmpty)
            .toList() ??
        [];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
              onPressed: () {
                navigationService.goBack();
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text(
            "Filters",
            style: TextStyles.bold3(),
          )),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FilterSearchField(
                      controller: vm.filterSearchController,
                      hint: "Search products...",
                    ),
                  ),
                  FilterSection(
                    title: "Brand",
                    icon: Icons.local_offer,
                    child: FilterOptionsList(
                      options: brands,
                      selected: vm.selectedBrands,
                      searchHint: "Search brand...",
                      onToggle: (value) =>
                          vm.toggleSelection(vm.selectedBrands, value),
                    ),
                  ),
                  FilterSection(
                    title: "Categories",
                    icon: Icons.grid_view,
                    child: NestedCategoryFilter(
                      categories: categories,
                      selectedIds: vm.selectedCategoryIds,
                      onChanged: vm.setSelectedCategoryIds,
                    ),
                  ),
                  FilterSection(
                    title: "Suppliers",
                    icon: Icons.local_shipping,
                    child: FilterOptionsList(
                      options: suppliers,
                      selected: vm.selectedSuppliers,
                      searchHint: "Search suppliers...",
                      onToggle: (value) =>
                          vm.toggleSelection(vm.selectedSuppliers, value),
                    ),
                  ),
                  FilterSection(
                    title: "Price",
                    icon: Icons.sell,
                    trailing: !vm.priceSelected
                        ? const Text(
                            "Any",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                            ),
                          )
                        : null,
                    child: Column(
                      children: [
                        RangeSlider(
                          values: vm.priceRange,
                          min: 0,
                          max: 20000,
                          divisions: 100,
                          activeColor: AppColors.primaryColor,
                          labels: RangeLabels(
                            "₹${vm.priceRange.start.round()}",
                            "₹${vm.priceRange.end.round()}",
                          ),
                          onChanged: (values) {
                            setState(() {
                              vm.priceRange = values;
                              vm.priceSelected = true;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("₹${vm.priceRange.start.round()}"),
                              Text("₹${vm.priceRange.end.round()}"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  FilterSection(
                    title: "Promotions",
                    icon: Icons.star_border,
                    child: FilterOptionsList(
                      options: vm.promotions,
                      selected: vm.selectedPromotions,
                      searchHint: "Search promotions...",
                      onToggle: (value) =>
                          vm.toggleSelection(vm.selectedPromotions, value),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFECEEF2)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        vm.setFilterApply(true);
                        await vm.applyFilters(context); 
                        navigationService.goBack();
                      },
                      icon: const Icon(
                        Icons.filter_alt,
                        size: 17,
                      ),
                      label: const Text("Apply Filters"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        vm.resetFilters();
                        vm.getSuppliers(context);
                        navigationService.goBack();
                      },
                      icon: const Icon(
                        Icons.refresh,
                        size: 16,
                      ),
                      label: const Text("Reset"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        side: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                        minimumSize: const Size(0, 46),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
