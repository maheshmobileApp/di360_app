import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/add_news_feed_view_model.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/news_feed_data_card.dart';
import 'package:di360_flutter/feature/news_feed/view/notifaction_panel.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NewsFeedScreen extends StatelessWidget with BaseContextHelpers {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final categoryVM = Provider.of<AddNewsFeedViewModel>(context);
    final newsFeedVM = Provider.of<NewsFeedViewModel>(context);
    final notificationVM = Provider.of<NotificationViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        endDrawer: NotificationsPanel(),
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
                                    style: TextStyles.medium1(
                                        color: AppColors.whiteColor))))
                    ],
                  )),
            ),
            addHorizontal(15),
            SvgPicture.asset(ImageConst.search, color: AppColors.black),
            addHorizontal(15),
            GestureDetector(
                onTapDown: (TapDownDetails details) {
                  final offset = details.globalPosition;
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    items: newsFeedVM.newsfeedCategories
                            ?.map((v) => PopupMenuItem(
                                  value: v,
                                  child: Text(
                                    v.categoryName ?? '',
                                    style: TextStyles.semiBold(
                                        color: AppColors.black, fontSize: 14),
                                  ),
                                ))
                            .toList() ??
                        [],
                  ).then((value) {
                    if ((value as dynamic)?.categoryName == 'Catalog') {
                      newsFeedVM.basedOnCategoriesGetFeeds(context, true, '');
                    } else {
                      newsFeedVM.basedOnCategoriesGetFeeds(
                          context, false, (value as dynamic)?.id);
                    }
                  });
                },
                child: SvgPicture.asset(ImageConst.filter,
                    color: AppColors.black)),
            if (newsFeedVM.applyCatageories)
              Row(
                children: [
                  addHorizontal(10),
                  GestureDetector(
                      onTap: () {
                        homeViewModel.getAllNewsfeeds(context);
                        newsFeedVM.updateApplyCatageories(false);
                      },
                      child: Icon(Icons.close, color: AppColors.black))
                ],
              ),
            addHorizontal(15)
          ],
        ),
        body: Column(
          children: [
            Container(color: AppColors.whiteColor, child: Divider()),
            Expanded(
              child: homeViewModel.allNewsFeedsData?.newsfeeds?.length == 0
                  ? Center(
                      child: Text('No Data',
                          style: TextStyles.clashSemiBold(
                              color: AppColors.black, fontSize: 20)))
                  : ListView.builder(
                      itemCount:
                          homeViewModel.allNewsFeedsData?.newsfeeds?.length,
                      itemBuilder: (context, index) {
                        final newsData =
                            homeViewModel.allNewsFeedsData?.newsfeeds?[index];
                        return NewsFeedDataCard(newsfeeds: newsData);
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: AppColors.primaryColor,
          onPressed: () async {
            await categoryVM.fetchNewsfeedCategories();
            navigationService.navigateTo(RouteList.addNewsFeed);
          },
          child: SvgPicture.asset(ImageConst.addFeed),
        ));
  }
}
