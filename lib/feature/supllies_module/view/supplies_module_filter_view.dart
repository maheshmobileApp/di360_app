import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/supllies_module/view_model/supplies_module_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/widgets/app_button.dart';

class SuppliesModuleFilterView extends StatelessWidget {
  const SuppliesModuleFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesModuleViewModel>();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        title: "Supplies Filters",
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
              hintText: "Search by product name",
              searchButton: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  _productBrand(vm),
                  SizedBox(height: 8),
                  _productCategories(vm),
                  SizedBox(height: 8),
                  _productSubCategories(vm),
                  SizedBox(height: 8),
                  _productType(vm),
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
                    vm.setFilterApply(false);
                    await vm.clearFilters();
                    await vm.getSuppliesList(context);
                    navigationService.goBack();
                  },
                ),
                AppButton(
                  text: 'Apply',
                  height: 40,
                  width: 150,
                  onTap: () async {
                    vm.setFilterApply(true);
                    await vm.getSuppliesList(context);

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

Widget _productBrand(SuppliesModuleViewModel vm) {
  final brands = vm.supplyBrandsData?.supplyBrands ?? [];

  final selectedValue =
      brands.any((b) => b.id == vm.selectedBrandId) ? vm.selectedBrandId : null;

  return CustomDropDown(
    value: selectedValue,
    title: "",
    onChanged: (v) => vm.setSelectedBrand(v as String?),
    items: brands.map<DropdownMenuItem<Object>>((brand) {
      return DropdownMenuItem<Object>(
        value: brand.id,
        child: Text(brand.name ?? ''),
      );
    }).toList(),
    hintText: "Select Brand",
    validator: null,
  );
}

Widget _productCategories(SuppliesModuleViewModel vm) {
  final categories = vm.supplyCategoriesData?.supplyCategories ?? [];
  final selectedValue = categories.any((c) => c.id == vm.selectedCategoryId)
      ? vm.selectedCategoryId
      : null;

  return CustomDropDown(
    value: selectedValue,
    title: "",
    onChanged: (v) => vm.setSelectedCategory(v as String?),
    items: categories.map<DropdownMenuItem<Object>>((category) {
      return DropdownMenuItem<Object>(
        value: category.id,
        child: Text(category.name ?? ''),
      );
    }).toList(),
    hintText: "Select Category",
    validator: null,
  );
}

Widget _productSubCategories(SuppliesModuleViewModel vm) {
  final subCategories = vm.supplySubCategoriesData?.supplySubCategories ?? [];
  final selectedValue =
      subCategories.any((s) => s.id == vm.selectedSubCategoryId)
          ? vm.selectedSubCategoryId
          : null;

  return CustomDropDown(
    value: selectedValue,
    title: "",
    onChanged: (v) => vm.setSelectedSubCategory(v as String?),
    items: subCategories.map<DropdownMenuItem<Object>>((sub) {
      return DropdownMenuItem<Object>(
        value: sub.id,
        child: Text(sub.name ?? ''),
      );
    }).toList(),
    hintText: "Select Sub Category",
    validator: null,
  );
}

Widget _productType(SuppliesModuleViewModel vm) {
  final subCategories = ["Simple Product", "Product with variant"];
  final selectedValue = vm.selectedProductType;

  return CustomDropDown(
    value: selectedValue,
    title: "",
    onChanged: (v) => vm.setSelectedProductType(v as String?),
    items: subCategories.map<DropdownMenuItem<Object>>((sub) {
      return DropdownMenuItem<Object>(
        value: sub,
        child: Text(sub),
      );
    }).toList(),
    hintText: "Select product type",
    validator: null,
  );
}
