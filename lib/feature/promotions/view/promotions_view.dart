import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/promotions/view_model/promotions_view_model.dart';
import 'package:di360_flutter/feature/promotions/widgets/promotion_card.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionsView extends StatefulWidget {
  const PromotionsView({super.key});

  @override
  State<PromotionsView> createState() => _SuppliesModuleViewState();
}

class _SuppliesModuleViewState extends State<PromotionsView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<PromotionsViewModel>();
      if (vm.getPromotionsData == null) {
        vm.getPromotions(context);
      }
    });
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      context
          .read<PromotionsViewModel>()
          .getPromotions(context, isLoadMore: true);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PromotionsViewModel>();
    final promotions = vm.getPromotionsData?.supplyPromotions ?? [];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        title: "Promotions",
        notification: false,
        logo: false,
        searchWidget: false,
      ),
      body: Column(
        children: [
          promotionStatus(vm),
          Expanded(
            child: promotions.isEmpty
                ? Center(
                    child: vm.isLoading
                        ? const CircularProgressIndicator()
                        : const Text("No Promotions Found"),
                  )
                : ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: promotions.length + (vm.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == promotions.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final item = promotions[index];
                      return PromotionCard(
                        item: item,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  SizedBox promotionStatus(PromotionsViewModel vm) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vm.promotionsStatus.length,
        itemBuilder: (context, index) {
          String status = vm.promotionsStatus[index];
          bool isSelected = vm.selectedPromotionsStatus == status;
          return GestureDetector(
            onTap: () {
              vm.changePromotionStatus(status, context);
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
                      "${vm.statusPromotionCountMap[status]}",
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
