import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/jiffy_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsPanel extends StatelessWidget with BaseContextHelpers {
  const NotificationsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationVM = Provider.of<NotificationViewModel>(context);
    return Drawer(
      backgroundColor: AppColors.whiteColor,
      elevation: 16,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Notifications',
                style: TextStyles.bold4(color: AppColors.black),
              ),
              leading: GestureDetector(
                  onTap: () => navigationService.goBack(),
                  child: Icon(Icons.close)),
            ),
            notificationVM.notificationsList?.length == 0
                ? Column(
                    children: [
                      addVertical(getSize(context).height * 0.4),
                      Center(
                        child: Text('No Notifications',
                            style: TextStyles.bold4(color: AppColors.black)),
                      ),
                    ],
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: notificationVM.notificationsList?.length,
                      itemBuilder: (context, index) {
                        final notification =
                            notificationVM.notificationsList?[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(jiffyDataWidget(
                                    notification?.createdAt ?? '',
                                    format: 'dd-MM-yyyy hh:mm a')),
                              ),
                            ),
                            addVertical(10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(notification?.title ?? '',
                                  style: TextStyles.regular2(
                                      color: AppColors.primaryColor)),
                            ),
                            addVertical(10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(notification?.body ?? '',
                                  style: TextStyles.regular2(
                                      color: AppColors.black)),
                            ),
                            addVertical(8),
                          /*  Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    notificationVM.updateMarkAsReadNotification(
                                        context, notification?.id ?? '');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.hintColor,
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      child: Text(
                                        'Mark as read',
                                        style: TextStyles.regular2(
                                            color: AppColors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),*/
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

/*
mutation update_dental_supplier_notifications {
  update_dental_supplier_notifications(where: {}, _set: {mark_as_read: true}) {
    affected_rows
    __typename
  }
}

*/
