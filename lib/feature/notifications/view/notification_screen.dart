import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/notifications/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/notificatoin_type_enum.dart';
import 'package:di360_flutter/widgets/jiffy_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget with BaseContextHelpers {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationVM = Provider.of<NotificationViewModel>(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Notifications',
              style: TextStyles.medium3(color: AppColors.black)),
          leading: InkWell(
              onTap: () => navigationService.goBack(),
              child: Icon(Icons.arrow_back, color: AppColors.black))),
      body: Column(
        children: [
          notificationVM.notificationsList.length == 0
              ? Center(
                child: Column(
                    children: [
                      addVertical(getSize(context).height * 0.4),
                      Center(
                        child: Text('No Notifications',
                            style: TextStyles.bold4(color: AppColors.black)),
                      ),
                    ],
                  ),
              )
              : Expanded(
                  child: ListView.builder(
                    itemCount: notificationVM.notificationsList.length,
                    itemBuilder: (context, index) {
                      final notification =
                          notificationVM.notificationsList[index];
                      return GestureDetector(
                          onTap: () {
                            if (notification.type ==
                                NotificationType.NEWS_FEED.name) {
                              navigationService.goBack();
                            } else if (notification.type ==
                                NotificationType.SUPPORT_REQUEST.name) {
                            } else if (notification.type ==
                                NotificationType.COMMUNITY.name) {
                            } else if (notification.type ==
                                NotificationType.CATALOGUE.name) {
                            } else if (notification.type ==
                                NotificationType.COURSE.name) {
                            } else if (notification.type ==
                                NotificationType.APPOINTMENT.name) {}
                          }, // COMMUNITY , CATALOGUE , COURSE, APPOINTMENT,INFORMATIONAL,JOB
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(jiffyDataWidget(
                                        notification.createdAt ?? '',
                                        format: 'dd-MM-yyyy hh:mm a')),
                                  ),
                                ),
                                addVertical(10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(notification.title ?? '',
                                      style: TextStyles.regular2(
                                          color: AppColors.primaryColor)),
                                ),
                                addVertical(10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(notification.body ?? '',
                                      style: TextStyles.regular2(
                                          color: AppColors.black)),
                                ),
                                addVertical(8),
                                Divider()
                              ]));
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
