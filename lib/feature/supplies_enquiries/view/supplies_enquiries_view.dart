import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/supplies_enquiries/view_model/supplies_enquiries_view_model.dart';
import 'package:di360_flutter/feature/supplies_enquiries/widgets/supplies_enquiry_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SuppliesEnquiriesView extends StatefulWidget {
  const SuppliesEnquiriesView({super.key});

  @override
  State<SuppliesEnquiriesView> createState() => _SuppliesEnquiriesViewState();
}

class _SuppliesEnquiriesViewState extends State<SuppliesEnquiriesView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<SuppliesEnquiriesViewModel>();
      if (vm.suppliesEnquiriesData == null) {
        vm.getSuppliesEnquiries(context);
      }
    });
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      context
          .read<SuppliesEnquiriesViewModel>()
          .getSuppliesEnquiries(context, isLoadMore: true);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesEnquiriesViewModel>();
    final enquiries = vm.suppliesEnquiriesData?.supplyEnquiries ?? [];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
          title: "Enquiries",
          notification: false,
          logo: false,
          searchWidget: true,
          searchBarOpen: true,
          /*filterWidget: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  Loaders.circularShowLoader(context);
                  /*await vm.getSupplyBrands();
                  await vm.getSupplyCategories();
                  await vm.getSupplySubCategories();*/
                  Loaders.circularHideLoader(context);
                  navigationService
                      .navigateTo(RouteList.suppliesModuleFilterView);
                },
                child:
                    SvgPicture.asset(ImageConst.filter, color: AppColors.black),
              ),
              /*if (vm.isFilterApplied)
                GestureDetector(
                    onTap: () async {
                      vm.setFilterApply(false);
                      await vm.clearFilters();
                      vm.getSuppliesList(context);
                    },
                    child: Icon(Icons.close, color: AppColors.black))*/
            ],
          )*/),
      body: Column(
        children: [
          Expanded(
            child: enquiries.isEmpty
                ? Center(
                    child:const Text("No Enquiries Found"),
                  )
                : ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: enquiries.length + (vm.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == enquiries.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final item = enquiries[index];
                      return SuppliesEnquiryCard(
                          item: item,
                          onMenuSelected: (action) async {
                            switch (action) {
                              case "view":
                                await vm.suppliesEnquiryDetails(context, item.id?? "");
                                navigationService.navigateTo(
                                    RouteList.suppliesEnquiriesDetailView);
                                break;
                            }
                          });
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
