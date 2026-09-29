import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/my_orders/view_model/my_orders_view_model.dart';
import 'package:di360_flutter/feature/my_orders/widgets/my_order_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<MyOrdersViewModel>();
      if (vm.suppliesOrdersData == null) {
        vm.getSuppliesOrders(context);
      }
    });
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      context.read<MyOrdersViewModel>().getSuppliesOrders(
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
    final vm = context.watch<MyOrdersViewModel>();
    final orders = vm.suppliesOrdersData?.suppliesOrders ?? [];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
              onPressed: () {
                navigationService.goBack();
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text(
            "My Orders",
            style: TextStyles.bold3(),
          )),
      body: orders.isEmpty
          ? Center(
              child: vm.isLoading
                  ? const CircularProgressIndicator()
                  : Text("No Orders"),
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
                return MyOrderCard(item: item);
              },
            ),
    );
  }
}
