import 'package:di360_flutter/common/banner/generic_list_view_with_banners.dart';
import 'package:di360_flutter/common/banner/list_banner.dart';
import 'package:di360_flutter/common/banner/utils.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/add_news_feed_view_model.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/news_feed_data_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen>
    with BaseContextHelpers {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryVM = Provider.of<AddNewsFeedViewModel>(context);
    final newsFeedVM = Provider.of<NewsFeedViewModel>(context);
    final addNewsFeedVM = Provider.of<AddNewsFeedViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.screenBgColor,
        appBar: AppBarWidget(
          searchBarOpen: newsFeedVM.searchBarOpen,
          searchAction: () {
            final isOpening = !newsFeedVM.searchBarOpen;
            newsFeedVM.setSearchBar(isOpening);
            if (isOpening) {
              Future.microtask(() => _searchFocusNode.requestFocus());
            }
          },
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
                      newsFeedVM.resetPagination();
                      newsFeedVM.updateApplyCatageories(true);
                      newsFeedVM.updateSelectedCategory((value as dynamic)?.id);
                      if ((value as dynamic)?.categoryName == 'Catalogue') {
                        newsFeedVM.getAllNewsfeeds(context,
                            feedType: 'CATALOGUE', categoryType: null);
                      } else if ((value as dynamic)?.categoryName == 'Jobs') {
                        newsFeedVM.getAllNewsfeeds(context,
                            feedType: 'JOBS', categoryType: null);
                      } else if ((value as dynamic)?.categoryName ==
                          'Learning Hub') {
                        newsFeedVM.getAllNewsfeeds(context,
                            feedType: 'LEARNHUB', categoryType: null);
                      } else {
                        newsFeedVM.getAllNewsfeeds(context,
                            feedType: null, categoryType: value?.id);
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
                        newsFeedVM.resetPagination();
                        newsFeedVM.getAllNewsfeeds(context,
                            feedType: null, categoryType: null);
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
            addVertical(10),
            if (newsFeedVM.searchBarOpen)
              SearchWidget(
                focusNode: _searchFocusNode,
                searchButton:
                    newsFeedVM.searchController.text.length >= 3 ? true : false,
                controller: newsFeedVM.searchController,
                hintText: "Search News Feed...",
                onClear: () async {
                  newsFeedVM.searchController.clear();
                  await newsFeedVM.getAllNewsfeeds(context);
                },
                onSearch: () async {
                  _searchFocusNode.unfocus();
                  await newsFeedVM.getAllNewsfeeds(context);
                },
              ),
            communityStatusWidget(newsFeedVM),
            Expanded(
                child: newsFeedVM.allNewsFeedsData?.newsfeeds?.isEmpty ?? false
                    ? Center(
                        child: Text('No Data',
                            style: TextStyles.medium3(
                              color: AppColors.black,
                            )))
                    : GenericListViewWithBanners<Newsfeeds>(
                        controller: newsFeedVM.scrollController,
                        items: newsFeedVM.allNewsFeedsData?.newsfeeds ?? [],
                        bannerIndices: BannerUtils.calculateBannerIndices(
                            newsFeedVM.allNewsFeedsData?.newsfeeds?.length ??
                                0),
                        loadingWidget: newsFeedVM.isLoadingMore
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : null,
                        itemBuilder: (context, dataIndex) {
                          final newsData = newsFeedVM
                              .allNewsFeedsData?.newsfeeds?[dataIndex];
                          return NewsFeedDataCard(
                              newsfeeds: newsData, index: dataIndex);
                        },
                        bannerBuilder: (context, bannerPosition) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: ListBanner(),
                          );
                        }))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: AppColors.primaryColor,
            onPressed: () async {
              await categoryVM.fetchNewsfeedCategories();
              addNewsFeedVM.clearFeedNews();
              navigationService.navigateTo(RouteList.addNewsFeed);
            },
            child: SvgPicture.asset(ImageConst.addFeed)));
  }

  SizedBox communityStatusWidget(NewsFeedViewModel courseListingVM) {
    final userType = LocalStorage.getStringSync(LocalStorageConst.type) ?? '';
    if (userType != UserRole.admin.value) return SizedBox.shrink();
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courseListingVM.statuses.length,
        itemBuilder: (context, index) {
          String status = courseListingVM.statuses[index];
          bool isSelected = courseListingVM.selectedStatus == status;
          return GestureDetector(
            onTap: () {
              courseListingVM.changeStatus(status, context);
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
                      "${courseListingVM.statusCountMap[status]}",
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
