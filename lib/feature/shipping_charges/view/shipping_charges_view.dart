import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/shipping_charges/view_model/shipping_charges_view_model.dart';
import 'package:di360_flutter/feature/shipping_charges/widgets/supplies_charges_card.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingChargesView extends StatefulWidget {
  const ShippingChargesView({super.key});

  @override
  State<ShippingChargesView> createState() => _SuppliesModuleViewState();
}

class _SuppliesModuleViewState extends State<ShippingChargesView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<ShippingChargesViewModel>();
      if (vm.shippingChargesData == null) {
        vm.getShippingCharges(context);
      }
    });
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      context.read<ShippingChargesViewModel>().getShippingCharges(context);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ShippingChargesViewModel>();
    final orders = vm.shippingChargesData?.freightRanges ?? [];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        title: "Shipping Range",
        notification: false,
        logo: false,
        searchWidget: false,
      ),
      body: orders.isEmpty
          ? Center(
              child: vm.isLoading
                  ? const CircularProgressIndicator()
                  : Text("No Shipping Range's"),
            )
          : ListView.builder(
              controller: scrollController,
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
                return ShippingMethodCard(
                  title: item.shippingRule?? "",
                  minOrderVal: item.minOrderValue ?? 0,
                  standardPrice: item.shippingCost,
                  expressPrice: item.expressPostCost ?? 0,
                  status: item.isActive == true ? "ACTIVE" : "Inactive",
                  minProducts: item.minNoProducts?? 0,
                  
                );
              },
            ),
    );
  }
}
