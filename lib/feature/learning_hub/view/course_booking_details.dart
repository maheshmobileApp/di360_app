import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/configuration/app_config.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view/notification_view.dart';
import 'package:di360_flutter/feature/learning_hub/view/promotion_view.dart';
import 'package:di360_flutter/feature/learning_hub/view/registered_users_view.dart';
import 'package:di360_flutter/feature/learning_hub/view/transactions_view.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/booking_url_card.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseBookingDetails extends StatefulWidget {
  final String courseId;
  final String? courseStatus;

  const CourseBookingDetails({
    super.key,
    required this.courseId,
    this.courseStatus,
  });

  @override
  State<CourseBookingDetails> createState() => _CourseBookingDetailsState();
}

class _CourseBookingDetailsState extends State<CourseBookingDetails>
    with BaseContextHelpers {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<CourseListingViewModel>(context, listen: false);
      vm.setSelectedModuleType('Course Details', context, widget.courseId);
      vm.courseById(context, widget.courseId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CourseListingViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        logo: false,
        title: 'Course Booking Details',
        searchWidget: false,
      ),
      body: Column(
        children: [
          _tabBar(vm),
          const Divider(height: 1),
          Expanded(child: _tabContent(vm)),
        ],
      ),
    );
  }

  Widget _tabContent(CourseListingViewModel vm) {
    switch (vm.selectedModuleType) {
      case 'Course Bookings':
        return RegisteredUsersView(courseId: widget.courseId, courseStatus: widget.courseStatus);
      case 'Notification':
        return NotificationView();
      case 'Promotion':
        return PromotionView();
      case 'Transaction':
        return TransactionsView();
      case 'Course Details':
      default:
        return BookingUrlCard(
            bookingUrl:
                '${AppConfig.serverBaseUrl}/api/v1/link/cb/${vm.courseData?.coursesByPk?.shortCode ?? ''}');
    }
  }

  Widget _msgText(String label) => Center(
        child:
            Text('$label', style: TextStyles.medium2(color: AppColors.black)),
      );

  Widget _tabBar(CourseListingViewModel vm) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vm.moduleTypes.length,
        itemBuilder: (context, index) {
          final tab = vm.moduleTypes[index];
          final isSelected = vm.selectedModuleType == tab;
          return GestureDetector(
            onTap: () =>
                vm.setSelectedModuleType(tab, context, widget.courseId),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.primaryColor : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Text(
                tab,
                style: TextStyles.regular2(
                  color: isSelected ? AppColors.whiteColor : AppColors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
