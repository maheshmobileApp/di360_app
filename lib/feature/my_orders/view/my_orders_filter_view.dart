import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/my_orders/view_model/my_orders_view_model.dart';
import 'package:di360_flutter/feature/my_orders/widgets/date_range_field.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/widgets/app_button.dart';

class MyOrdersFilterView extends StatelessWidget {
  const MyOrdersFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MyOrdersViewModel>();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        title: "My Orders Filters",
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
              hintText: "Search Orders",
              searchButton: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  _orderStatus(vm),
                  SizedBox(height: 8),
                  _supplierName(vm),
                  SizedBox(height: 16),
                  DateRangeField(
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                    onChanged: (range) {
                      if (range != null) {
                        print('Start: ${range.start}');
                        print('End: ${range.end}');
                      } else {
                        print('Date range cleared');
                      }
                    },
                  ),
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
                    await vm.getSuppliesOrders(context);
                    navigationService.goBack();
                  },
                ),
                AppButton(
                  text: 'Apply',
                  height: 40,
                  width: 150,
                  onTap: () async {
                    await vm.getSuppliesOrders(context);

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

Widget _orderStatus(MyOrdersViewModel vm) {
  final orderStatuses = vm.orderStatuses;

  final selectedValue = orderStatuses.contains(vm.selectedOrderStatus)
      ? vm.selectedOrderStatus
      : null;

  return CustomDropDown(
    value: selectedValue,
    title: "",
    onChanged: (v) {
      vm.setSelectedOrderStatus(v as String);
    },
    items: orderStatuses.map<DropdownMenuItem<Object>>((String value) {
      return DropdownMenuItem<Object>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    hintText: "Select order status",
    validator: (value) => value == null || value.toString().isEmpty
        ? 'Please select order status'
        : null,
  );
}

Widget _supplierName(MyOrdersViewModel vm) {
  final supplierNamesById = <String, String>{};
  for (final supplier in vm.suppliersData?.dentalSuppliers ?? []) {
    final id = supplier.id;
    final name = supplier.name;
    if (id != null && id.isNotEmpty && name != null && name.isNotEmpty) {
      supplierNamesById[id] = name;
    }
  }

  final selectedValue = supplierNamesById.containsKey(vm.selectedSupplierId)
      ? vm.selectedSupplierId
      : null;

  return CustomDropDown(
    value: selectedValue,
    title: "",
    onChanged: (v) {
      final id = v as String;
      vm.setSelectedSupplier(id, supplierNamesById[id]!);
    },
    items: supplierNamesById.entries.map<DropdownMenuItem<Object>>((entry) {
      return DropdownMenuItem<Object>(
        value: entry.key,
        child: Text(entry.value),
      );
    }).toList(),
    hintText: "Select supplier name",
    validator: (value) => value == null || value.toString().isEmpty
        ? 'Please select supplier name'
        : null,
  );
}
