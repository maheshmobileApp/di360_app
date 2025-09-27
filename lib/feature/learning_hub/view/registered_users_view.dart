import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/registered_user_card.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class RegisteredUsersView extends StatefulWidget {
  const RegisteredUsersView({super.key});

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
    final notificationVM = Provider.of<NotificationViewModel>(context);
    final courseListingVM = Provider.of<CourseListingViewModel>(context);
    final newCourseVM = Provider.of<NewCourseViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Stack(
          clipBehavior: Clip.none,
          children: [
            Text(
              'Registered Users',
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
                              child: Text('${notificationVM.notificationCount}',
                                  style: TextStyles.medium1(
                                      color: AppColors.whiteColor))))
                  ],
                )),
          ),
          addHorizontal(30),
        ],
      ),
      body: Column(
        children: [
          Divider(),
          Expanded(
            child: courseListingVM.registeredUsers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Data.",
                          style: TextStyles.medium2(color: AppColors.black),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: courseListingVM.registeredUsers.length,
                    itemBuilder: (context, index) {
                      final userData = courseListingVM.registeredUsers[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: RegisteredUserCard(
                          userPhone: userData.phoneNumber.toString(),
                          userName:
                              "${userData.firstName ?? ""} ${userData.lastName ?? ""}",
                          userMail: userData.email ?? "",
                          imageUrl: '',
                          description: userData.description ?? '',
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
