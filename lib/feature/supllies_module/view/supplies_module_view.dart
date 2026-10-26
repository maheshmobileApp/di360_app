import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/supllies_module/view_model/supplies_module_view_model.dart';
import 'package:di360_flutter/feature/supllies_module/widgets/supplies_module_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SuppliesModuleView extends StatefulWidget {
  const SuppliesModuleView({super.key});

  @override
  State<SuppliesModuleView> createState() => _SuppliesModuleViewState();
}

class _SuppliesModuleViewState extends State<SuppliesModuleView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<SuppliesModuleViewModel>();
      if (vm.getSupplyData == null) {
        vm.getSuppliesList(context);
      }
    });
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      context.read<SuppliesModuleViewModel>().getSuppliesList(context);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesModuleViewModel>();
    final orders = vm.getSupplyData?.supplies ?? [];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
          title: "Supplies",
          notification: false,
          logo: false,
          searchWidget: false,
          filterWidget: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  Loaders.circularShowLoader(context);
                  await vm.getSupplyBrands();
                  await vm.getSupplyCategories();
                  await vm.getSupplySubCategories();
                  Loaders.circularHideLoader(context);
                  navigationService
                      .navigateTo(RouteList.suppliesModuleFilterView);
                },
                child:
                    SvgPicture.asset(ImageConst.filter, color: AppColors.black),
              ),
              if (vm.isFilterApplied)
                GestureDetector(
                    onTap: () async {
                      vm.setFilterApply(false);
                      await vm.clearFilters();
                      vm.getSuppliesList(context);
                    },
                    child: Icon(Icons.close, color: AppColors.black))
            ],
          )),
      body: orders.isEmpty
          ? Center(
              child: vm.isLoading
                  ? const CircularProgressIndicator()
                  : Text("No Supplies"),
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
                return SuppliesModuleCard(
                  item: item,
                  onMenuSelected: (value) async {
                    switch (value) {
                      case "view":
                        //await vm.viewOrder(context, item.id ?? "");
                        navigationService.navigateTo(RouteList.orderDetailView);
                        break;
                    }
                  },
                );
              },
            ),
    );
  }
}
