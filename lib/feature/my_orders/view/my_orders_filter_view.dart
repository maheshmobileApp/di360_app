import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/my_orders/view_model/my_orders_view_model.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
             SizedBox(height: 8),
            _orderStatus(vm),
            SizedBox(height: 8),
            _supplierName(vm)
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
    title: "Order Status",
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
  final orderStatuses = vm.orderStatuses;

  final selectedValue = orderStatuses.contains(vm.selectedOrderStatus)
      ? vm.selectedOrderStatus
      : null;

  return CustomDropDown(
    value: selectedValue,
    title: "Supplier Name",
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
