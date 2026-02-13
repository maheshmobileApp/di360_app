import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/news_feed/model_class/get_notification_res.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/notifications/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/notificatoin_type_enum.dart';
import 'package:di360_flutter/widgets/jiffy_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with BaseContextHelpers {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notificationVM =
          Provider.of<NotificationViewModel>(context, listen: false);
      notificationVM.getNotifications(context, isRefresh: true);
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final notificationVM =
          Provider.of<NotificationViewModel>(context, listen: false);
      notificationVM.getNotifications(context);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationVM = Provider.of<NotificationViewModel>(context);
    final catalogueVM = Provider.of<CatalogueViewModel>(context);
    final newsFeedProvider = Provider.of<NewsFeedViewModel>(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Notifications',
              style: TextStyles.medium3(color: AppColors.black)),
          leading: InkWell(
              onTap: () => navigationService.goBack(),
              child: Icon(Icons.arrow_back, color: AppColors.black))),
      body: RefreshIndicator(
        onRefresh: () async {
          await notificationVM.getNotifications(context, isRefresh: true);
        },
        child: notificationVM.notificationsList.isEmpty &&
                !notificationVM.isLoadingMore
            ? Center(
                child: Column(
                  children: [
                    addVertical(getSize(context).height * 0.4),
                    Text('No Notifications',
                        style: TextStyles.bold4(color: AppColors.black)),
                  ],
                ),
              )
            : ListView.builder(
                controller: _scrollController,
                itemCount: notificationVM.notificationsList.length +
                    (notificationVM.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == notificationVM.notificationsList.length) {
                    return Center(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CircularProgressIndicator()));
                  }
                  final notification = notificationVM.notificationsList[index];
                  return GestureDetector(
                      onTap: () async {
                        if (notification.type ==
                            NotificationType.NEWS_FEED.name) {
                          notificationVM.getNewsFeedData(
                              context, notification.payload?.id ?? '');
                        } else if (notification.type ==
                            NotificationType.SUPPORT_REQUEST.name) {
                          navigationService.navigateTo(RouteList.supportScreen);
                        } else if (notification.type ==
                            NotificationType.COMMUNITY.name) {
                        } else if (notification.type ==
                            NotificationType.CATALOGUE.name) {
                          await catalogueVM.getCatalogDetails(
                              context, notification.payload?.id ?? '');
                          final id = catalogueVM
                                  .cataloguesByIdData?.catalogueCategoryId ??
                              '';
                          await catalogueVM.getReletedCatalog(context, id);
                          await navigationService
                              .navigateTo(RouteList.catalogueDetails);
                        } else if (notification.type ==
                            NotificationType.COURSE.name) {
                        } else if (notification.type ==
                            NotificationType.APPOINTMENT.name) {
                          navigationService.navigateTo(RouteList.myAppointment);
                        } else if (notification.type ==
                            NotificationType.JOB.name) {
                          newsFeedProvider.getJobDetailsByIds(
                              context, notification.payload?.id ?? '');
                        }else if (notification.type ==
                            NotificationType.TALENT.name) {
                          
                        }
                      },
                      child: _notificationCard(context, notification));
                },
              ),
      ),
    );
  }

  Widget _notificationCard(BuildContext context, Notifications notification) {
    final unread = notification.markAsRead;
    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color:
                unread == false ? AppColors.greenColor : AppColors.geryColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.remove_red_eye,
              color:
                  unread == false ? AppColors.greenColor : AppColors.geryColor),
          addHorizontal(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(notification.title ?? '',
                            style: TextStyles.medium2(
                                color: AppColors.secondaryColor))),
                    addHorizontal(6),
                    if (unread != true) ...[
                      addHorizontal(6),
                      Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              shape: BoxShape.circle))
                    ]
                  ],
                ),
                addVertical(6),
                Text(jiffyDataWidget(notification.createdAt),
                    style:
                        TextStyles.regular2(color: AppColors.lightGeryColor)),
                addVertical(10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // AppButton(
                      //     text: AppLocalizations.of(context)!.viewAnalytics,
                      //     width: 120,
                      //     height: 35,
                      //     radius: 8,
                      //     btnColor: AppColors.whiteColor,
                      //     txtColor: AppColors.brightGreenColor,
                      //     borderColor: AppColors.brightGreenColor),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
