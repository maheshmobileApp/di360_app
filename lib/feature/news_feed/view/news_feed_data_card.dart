import 'dart:convert';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/add_news_feed_view_model.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/images_full_view.dart';
import 'package:di360_flutter/feature/news_feed/view/inline_video_play.dart';
import 'package:di360_flutter/feature/news_feed/view/news_menu_widget.dart';
import 'package:di360_flutter/feature/news_feed/view/pdf_word_viewr.dart';
import 'package:di360_flutter/feature/news_feed_comment/comment_view_model/comment_view_model.dart';
import 'package:di360_flutter/feature/news_feed_comment/view/comment_screen.dart';
import 'package:di360_flutter/feature/news_feed_community/enums/feed_type_enum.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/expanded_html_widget.dart';
import 'package:di360_flutter/widgets/outline_button_widget.dart';
import 'package:di360_flutter/widgets/share_widget.dart';
import 'package:di360_flutter/widgets/youtube_palyer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsFeedDataCard extends StatelessWidget with BaseContextHelpers {
  final Newsfeeds? newsfeeds;
  final VoidCallback? onDetailView;
  final int index;
  const NewsFeedDataCard({
    super.key,
    required this.newsfeeds,
    required this.index,
    this.onDetailView,
  });

  @override
  Widget build(BuildContext context) {
    final needFeedViewModel = Provider.of<NewsFeedViewModel>(context);
    final addNeedFeedViewModel = Provider.of<AddNewsFeedViewModel>(context);
    final catalogueViewModel = Provider.of<CatalogueViewModel>(context);
    final commentViewModel = Provider.of<CommentViewModel>(context);
    final courseListingVM =
        Provider.of<MarketPlaceLearningHubViewModel>(context);
    final newsFeedVM = Provider.of<NewsFeedViewModel>(context);
    final newsFeedTypeEnum = newsfeeds?.feedType ?? '';
    final String shareId = _fetchId(newsfeeds);
    final directoryVM = Provider.of<DirectoryViewModel>(context);
    final isLogoAvailable = newsfeeds?.communityType == "COMMUNITY_USER" &&
        newsfeeds?.userRole == UserRole.professional.value;
    final newsCommunityVM = Provider.of<NewsFeedCommunityViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.whiteColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await commentViewModel.getComments(
                        context, newsfeeds?.id ?? "");
                    navigationService.push(CommentScreen(newsfeeds: newsfeeds));
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _tagWidget(
                            newsfeeds?.feedType ?? '',
                            newsfeeds?.dentalSupplier?.businessName ??
                                newsfeeds?.dentalPractice?.businessName ??
                                newsfeeds?.dentalProfessional?.name ??
                                '',
                            newsfeeds?.courses?.isNotEmpty == true
                                ? newsfeeds?.courses?.first.type ?? ''
                                : ""),
                        addVertical(8),
                        _buildHeader(
                            newsfeeds?.dentalSupplier != null
                                ? newsfeeds?.dentalSupplier?.logo?.url ??
                                    (newsfeeds?.dentalSupplier?.directories
                                                ?.isNotEmpty ==
                                            true
                                        ? newsfeeds?.dentalSupplier?.directories
                                                ?.first.logo?.url ??
                                            ''
                                        : '')
                                : newsfeeds?.dentalPractice != null
                                    ? newsfeeds?.dentalPractice?.logo?.url ?? ''
                                    : newsfeeds?.dentalProfessional != null
                                        ? newsfeeds?.dentalProfessional
                                                ?.profileImage?.url ??
                                            ''
                                        : '',
                            newsfeeds?.dentalSupplier != null
                                ? newsfeeds?.dentalSupplier?.businessName ?? ''
                                : newsfeeds?.dentalPractice != null
                                    ? newsfeeds?.dentalPractice?.businessName ??
                                        ''
                                    : newsfeeds?.dentalProfessional != null
                                        ? newsfeeds?.dentalProfessional?.name ??
                                            ''
                                        : 'Dental Interface 360',
                            newsfeeds?.createdAt ?? '',
                            context,
                            newsfeeds,
                            needFeedViewModel,
                            addNeedFeedViewModel,
                            directoryVM,
                            isLogoAvailable
                                ? newsfeeds?.communityOwner?.communityId
                                : getDirectoryId(
                                    newsfeeds, newsfeeds?.userRole ?? ""),
                            getDirectoryId(
                                newsfeeds, newsfeeds?.userRole ?? ""),
                            isLogoAvailable,
                            newsCommunityVM),
                        addVertical(10),
                        _buildImageRow(catalogueViewModel, context),
                        if (newsfeeds?.videoUrl != null &&
                            newsfeeds?.videoUrl?.isNotEmpty == true &&
                            _isValidVideoUrl(newsfeeds?.videoUrl ?? ""))
                          LazyYoutubePlayer(
                              youtubeUrl: newsfeeds?.videoUrl ?? ""),
                        const SizedBox(height: 8),
                        if (newsfeeds?.webUrl != null &&
                            newsfeeds?.webUrl?.isNotEmpty == true)
                          webSiteText(newsfeeds?.webUrl ?? ""),
                        if (newsFeedTypeEnum == FeedType.jobs.value)
                          _jobsWidget(
                              newsfeeds?.jobs?.first ?? Jobs(),
                              newsfeeds?.createdAt ?? '',
                              context,
                              newsFeedVM,
                              shareId,
                              newsfeeds?.title),
                        addVertical(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (newsfeeds?.webUrl != null &&
                                newsfeeds!.webUrl!.isNotEmpty)
                              addVertical(8),
                            if (newsFeedTypeEnum == FeedType.learnhub.value &&
                                newsfeeds?.courses?.isNotEmpty == true)
                              _learnHubWidget(
                                  newsfeeds?.courses?.first ?? Courses(),
                                  newsfeeds?.createdAt ?? '',
                                  context,
                                  courseListingVM,
                                  shareId),
                            if (newsFeedTypeEnum == FeedType.catalogue.value)
                              _buildCatalogueRow(
                                  catalogueViewModel, context, shareId),
                            addVertical(10),
                            if (newsfeeds?.description?.isNotEmpty == true) ...[
                              if (newsfeeds?.feedType ==
                                  FeedType.learnhub.value)
                                Text(
                                  "Course Description :",
                                  style: TextStyles.semiBold(
                                      fontSize: 14, color: AppColors.black),
                                ),
                              ExpandableHtmlText(
                                htmlData: newsfeeds?.description ?? "",
                                index: index,
                              )
                            ]
                          ],
                        ),
                      ]),
                ),
                addVertical(8),
                _buildStatsRow(
                    '${newsfeeds?.newsfeedsLikesAggregate?.aggregate?.count ?? 0}',
                    '${newsfeeds?.newsFeedsCommentsAggregate?.aggregate?.count ?? 0}',
                    needFeedViewModel,
                    context,
                    shareId,
                    newsfeeds?.feedType ?? FeedType.newsfeed.name,
                    commentViewModel,
                    newsfeeds?.commentsEnabled ?? false),
              ],
            ),
          )),
    );
  }

  String _fetchId(Newsfeeds? newsfeeds) {
    if (newsfeeds?.feedType == FeedType.jobs.value) {
      return newsfeeds?.payloadId ?? '';
    } else if (newsfeeds?.feedType == FeedType.learnhub.value) {
      return newsfeeds?.payloadId ?? '';
    } else if (newsfeeds?.feedType == FeedType.catalogue.value) {
      return newsfeeds?.payloadId ?? '';
    } else {
      return newsfeeds?.id ?? '';
    }
  }

  Widget _learnHubWidget(Courses course, String createdAt, BuildContext context,
      MarketPlaceLearningHubViewModel courseListingVM, String courseId) {
    return Container(
      width: double.infinity,
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sectionWidget(
                    "Presented By",
                    (course.presenters?.isNotEmpty == true)
                        ? (course.presenters?.first.presentedByName ?? "")
                        : ""),
                _sectionWidget("CPD Hours", course.cpdPoints.toString()),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBlueColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    course.type ?? "",
                    style: TextStyles.regular1(
                        color: AppColors.typeTextColor, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _timeChip("${DateFormatUtils.formatTwoDateTime(createdAt)}"),
                if (course.address?.isNotEmpty == true)
                  _locationChip(course.address?.first.city ?? ""),
                OutlineButtonWidget(
                  text: "View Details",
                  onTap: () async {
                    await courseListingVM.getCourseDetails(context, courseId);
                    navigationService.navigateTo(RouteList.courseDetailScreen);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _jobsWidget(Jobs job, String createdAt, BuildContext context,
      NewsFeedViewModel newsFeedVM, String jobId, String? title) {
    return Container(
      width: double.infinity,
      height: 150,
      child: Column(
        children: [
          _timeChip(
              "Posted on : ${DateFormatUtils.formatTwoDateTime(createdAt)}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _sectionWidget("Title", title ?? ''),
                    _sectionWidget("Role", job.jRole ?? ""),
                    _chipWidget(job.typeofEmployment ?? [], "")
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /*_timeChip(
                        "Posted on : ${DateFormatUtils.formatTwoDateTime(createdAt)}"),*/
                    OutlineButtonWidget(
                      text: "View Details",
                      onTap: () async {
                        await newsFeedVM.getJobDetailsByIds(context, jobId);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _locationChip(String location) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: AppColors.primaryColor,
          size: 16,
        ),
        Text(location),
      ],
    );
  }

  Widget _timeChip(String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white,
              Colors.grey.shade300,
            ],
          ),
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Posted on : ",
                style: TextStyles.medium1(
                  color: AppColors.black,
                ),
              ),
              TextSpan(
                text: time,
                style: TextStyles.medium1(
                  color: AppColors.geryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chipWidget(List<String> types, String meetingLink) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.secondaryBlueColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            child: Text(
              types.isNotEmpty ? types.first : "N/A",
              style: TextStyles.regular1(
                color: AppColors.typeTextColor,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionWidget(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.regular2(color: AppColors.geryColor),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          value,
          style: TextStyles.medium2(color: AppColors.black),
        ),
      ],
    );
  }

  Widget _tagWidget(String? feedType, String userName, String courseType) {
    String tagText = '';

    switch (feedType) {
      case 'JOBS':
        tagText = "#New Job Opportunity Posted by $userName";
      case 'LEARNHUB':
        tagText = "#New Course $courseType";
      case 'CATALOGUE':
        tagText = "#New CATALOGUE Posted";
      default:
        tagText = '#NEWSFEED Post';
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white,
              Colors.grey.shade300,
            ],
          ),
        ),
        child: Text(tagText,
            style: TextStyles.semiBold(
              color: AppColors.black,
            )),
      ),
    );
  }

  String getDirectoryId(Newsfeeds? newsfeeds, String userType) {
    if (userType == UserRole.professional.value) {
      return newsfeeds?.dentalProfessional?.directories?.isNotEmpty == true
          ? newsfeeds?.dentalProfessional?.directories?.first.id ?? ""
          : "";
    } else if (userType == UserRole.practice.value) {
      return newsfeeds?.dentalPractice?.directories?.isNotEmpty == true
          ? newsfeeds?.dentalPractice?.directories?.first.id ?? ""
          : "";
    } else if (userType == UserRole.supplier.value) {
      return newsfeeds?.dentalSupplier?.directories?.isNotEmpty == true
          ? newsfeeds?.dentalSupplier?.directories?.first.id ?? ""
          : "";
    }

    return "";
  }

  String getFirstLetter(String? name) {
    return name?[0].toUpperCase() ?? "";
  }

  Widget _buildHeader(
      String? imageUrl,
      String? name,
      String? date,
      BuildContext context,
      Newsfeeds? newsfeeds,
      NewsFeedViewModel viewModel,
      AddNewsFeedViewModel addNewsVM,
      DirectoryViewModel directoryVM,
      String? id,
      String? userId,
      bool logoAvailable,
      NewsFeedCommunityViewModel newsCommunityVM) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Stack(alignment: Alignment.center, children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                radius: 26.5,
                child: (imageUrl != null && imageUrl.isNotEmpty)
                    ? SizedBox(
                        height: 52,
                        width: 52,
                        child: ClipOval(
                            child: CachedNetworkImageWidget(
                                imageUrl: logoAvailable
                                    ? newsfeeds?.communityOwner?.logo?.url ?? ''
                                    : imageUrl,
                                fit: BoxFit.cover,
                                errorWidget:
                                    Image.asset(ImageConst.directorProfile))),
                      )
                    : Text(
                        getFirstLetter(
                            newsfeeds?.communityOwner?.businessName ??
                                name ??
                                'Dental Interface'),
                        style: TextStyles.bold5(color: AppColors.whiteColor),
                      ),
              ),
              if (logoAvailable)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: AppColors.greyLight,
                    radius: 16,
                    child: (newsfeeds?.communityOwner?.logo?.url?.isNotEmpty ==
                            true)
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: ClipOval(
                                child: CachedNetworkImageWidget(
                                    imageUrl: imageUrl ?? '',
                                    fit: BoxFit.cover,
                                    errorWidget: Image.asset(
                                        ImageConst.directorProfile))),
                          )
                        : Text(
                            getFirstLetter(name),
                            style:
                                TextStyles.bold5(color: AppColors.whiteColor),
                          ),
                  ),
                ),
            ]),
            addHorizontal(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (logoAvailable) {
                      newsCommunityVM.listingStatus = "PUBLISHED";
                      newsCommunityVM.setNewsFeedCommunityId(id ?? "");
                      newsCommunityVM.setProfCommunityId(id ?? "", "");
                      newsCommunityVM.getBannerUrl(context);
                      newsCommunityVM.getCommunityMemberDirectorIds(
                          communityId: id ?? "");
                      navigationService
                          .navigateTo(RouteList.newsFeedCommunityView);
                    } else {
                      Loaders.circularShowLoader(context);

                      await directoryVM.GetDirectorDetails(id ?? "");
                      await directoryVM.getDirectory(id ?? "");

                      Loaders.circularHideLoader(context);

                      navigationService
                          .navigateTo(RouteList.directoryDetailsScreen);
                    }
                  },
                  child: Text(
                      logoAvailable
                          ? newsfeeds?.communityOwner?.businessName ?? ""
                          : name ?? 'Dental Interface',
                      style: TextStyles.clashMedium(
                          fontSize: 16, color: AppColors.black)),
                ),
                if (!logoAvailable)
                  Text(
                      DateFormatUtils.formatTwoDateTime(
                        date ?? "",
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyles.regular1(color: AppColors.lightGeryColor)),
                if (logoAvailable)
                  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      GestureDetector(
                        onTap: () async {
                          Loaders.circularShowLoader(context);
                      
                          await directoryVM.GetDirectorDetails(userId ?? "");
                          await directoryVM.getDirectory(userId ?? "");
                      
                          Loaders.circularHideLoader(context);
                      
                          navigationService
                              .navigateTo(RouteList.directoryDetailsScreen);
                        },
                        child: Text(name ?? "",
                            style: TextStyles.regular1(
                                color: Colors.black, fontSize: 14)),
                      ),
                       const SizedBox(width: 8),
                      Text(
                          DateFormatUtils.formatTwoDateTime(
                            date ?? "",
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.regular1(
                              color: AppColors.lightGeryColor)),
                    ],
                  ),
              ],
            ),
          ],
        ),
        NewsMenuWidget(newsfeeds: newsfeeds)
      ],
    );
  }

  Widget _buildCatalogueRow(CatalogueViewModel catalogueVM,
      BuildContext context, String? categoryId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.email_outlined, color: AppColors.primaryColor),
                  addHorizontal(6),
                  Expanded(
                    child: Text(
                      newsfeeds?.dentalSupplier?.email ?? '',
                      style: TextStyles.regular1(color: AppColors.black),
                      overflow: TextOverflow.ellipsis, // optional
                      maxLines: 1, // optional
                    ),
                  ),
                ],
              ),
              addVertical(8),
              Row(
                children: [
                  Icon(Icons.phone, color: AppColors.primaryColor),
                  addHorizontal(6),
                  Text(newsfeeds?.dentalSupplier?.phone ?? '',
                      style: TextStyles.regular1(color: AppColors.black)),
                ],
              )
            ],
          ),
        ),
        OutlineButtonWidget(
          text: "View Details",
          onTap: () async {
            await catalogueVM.getCatalogDetails(context, categoryId ?? '');
            final id =
                catalogueVM.cataloguesByIdData?.catalogueCategoryId ?? '';
            await catalogueVM.getReletedCatalog(context, id);
            await navigationService.navigateTo(RouteList.catalogueDetails);
          },
        )
      ],
    );
  }

  Widget _buildImageRow(CatalogueViewModel catalogueVM, BuildContext context) {
    final mediaList = newsfeeds?.postImage?.isNotEmpty == true
        ? newsfeeds?.postImage ?? []
        : newsfeeds?.imageUrl ?? [];

    if (mediaList.isEmpty == true) return SizedBox();

    Widget buildMediaContent(media) {
      final type = media.type ?? media.mimeType ?? '';
      final url = media.url ?? '';
      final name = media.name ?? '';

      // Helper: check if base64
      bool isBase64Image(String data) => data.startsWith('data:image/');

      if (type.startsWith('image/') ||
          type.startsWith('application/octet-stream')) {
        if (isBase64Image(url)) {
          try {
            final decodedBytes = base64Decode(url.split(',').last);
            return Image.memory(decodedBytes, fit: BoxFit.contain);
          } catch (e) {
            return Icon(Icons.broken_image);
          }
        } else if (name.endsWith('.mp4')) {
          return InlineVideoPlayer(videoUrl: url);
        } else if (name.endsWith('.pdf')) {
          return GestureDetector(
            onTap: () async =>
                navigationService.push(ImageViewerScreen(postImage: mediaList)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageConst.pdf, height: 50),
                addVertical(11),
                Text(name,
                    style: TextStyles.regular1(color: AppColors.lightGeryColor),
                    textAlign: TextAlign.center),
              ],
            ),
          );
        } else {
          return CachedNetworkImageWidget(imageUrl: url, fit: BoxFit.cover);
        }
      } else if (type == 'video/mp4') {
        return InlineVideoPlayer(videoUrl: url);
      } else if (type == 'application/pdf') {
        return GestureDetector(
          onTap: () async =>
              navigationService.push(ImageViewerScreen(postImage: mediaList)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageConst.pdf, height: 50),
              addVertical(11),
              Text(name,
                  style: TextStyles.regular1(color: AppColors.lightGeryColor),
                  textAlign: TextAlign.center),
            ],
          ),
        );
      } else if (type == 'application/msword') {
        return GestureDetector(
          onTap: () async {
            navigationService.push(ImageViewerScreen(postImage: mediaList));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wordpress, size: 40),
              addVertical(11),
              Text(name,
                  style: TextStyles.regular1(color: AppColors.lightGeryColor),
                  textAlign: TextAlign.center),
            ],
          ),
        );
      } else {
        return CachedNetworkImageWidget(imageUrl: url);
      }
    }

    if (mediaList.length == 1) {
      final media = mediaList.first;
      return _mediaCard(
        child: buildMediaContent(media),
        onTap: () {
          navigationService.push(ImageViewerScreen(postImage: mediaList));
        },
        isFullWidth: true,
      );
    }

    // Multiple items
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: mediaList.map<Widget>((media) {
          return _mediaCard(
              child: buildMediaContent(media),
              onTap: () {
                navigationService.push(ImageViewerScreen(postImage: mediaList));
              });
        }).toList(),
      ),
    );
  }

  Widget _mediaCard(
      {required Widget child, VoidCallback? onTap, bool isFullWidth = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: isFullWidth ? double.infinity : 300,
            height: 160,
            color: Colors.grey[200],
            child: child,
          ),
        ),
      ),
    );
  }

  bool _isValidVideoUrl(String url) {
    return url.contains('youtube.com') ||
        url.contains('youtu.be') ||
        url.contains('drive.google.com') ||
        url.contains('loom.com') ||
        url.contains('vimeo.com');
  }

  Widget _buildStatsRow(
      String likeCount,
      String commentCount,
      NewsFeedViewModel viewModel,
      BuildContext context,
      String feedId,
      String? category,
      CommentViewModel commentViewModel,
      bool commentsEnabled) {
    final isLiked = newsfeeds?.myLike?.length == 1;

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (isLiked) {
              final likeId = newsfeeds?.myLike?.first.id ?? '';
              viewModel.removeNewsFeedLike(
                  context, newsfeeds?.id ?? '', likeId);
            } else {
              viewModel.addNewsFeedLike(context, newsfeeds?.id ?? '');
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                children: [
                  Icon(isLiked ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.primaryColor),
                  addHorizontal(8),
                  Text('$likeCount',
                      style: TextStyles.regular2(color: AppColors.black)),
                ],
              ),
            ),
          ),
        ),
        addHorizontal(10),
        ShareWidget(
          feedId: feedId,
          category: category,
        ),
        Spacer(),
        if (commentsEnabled)
          GestureDetector(
            onTap: () async {
              await commentViewModel.getComments(context, newsfeeds?.id ?? "");
              navigationService.push(CommentScreen(newsfeeds: newsfeeds));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.backgroundColor),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  children: [
                    Image.asset(ImageConst.comment),
                    addHorizontal(8),
                    Text('$commentCount comments',
                        style: TextStyles.regular3(color: AppColors.black))
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
