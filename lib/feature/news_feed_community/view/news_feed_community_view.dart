import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';

import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/feature/news_feed_community/widgets/news_feed_community_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NewsFeedCommunityView extends StatefulWidget {
  @override
  _NewsFeedCategoriesViewState createState() => _NewsFeedCategoriesViewState();
}

class _NewsFeedCategoriesViewState extends State<NewsFeedCommunityView>
    with ValidationMixins {
  String selectedFilter = 'all';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel =
          Provider.of<NewsFeedCommunityViewModel>(context, listen: false);
      await viewModel.getAllNewsFeeds();
      //await viewModel.getAllStatusCounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsFeedCommunityViewModel>(context);
    final joinRequests = viewModel.newsFeedCommunityData?.newsfeeds;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
          title: "Community",
          searchWidget: true,
          /*filterWidget: Row(
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
          ),*/),
      body: Column(
        children: [
          communityStatusWidget(viewModel),
          (joinRequests?.length != 0 && joinRequests != null)
              ? Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: joinRequests.length,
                    itemBuilder: (context, index) {
                      final newsItem = joinRequests[index];
                      return NewsFeedCommunityCard(
                          createdAt: newsItem.createdAt ?? "",
                          id: newsItem.id ?? '',
                          logoUrl:
                              newsItem.dentalProfessional?.profileImage?.url ??
                                  '',
                          companyName: (newsItem.userRole=="PROFESSIONAL")? newsItem.dentalProfessional?.name ?? '':newsItem.dentalSupplier?.businessName??"",
                          courseTitle: newsItem.description ?? '',
                          status: newsItem.status ?? '',
                          description: newsItem.description ?? '',
                          types: [],
                          registeredCount: 0,
                          chipTitle: newsItem.categoryType ?? '',
                          comments: newsItem.newsFeedsComments?.length ?? 0,
                          likes: newsItem.newsfeedsLikes?.length ?? 0,
                          isLiked: newsItem.myLike?.isNotEmpty ?? false,
                          onCommentTap: () {},
                          onLikeTap: () {
                            print(
                                "*************///////////**********${newsItem.myLike?.isNotEmpty}");
                            (newsItem.myLike?.isNotEmpty ?? false)
                                ? viewModel.communityUnLike(newsItem.id ?? '')
                                : viewModel.communityLike(newsItem.id ?? '');
                          },
                          onShareTap: () {},
                          onMenuAction: (action, id) async {
                            switch (action) {
                              case "Publish":
                                viewModel.updateNewsFeedStatus(newsItem.id ?? '',"PUBLISHED",  );

                                break;
                              case "Unpublish":
                                viewModel.updateNewsFeedStatus(newsItem.id ?? '',"UNPUBLISHED",  );

                                break;
                            }
                          });
                    },
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Text(
                      "No Data",
                      style: TextStyles.medium3(
                          color: AppColors.black, fontSize: 16),
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: GestureDetector(
          onTap: () {
             navigationService.navigateTo(RouteList.addNewsFeedCommunityView);
          },
          child: SvgPicture.asset(ImageConst.createSupport)),
    );
  }

  SizedBox communityStatusWidget(NewsFeedCommunityViewModel courseListingVM) {
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
