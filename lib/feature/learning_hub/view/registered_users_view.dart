import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/registered_user_card.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
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
    final courseListingVM = Provider.of<CourseListingViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(title: 'Registered Users'),
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
