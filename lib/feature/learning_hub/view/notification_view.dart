import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/notification_campaign_card.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CourseListingViewModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          scaffoldMessenger("Stay connected with your learners! Visit our Web Platform to send emails and keep everyone in the loop.");
        },
        child: SvgPicture.asset(ImageConst.addFeed),
      ),
      body: vm.coursePromotionData?.coursePromotions?.isEmpty ?? false
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No notifications available at the moment",
                    style: TextStyles.medium2(color: AppColors.black),
                  ),
                ],
              ),
            )
          :ListView.builder(
      itemCount: vm.notificationCampaignData?.courseNotificationCampaigns?.length,
      itemBuilder: (context, index) {
        final notificationData = vm.notificationCampaignData?.courseNotificationCampaigns?[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: NotificationCampaignCard(
            notificationData: notificationData,
          ),
        );
      },
    ));
  }
}
