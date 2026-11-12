import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/notification_campaign_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late CourseListingViewModel _vm;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _vm = Provider.of<CourseListingViewModel>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.scrollController.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    _vm.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final vm = _vm;
    if (vm.isLoadingMoreNotifications || !vm.hasMoreNotifications)
      return; // guard
    if (vm.scrollController.position.pixels >=
        vm.scrollController.position.maxScrollExtent - 200) {
      vm.notificationCampaigns(context, vm.selectedCourseId, loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CourseListingViewModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          scaffoldMessenger(
              "Stay connected with your learners! Visit our Web Platform to send emails and keep everyone in the loop.");
        },
        child: SvgPicture.asset(ImageConst.addFeed),
      ),
      body: Column(
        children: [
            _filterWidget(vm, context),
          Expanded(
            child: vm.notificationCampaignData?.courseNotificationCampaigns
                        ?.isEmpty ??
                    false
                ? Center(
                    child: Text(
                      "No notifications available at the moment",
                      style: TextStyles.medium2(
                        color: AppColors.black,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: vm.scrollController,
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: vm.notificationCampaignData
                            ?.courseNotificationCampaigns?.length ??
                        0,
                    itemBuilder: (context, index) {
                      final notificationData = vm.notificationCampaignData
                          ?.courseNotificationCampaigns?[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: NotificationCampaignCard(
                          notificationData: notificationData,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
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
          if (vm.notificationFilter)
            InkWell(
              onTap: () async {
                vm.setApplyFilter(false);
                vm.clearNotificationFilters();
                await vm.notificationCampaigns(context, vm.selectedCourseId);
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
              navigationService.navigateTo(RouteList.notificationFilterView);
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
