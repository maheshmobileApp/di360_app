import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/news_feed_comment/view/comment_screen.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/feature/news_feed_community/widgets/banner_widget.dart';
import 'package:di360_flutter/feature/news_feed_community/widgets/news_feed_community_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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
      await viewModel.getAllNewsFeeds(context);
      final communityVM =
          Provider.of<CommunityViewModel>(context, listen: false);
      final newsFeedVM =
          Provider.of<NewsFeedCommunityViewModel>(context, listen: false);
      await communityVM.getNewsFeedCategories(context);
      newsFeedVM.newsFeedCategoriesData = communityVM.newsFeedCategoriesData;

      newsFeedVM.newsFeedCategory = communityVM
              .newsFeedCategoriesData?.newsfeedCategories
              ?.map((e) => e.categoryName ?? "")
              .toList() ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsFeedCommunityViewModel>(
      builder: (context, viewModel, child) {
        final communityVM = Provider.of<CommunityViewModel>(context);
        final homeVM = Provider.of<HomeViewModel>(context);
        final dashboardVM = Provider.of<DashBoardViewModel>(context);
        final joinRequests = viewModel.newsFeedCommunityData?.newsfeeds;

        return FutureBuilder<String>(
          future: LocalStorage.getStringVal(LocalStorageConst.type),
          builder: (context, snapshot) {
            final type = snapshot.data ?? '';
            return Scaffold(
              backgroundColor: AppColors.whiteColor,
              appBar: AppBarWidget(
                title: "Community",
                searchWidget: true,
                filterWidget: Row(
                  children: [
                    GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          final offset = details.globalPosition;
                          showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                                offset.dx, offset.dy, 0, 0),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            items: communityVM
                                    .newsFeedCategoriesData?.newsfeedCategories
                                    ?.map((v) => PopupMenuItem(
                                          value: v,
                                          child: Text(
                                            v.categoryName ?? '',
                                            style: TextStyles.semiBold(
                                                color: viewModel
                                                            .selectedCategoryId ==
                                                        v.id
                                                    ? AppColors.primaryColor
                                                    : AppColors.black,
                                                fontSize: 14,
                                                decoration: viewModel
                                                            .selectedCategoryId ==
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
                            if (value != null) {
                              viewModel.setSelectedCategoryId(
                                  (value as dynamic)?.id);
                              viewModel.filterNewsFeeds(context);
                            }

                            /*if ((value as dynamic)?.categoryName == 'Catalog') {
                        newsFeedVM.basedOnCategoriesGetFeeds(context, true, '');
                      } else {
                        newsFeedVM.basedOnCategoriesGetFeeds(
                            context, false, value?.id ?? '');
                      }*/
                          });
                        },
                        child: SvgPicture.asset(ImageConst.filter,
                            color: AppColors.black)),
                    /*if (newsFeedVM.applyCatageories)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                      onTap: () {
                       
                      },
                      child: Icon(Icons.close, color: AppColors.black)),
                )*/
                  ],
                ),
              ),
              body: Column(
                children: [
                  CommunityHeaderCard(
                    imageUrl: viewModel
                            .bannerData?.directories!.first.bannerImage?.url ??
                        "",
                    title: "${viewModel.profCommunityName} Community",
                    leaveButton: type == "PROFESSIONAL",
                    onLeaveTap: () async {
                      showAlertMessage(context,
                          'Are you sure you want to leave this Community?',
                          onBack: () async {
                        Loaders.circularShowLoader(context);

                        await viewModel.leaveCommunity(context);
                        await communityVM.getJoinedCommunityMembersRes(context);
                        Loaders.circularHideLoader(context);
                        
                        Navigator.of(context).pop(); 
                        Navigator.of(context).pop();
                        dashboardVM.setIndex(3, context);
                      });
                    },
                  ),
                  (type == 'PROFESSIONAL')
                      ? SizedBox.shrink()
                      : communityStatusWidget(viewModel),
                  (joinRequests?.length != 0 && joinRequests != null)
                      ? Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.all(10),
                            itemCount: joinRequests.length,
                            itemBuilder: (context, index) {
                              final newsItem = joinRequests[index];
                              return NewsFeedCommunityCard(
                                  createdAt: newsItem.createdAt ?? "",
                                  feedUserRole: newsItem.userRole ?? "",
                                  imageUrls: newsItem.postImage
                                          ?.map((item) => item.url ?? '')
                                          .toList() ??
                                      [],
                                  id: newsItem.id ?? '',
                                  logoUrl: (newsItem.userRole == "PROFESSIONAL")
                                      ? newsItem.dentalProfessional
                                              ?.profileImage?.url ??
                                          ''
                                      : homeVM.profilePic ?? "",
                                  companyName: (newsItem.userRole ==
                                          "PROFESSIONAL")
                                      ? newsItem.dentalProfessional?.name ?? ''
                                      : newsItem.dentalSupplier?.businessName ??
                                          "",
                                  courseTitle: newsItem.description ?? '',
                                  status: newsItem.status ?? '',
                                  description: newsItem.description ?? '',
                                  types: [],
                                  registeredCount: 0,
                                  chipTitle: newsItem.categoryType ?? '',
                                  comments:
                                      newsItem.newsFeedsComments?.length ?? 0,
                                  likes: newsItem.newsfeedsLikes?.length ?? 0,
                                  isLiked: newsItem.myLike?.isNotEmpty ?? false,
                                  onCommentTap: () {
                                    navigationService.push(
                                        CommentScreen(newsfeeds: newsItem));
                                  },
                                  onLikeTap: () {
                                    print(
                                        "*************///////////**********${newsItem.myLike?.isNotEmpty}");
                                    (newsItem.myLike?.isNotEmpty ?? false)
                                        ? viewModel.communityUnLike(
                                            context, newsItem.id ?? '')
                                        : viewModel.communityLike(
                                            context, newsItem.id ?? '');
                                  },
                                  onShareTap: () {
                                    SharePlus.instance.share(ShareParams(
                                        uri: Uri(
                                            path:
                                                'https://api.dentalinterface.com/api/v1/prelogin/9dab6d94-589e-46f7-ab39-9156d62afa7b')));
                                  },
                                  onMenuAction: (action, id) async {
                                    switch (action) {
                                      case "Publish":
                                        viewModel.updateNewsFeedStatus(
                                          context,
                                          newsItem.id ?? '',
                                          "PUBLISHED",
                                        );

                                        break;
                                      case "Unpublish":
                                        viewModel.updateNewsFeedStatus(
                                          context,
                                          newsItem.id ?? '',
                                          "UNPUBLISHED",
                                        );

                                        break;
                                      case "Edit":
                                        viewModel.setEditNewsFeed(true);
                                        viewModel.setEditNewsFeedId(
                                            newsItem.id ?? "");
                                        viewModel.descriptionController.text =
                                            newsItem.description ?? "";
                                        viewModel.videoLinkController.text =
                                            newsItem.videoUrl ?? "";
                                        viewModel.websiteLinkController.text =
                                            newsItem.webUrl ?? "";

                                        viewModel.setSelectedCourseCategoryName(
                                            newsItem.categoryType ?? "");

                                        print(
                                            "***************** ${newsItem.categoryType ?? ""}");
                                        viewModel.newsFeedCategory = communityVM
                                                .newsFeedCategoriesData
                                                ?.newsfeedCategories
                                                ?.map(
                                                    (e) => e.categoryName ?? "")
                                                .toList() ??
                                            [];
                                        viewModel.serverNewsFeedGallery =
                                            (newsItem.postImage ?? [])
                                                .map((item) => item.url ?? "")
                                                .where((url) => url.isNotEmpty)
                                                .toList();
                                        navigationService.navigateTo(
                                            RouteList.addNewsFeedCommunityView);

                                        break;
                                      case "Delete":
                                        showAlertMessage(context,
                                            'Are you sure you want to delete this Category?',
                                            onBack: () async {
                                          await viewModel
                                              .deleteNewsFeedCommunity(
                                                  context, newsItem.id ?? "");
                                          navigationService.goBack();
                                        });

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
                    viewModel.setEditNewsFeed(false);
                    viewModel.clearAddNewsFeedData();
                    viewModel.newsFeedCategory = communityVM
                            .newsFeedCategoriesData?.newsfeedCategories
                            ?.map((e) => e.categoryName ?? "")
                            .toList() ??
                        [];
                    navigationService
                        .navigateTo(RouteList.addNewsFeedCommunityView);
                  },
                  child: SvgPicture.asset(ImageConst.createSupport)),
            );
          },
        );
      },
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
