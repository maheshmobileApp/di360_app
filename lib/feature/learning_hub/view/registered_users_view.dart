import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/registered_user_card.dart';
import 'package:di360_flutter/feature/news_feed/view/notifaction_panel.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisteredUsersView extends StatefulWidget {
  final String courseId;

  const RegisteredUsersView({
    super.key,
    required this.courseId,
  });

  @override
  State<RegisteredUsersView> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<RegisteredUsersView>
    with BaseContextHelpers {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final courseListingVM = Provider.of<CourseListingViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      endDrawer: NotificationsPanel(),
      appBar: AppBarWidget(
        title: 'Registered Users',
        searchWidget: false,
      ),
      body: Column(
        children: [
          courseStatusWidget(courseListingVM),
          Divider(),
          Expanded(
            child: courseListingVM
                        .registeredUsers?.courseRegisteredUsers?.isEmpty ??
                    false
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No registered users available at the moment",
                          style: TextStyles.medium2(color: AppColors.black),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: courseListingVM
                        .registeredUsers?.courseRegisteredUsers?.length,
                    itemBuilder: (context, index) {
                      final userData = courseListingVM
                          .registeredUsers?.courseRegisteredUsers?[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: RegisteredUserCard(
                            id: userData?.id ?? "",
                            userPhone: userData?.phoneNumber.toString() ?? "",
                            userName:
                                "${userData?.firstName ?? ""} ${userData?.lastName ?? ""}",
                            userMail: userData?.email ?? "",
                            imageUrl: userData?.directoriesSupplier
                                    ?.dentalSupplier?.logo?.url ??
                                "",
                            description: userData?.description ?? '',
                            status: userData?.status ?? '',
                            activeStatus: "",
                            onMenuAction: (action, id) async {
                              switch (action) {
                                case "Approve":
                                  courseListingVM.updateRegUserStatus(context,id,"APPROVED");
                                  break;
                                case "Cancel":
                                courseListingVM.updateRegUserStatus(context,id,"CANCELLED");
                                  break;
                              }
                            }),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  SizedBox courseStatusWidget(CourseListingViewModel courseListingVM) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courseListingVM.regUserStatus.length,
        itemBuilder: (context, index) {
          String status = courseListingVM.regUserStatus[index];
          bool isSelected = courseListingVM.selectedRegUsersStatus == status;
          return GestureDetector(
            onTap: () {
              courseListingVM.changeRegUsersStatus(
                  status, context, widget.courseId);
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
                      "${courseListingVM.statusRegUsersCountMap[status]}",
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
