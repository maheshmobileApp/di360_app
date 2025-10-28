import 'package:di360_flutter/common/banner/generic_list_view_with_banners.dart';
import 'package:di360_flutter/common/banner/list_banner.dart';
import 'package:di360_flutter/common/banner/utils.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/add_news_feed_view_model.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/news_feed_data_card.dart';
import 'package:di360_flutter/feature/news_feed/view/notifaction_panel.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
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
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        endDrawer: NotificationsPanel(),
        appBar: AppBarWidget(
          filterWidget: Row(
            children: [
              GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    final offset = details.globalPosition;
                    showMenu(
                      context: context,
                      position:
                          RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
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
                                          color:
                                              newsFeedVM.selectedCategoryId ==
                                                      v.id
                                                  ? AppColors.primaryColor
                                                  : AppColors.black,
                                          fontSize: 14,
                                          decoration:
                                              newsFeedVM.selectedCategoryId ==
                                                      v.id
                                                  ? TextDecoration.underline
                                                  : TextDecoration.none,
                                          decorationColor:
                                              AppColors.primaryColor),
                                    ),
                                  ))
                              .toList() ??
                          [],
                    ).then((value) {
                      newsFeedVM.updateSelectedCategory((value as dynamic)?.id);
                      if ((value as dynamic)?.categoryName == 'Catalog') {
                        newsFeedVM.basedOnCategoriesGetFeeds(context, true, '');
                      } else {
                        newsFeedVM.basedOnCategoriesGetFeeds(
                            context, false, value?.id ?? '');
                      }
                    });
                  },
                  child: SvgPicture.asset(ImageConst.filter,
                      color: AppColors.black)),
              if (newsFeedVM.applyCatageories)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                      onTap: () {
                        homeViewModel.getAllNewsfeeds(context);
                        newsFeedVM.updateApplyCatageories(false);
                        newsFeedVM.updateSelectedCategory(null);
                      },
                      child: Icon(Icons.close, color: AppColors.black)),
                )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: homeViewModel.allNewsFeedsData?.newsfeeds?.isEmpty ?? false
                  ? Center(
                      child: Text('No Data',
                          style: TextStyles.clashSemiBold(
                              color: AppColors.black, fontSize: 20)))
                  : GenericListViewWithBanners<Newsfeeds>(
                      items: homeViewModel.allNewsFeedsData?.newsfeeds ?? [],
                      bannerIndices: BannerUtils.calculateBannerIndices(
                          homeViewModel.allNewsFeedsData?.newsfeeds?.length ??
                              0),
                      itemBuilder: (context, dataIndex) {
                        final newsData = homeViewModel
                            .allNewsFeedsData?.newsfeeds?[dataIndex];
                        return NewsFeedDataCard(newsfeeds: newsData);
                      },
                      bannerBuilder: (context, bannerPosition) {
                        return ListBanner();
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
