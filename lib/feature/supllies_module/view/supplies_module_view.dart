import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
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
      //context.read<SuppliesModuleViewModel>().getSuppliesList(context);
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
      body: Column(
        children: [
          suppliesStatus(vm),
          Expanded(
            child: orders.isEmpty
                ? Center(
                    child: vm.isLoading
                        ? const CircularProgressIndicator()
                        : const Text("No Supplies"),
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
                              await vm.getSuppliesDetails(
                                  item.id ?? "", context);
                              navigationService
                                  .navigateTo(RouteList.suppliesDetailView);

                              break;
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  SizedBox suppliesStatus(SuppliesModuleViewModel vm) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vm.suppliesStatus.length,
        itemBuilder: (context, index) {
          String status = vm.suppliesStatus[index];
          bool isSelected = vm.selectedSuppliesStatus == status;
          return GestureDetector(
            onTap: () {
              vm.changeSuppliesStatus(status, context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.primaryColor : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Row(
                children: [
                  Text(
                    status,
                    style: TextStyles.regular2(
                      color:
                          isSelected ? AppColors.whiteColor : AppColors.black,
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${vm.statusSuppliersCountMap[status]}",
                      style: TextStyles.regular2(
                        color:
                            isSelected ? AppColors.black : AppColors.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
