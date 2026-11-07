import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/promotion_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PromotionView extends StatelessWidget {
  const PromotionView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CourseListingViewModel>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () async {
            scaffoldMessenger(
                "Give your course more visibility! Visit our Web Platform to create and manage your promotions.");
          },
          child: SvgPicture.asset(ImageConst.addFeed),
        ),
        body: Column(
          children: [
            _filterWidget(vm, context),
            Expanded(
              child: vm.coursePromotionData?.coursePromotions?.isEmpty ?? true
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No promotions available at the moment",
                            style: TextStyles.medium2(color: AppColors.black),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          vm.coursePromotionData?.coursePromotions?.length,
                      itemBuilder: (context, index) {
                        final userData =
                            vm.coursePromotionData?.coursePromotions?[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: PromotionCard(
                            serialNo: index + 1,
                            promotionName: userData?.promotionName ?? '',
                            promoCode: userData?.promoCode ?? '',
                            discount: userData?.discountValue.toString() ?? '',
                            validFrom: userData?.validFrom ?? '',
                            validUntil: userData?.validUntil ?? '',
                            status: userData?.status ?? '',
                            courseId: userData?.id ?? '',
                          ),
                        );
                      },
                    ),
            ),
          ],
        ));
  }

  Widget _filterWidget(CourseListingViewModel vm, BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (vm.promotionFilter)
            InkWell(
              onTap: () async {
                vm.setPromotionApplyFilter(false);
                vm.clearPromotionFilters();
                await vm.coursePromotions(context, vm.selectedCourseId);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.close,
                      color: AppColors.primaryColor,
                      size: 22,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Clear",
                      style: TextStyles.medium2(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          InkWell(
            onTap: () {
              navigationService.navigateTo(RouteList.promotionFilterView);
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.filter_alt_outlined,
                    color: AppColors.primaryColor,
                    size: 22,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Filters",
                    style: TextStyles.medium2(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
