import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/promotion_card.dart';
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
          scaffoldMessenger("Give your course more visibility! Visit our Web Platform to create and manage your promotions.");
        },
        child: SvgPicture.asset(ImageConst.addFeed),
      ),
      body: vm.coursePromotionData?.coursePromotions?.isEmpty ?? false
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
              itemCount: vm.coursePromotionData?.coursePromotions?.length,
              itemBuilder: (context, index) {
                final userData =
                    vm.coursePromotionData?.coursePromotions?[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
    );
  }
}
