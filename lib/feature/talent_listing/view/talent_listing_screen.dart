import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/feature/talent_listing/view/talent_listing_card.dart';
import 'package:di360_flutter/feature/talent_listing/view_model/talent_listing_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TalentListingScreen extends StatefulWidget {
  const TalentListingScreen({super.key});

  @override
  State<TalentListingScreen> createState() => _TalentListingScreenState();
}

class _TalentListingScreenState extends State<TalentListingScreen>
    with BaseContextHelpers {
  @override
  Widget build(BuildContext context) {
    final notificationVM = Provider.of<NotificationViewModel>(context);
    final vm = Provider.of<TalentListingViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Stack(
          clipBehavior: Clip.none,
          children: [
            Text(
              'Dental Interface',
              style: TextStyles.bold4(color: AppColors.black),
            ),
            Positioned(
              top: -9,
              right: -18,
              child: SvgPicture.asset(
                ImageConst.logo,
                height: 20,
                width: 20,
              ),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(ImageConst.notification,
                      color: AppColors.black),
                  if (notificationVM.notificationCount != 0)
                    Positioned(
                      top: -16,
                      right: -13,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: AppColors.primaryColor,
                        child: Text(
                          '${notificationVM.notificationCount}',
                          style:
                              TextStyles.medium1(color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          addHorizontal(15),
          SvgPicture.asset(ImageConst.search, color: AppColors.black),
          addHorizontal(15),
          GestureDetector(
            onTap: () =>
                navigationService.navigateTo(RouteList.TalentListingFilter),
            child: SvgPicture.asset(ImageConst.filter, color: AppColors.black),
          ),
          addHorizontal(15),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: vm.statuses.length,
              itemBuilder: (context, index) {
                String status = vm.statuses[index];
                bool isSelected = vm.selectedStatus == status;
                return GestureDetector(
                  onTap: () {
                    vm.changeStatus(status, context);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Row(
                      children: [
                        Text(
                          status,
                          style: TextStyles.regular2(
                            color: isSelected
                                ? AppColors.whiteColor
                                : AppColors.black,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.whiteColor
                                : AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${vm.statusCountMap[status] ?? 0}",
                            style: TextStyles.regular2(
                              color: isSelected
                                  ? AppColors.black
                                  : AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: vm.myTalentListingList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Talents Found",
                          style: TextStyles.medium2(color: AppColors.black),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: vm.myTalentListingList.length,
                    itemBuilder: (context, index) {
                      final jobData = vm.myTalentListingList[index];
                      try {
                        return TalentListingCard(
                          jobProfiles: jobData,
                          vm: vm,
                          index: index,
                        );
                      } catch (e, st) {
                        debugPrint("🔥 Error in card #$index: $e\n$st");
                        return const Text("Error rendering card");
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
