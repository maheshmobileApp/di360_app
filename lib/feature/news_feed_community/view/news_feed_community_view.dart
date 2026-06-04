import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/dash_board/dash_board_view_model.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed_community/enums/feed_type_enum.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/feature/news_feed_community/widgets/banner_widget.dart';
import 'package:di360_flutter/feature/news_feed_community/widgets/news_feed_community_card.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/view/community_comment_screen.dart';
import 'package:di360_flutter/services/download_file.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:provider/provider.dart';

class NewsFeedCommunityView extends StatefulWidget {
  @override
  _NewsFeedCategoriesViewState createState() => _NewsFeedCategoriesViewState();
}

class _NewsFeedCategoriesViewState extends State<NewsFeedCommunityView>
    with ValidationMixins {
  String selectedFilter = 'all';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final type = await LocalStorage.getStringVal(LocalStorageConst.type);
      final viewModel =
          Provider.of<NewsFeedCommunityViewModel>(context, listen: false);
      await viewModel.getAllNewsFeeds(context);
      final communityVM =
          Provider.of<CommunityViewModel>(context, listen: false);
      final newsFeedVM =
          Provider.of<NewsFeedCommunityViewModel>(context, listen: false);
      await communityVM.getNewsFeedCategories(context, type: "Community");
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final viewModel =
          Provider.of<NewsFeedCommunityViewModel>(context, listen: false);
      viewModel.getAllNewsFeeds(context, loadMore: true);
      /*if (viewModel.applyFilter) {
        viewModel.filterNewsFeeds(context, loadMore: true);
      } else {
        viewModel.getAllNewsFeeds(context, loadMore: true);
      }*/
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsFeedCommunityViewModel>(
      builder: (context, viewModel, child) {
        final courseListingVM =
            Provider.of<MarketPlaceLearningHubViewModel>(context);
        final newsFeedVM = Provider.of<NewsFeedViewModel>(context);
        final newsFeedCommunityVM =
            Provider.of<NewsFeedCommunityViewModel>(context);
        final communityVM = Provider.of<CommunityViewModel>(context);
        final dashboardVM = Provider.of<DashBoardViewModel>(context);
        final joinRequests = viewModel.newsFeedCommunityData?.newsfeeds;
        return FutureBuilder<List<String>>(
          future: Future.wait([
            LocalStorage.getStringVal(LocalStorageConst.type),
            LocalStorage.getStringVal(LocalStorageConst.communityName)
          ]),
          builder: (context, snapshot) {
            final type = snapshot.data?[0] ?? '';
            final businessname = snapshot.data?[1] ?? 'Community';
            return Scaffold(
              backgroundColor: AppColors.whiteColor,
              appBar: AppBarWidget(
                logo: false,
                title: "Community",
                searchAction: () =>
                    viewModel.setSearchBar(!viewModel.searchBarOpen),
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
                                    .filterCatgoriesData?.newsfeedCategories
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
                            viewModel.updateApplyFilter(true);

                            if (value != null) {
                              final categoryName =
                                  (value as dynamic)?.categoryName;

                              final Map<String, String> feedTypeMap = {
                                'Catalogue': 'CATALOGUE',
                                'Jobs': 'JOBS',
                                'Learning Hub': 'LEARNHUB',
                              };

                              viewModel.feedTypeUpdate(
                                  feedTypeMap[categoryName] ?? '');
                              viewModel.setSelectedCategoryId(
                                  categoryName != "Catalogue" &&
                                          categoryName != "Jobs" &&
                                          categoryName != "Learning Hub"
                                      ? (value as dynamic)?.id
                                      : "");

                              viewModel.getAllNewsFeeds(
                                context,
                                feedType: viewModel.feedType,
                                categoryType: categoryName != "Catalogue" &&
                                        categoryName != "Jobs" &&
                                        categoryName != "Learning Hub"
                                    ? viewModel.selectedCategoryId
                                    : null,
                              );
                            }
                          });
                        },
                        child: SvgPicture.asset(ImageConst.filter,
                            color: AppColors.black)),
                    if (viewModel.applyFilter)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: GestureDetector(
                            onTap: () {
                              viewModel.updateApplyFilter(false);
                              viewModel.initialStateData();
                              viewModel.getAllNewsFeeds(context);
                              viewModel.setSelectedCategoryId("");
                            },
                            child: Icon(Icons.close, color: AppColors.black)),
                      )
                  ],
                ),
              ),
              body: Column(
                children: [
                  CommunityHeaderCard(
                    imageUrl: (viewModel.bannerData?.directories != null &&
                            viewModel.bannerData!.directories!.isNotEmpty)
                        ? (viewModel.bannerData!.directories!.first.bannerImage
                                ?.url ??
                            "")
                        : "",
                    title: type == UserRole.professional.value
                        ? "${viewModel.profCommunityName} Community"
                        : "${businessname}Community",
                    leaveButton: type == UserRole.professional.value,
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
                  if (viewModel.searchBarOpen)
                    SearchWidget(
                      controller: viewModel.searchController,
                      hintText: "Search News Feed...",
                      onClear: () {
                        viewModel.searchController.clear();
                        viewModel.getAllNewsFeeds(context);
                      },
                      onSearch: () {
                        viewModel.getAllNewsFeeds(context);
                      },
                    ),
                  (type == UserRole.professional.value)
                      ? SizedBox.shrink()
                      : communityStatusWidget(viewModel),
                  (joinRequests?.length != 0 && joinRequests != null)
                      ? Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.all(10),
                            itemCount: joinRequests.length +
                                (viewModel.hasMoreNewsFeeds &&
                                        viewModel.isLoadingMore
                                    ? 1
                                    : 0),
                            itemBuilder: (context, index) {
                              if (index == joinRequests.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  )),
                                );
                              }
                              final newsItem = joinRequests[index];
                              return NewsFeedCommunityCard(
                                  index: index,
                                  newsfeeds: newsItem,
                                  course: newsItem.courses ?? [],
                                  feedType: newsItem.feedType ?? "",
                                  createdAt: newsItem.createdAt ?? "",
                                  feedUserRole: newsItem.userRole ?? "",
                                  imageUrls:
                                      newsItem.imageUrl ?? newsItem.postImage,
                                  id: newsItem.id ?? '',
                                  logoUrl: (newsItem.userRole ==
                                          UserRole.professional.value)
                                      ? newsItem.dentalProfessional
                                              ?.profileImage?.url ??
                                          ''
                                      : newsItem.dentalSupplier?.logo?.url ??
                                          "",
                                  companyName: (newsItem.userRole ==
                                          UserRole.professional.value)
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
                                  likes: newsItem.newsfeedsLikesAggregate
                                          ?.aggregate?.count ??
                                      0,
                                  isLiked: newsItem.myLike?.isNotEmpty ?? false,
                                  onCommentTap: () {
                                    navigationService.push(
                                        CommunityCommentScreen(
                                            newsfeeds: newsItem));
                                  },
                                  onLikeTap: () {
                                    (newsItem.myLike?.isNotEmpty ?? false)
                                        ? viewModel.communityUnLike(context,
                                            newsItem.myLike?.first.id ?? '')
                                        : viewModel.communityLike(
                                            context, newsItem.id ?? '');
                                  },
                                  onDetailView: () async {
                                    final feedTypeEnum =
                                        FeedType.fromString(newsItem.feedType);
                                    switch (feedTypeEnum) {
                                      case FeedType.learnhub:
                                        await courseListingVM.getCourseDetails(
                                          context,
                                          newsItem.courses?.first.id ?? "",
                                        );
                                        navigationService.navigateTo(
                                            RouteList.courseDetailScreen);
                                        break;
                                      case FeedType.jobs:
                                        await newsFeedVM.getJobDetailsByIds(
                                            context, newsItem.payloadId ?? "");
                                        break;
                                      default:
                                        // Handle default case or other feed types if necessary
                                        break;
                                    }
                                    /*if (newsItem.feedType == "LEARNHUB") {
                                      await courseListingVM.getCourseDetails(
                                        context,
                                        newsItem.courses?.first.id ?? "",
                                      );
                                      navigationService.navigateTo(
                                          RouteList.courseDetailScreen);
                                    } else if (newsItem.feedType == "JOBS") {
                                      await jobListingsViewModel
                                          .getJobListingById(context,newsItem.jobs?.first.id??"");
                                      navigationService.navigateToWithParams(
                                        RouteList.jobdetailsScreen,
                                        params: jobListingsViewModel.jobListingData?.first??Jobs(),
                                      );
                                    }*/
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
                                            htmlParser
                                                    .parse(newsItem.description)
                                                    .body
                                                    ?.text ??
                                                '';
                                        viewModel.videoLinkController.text =
                                            newsItem.videoUrl ?? "";
                                        viewModel.websiteLinkController.text =
                                            newsItem.webUrl ?? "";
                                        await viewModel
                                            .fetchAddNewsfeedCommunityCategories();
                                        viewModel.editSelectCategoryAssigned(
                                            newsItem.categoryType ?? '');

                                        /*viewModel.setSelectedCourseCategoryName(
                                            newsItem.categoryType ?? "");*/

                                        /*viewModel.newsFeedCategory = communityVM
                                                .newsFeedCategoriesData
                                                ?.newsfeedCategories
                                                ?.map(
                                                    (e) => e.categoryName ?? "")
                                                .toList() ??
                                            [];*/
                                        viewModel.serverNewsFeedGallery =
                                            (newsItem.postImage ?? [])
                                                .map((item) => item.url ?? "")
                                                .where((url) => url.isNotEmpty)
                                                .toList();
                                        viewModel.existingImages =
                                            newsItem.postImage ?? [];
                                        navigationService.navigateTo(
                                            RouteList.addNewsFeedCommunityView);

                                        break;
                                      case "Delete":
                                        showAlertMessage(context,
                                            'Are you sure you want to delete this news feed post?',
                                            onBack: () async {
                                          await viewModel
                                              .deleteNewsFeedCommunity(
                                                  context, newsItem.id ?? "");
                                          navigationService.goBack();
                                        });

                                        break;
                                      case "Save Media":
                                        final mediaList =
                                            newsItem.postImage ?? [];
                                        downloadAllFiles(context, mediaList);

                                        break;
                                      case "Hide Post":
                                        await viewModel.newsFeedCommunityAction(
                                            context, newsItem.id ?? "", "HIDE");
                                        showReportSuccessPopup(context);
                                        break;
                                      case "Report Post":
                                        showReportBottomSheet(context, () {
                                          navigationService.goBack();
                                          viewModel.newsFeedCommunityAction(
                                              context,
                                              newsItem.id ?? "",
                                              "REPORT");
                                        }, newsFeedCommunityVM);
                                        scaffoldMessenger(
                                            "Post Reported Successfully");
                                        break;
                                      case "Block Profile":
                                        await viewModel.newsFeedCommunityAction(
                                            context,
                                            newsItem.id ?? "",
                                            "BLOCK");
                                        showReportSuccessPopup(context);
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
                  onTap: () async {
                    viewModel.setEditNewsFeed(false);
                    viewModel.clearAddNewsFeedData();
                    await viewModel.fetchAddNewsfeedCommunityCategories();
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

  void showReportBottomSheet(BuildContext context, Function()? sumbitedAction,
      NewsFeedCommunityViewModel viewModel) {
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      showDragHandle: false,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Report',
                                style: TextStyles.bold5(
                                    color: AppColors.primaryColor)),
                            InkWell(
                                onTap: () => navigationService.goBack(),
                                child: Icon(Icons.close,
                                    color: AppColors.primaryColor))
                          ]),
                      SizedBox(height: 20),
                      Text("Why are you reporting this post?",
                          style: TextStyles.semiBold(
                              color: AppColors.black, fontSize: 16)),
                      SizedBox(height: 10),
                      Text(
                          "If someone is in immediate danger, get help before reporting. Your report is confidential and won’t be shared.",
                          style: TextStyles.regular2()),
                      SizedBox(height: 10),
                      InputTextField(
                        controller: viewModel.reportText,
                        title: '',
                        hintText: 'Describe the issue',
                        maxLines: 5,
                      ),
                      SizedBox(height: 40),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppButton(
                              width: 150,
                              height: 45,
                              radius: 12,
                              text: 'Cancel',
                              onTap: () => navigationService.goBack(),
                            ),
                            AppButton(
                                width: 150,
                                height: 45,
                                radius: 12,
                                text: 'Submit',
                                onTap: sumbitedAction)
                          ])
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
