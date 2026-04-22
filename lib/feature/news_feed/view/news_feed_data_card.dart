import 'dart:convert';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/add_news_feed_view_model.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed/view/images_full_view.dart';
import 'package:di360_flutter/feature/news_feed/view/inline_video_play.dart';
import 'package:di360_flutter/feature/news_feed/view/news_menu_widget.dart';
import 'package:di360_flutter/feature/news_feed/view/pdf_word_viewr.dart';
import 'package:di360_flutter/feature/news_feed_comment/comment_view_model/comment_view_model.dart';
import 'package:di360_flutter/feature/news_feed_comment/view/comment_screen.dart';
import 'package:di360_flutter/feature/news_feed_community/enums/feed_type_enum.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/expanded_html_widget.dart';
import 'package:di360_flutter/widgets/jiffy_widget.dart';
import 'package:di360_flutter/widgets/share_widget.dart';
import 'package:di360_flutter/widgets/youtube_palyer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final courseListingVM = Provider.of<CourseListingViewModel>(context);
    final newsFeedVM = Provider.of<NewsFeedViewModel>(context);
    final newsFeedTypeEnum = newsfeeds?.feedType ?? '';
    final String shareId = _fetchId(newsfeeds);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: AppColors.whiteColor,
          child: GestureDetector(
            onTap: () async {
              await commentViewModel.getComments(context, newsfeeds?.id ?? "");
              navigationService.push(CommentScreen(newsfeeds: newsfeeds));
            },
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _tagWidget(
                  newsfeeds?.feedType ?? '',
                  newsfeeds?.dentalSupplier?.businessName ??
                      newsfeeds?.dentalPractice?.businessName ??
                      newsfeeds?.dentalProfessional?.name ??
                      '',
                  newsfeeds?.courses?.isNotEmpty == true
                      ? newsfeeds?.courses?.first.type ?? ''
                      : ""),
              addVertical(10),
              _buildHeader(
                  newsfeeds?.dentalSupplier != null
                      ? newsfeeds?.dentalSupplier?.logo?.url ??
                          (newsfeeds?.dentalSupplier?.directories?.isNotEmpty ==
                                  true
                              ? newsfeeds?.dentalSupplier?.directories?.first
                                      .logo?.url ??
                                  ''
                              : '')
                      : newsfeeds?.dentalPractice != null
                          ? newsfeeds?.dentalPractice?.logo?.url ?? ''
                          : newsfeeds?.dentalProfessional != null
                              ? newsfeeds
                                      ?.dentalProfessional?.profileImage?.url ??
                                  ''
                              : '',
                  newsfeeds?.dentalSupplier != null
                      ? newsfeeds?.dentalSupplier?.businessName ?? ''
                      : newsfeeds?.dentalPractice != null
                          ? newsfeeds?.dentalPractice?.businessName ?? ''
                          : newsfeeds?.dentalProfessional != null
                              ? newsfeeds?.dentalProfessional?.name ?? ''
                              : 'Dental interface',
                  newsfeeds?.createdAt ?? '',
                  context,
                  newsfeeds,
                  needFeedViewModel,
                  addNeedFeedViewModel),
              addVertical(10),
              _buildImageRow(catalogueViewModel, context),
              addVertical(5),
              if (newsfeeds?.videoUrl != null &&
                  newsfeeds?.videoUrl?.isNotEmpty == true &&
                  _isValidYoutubeUrl(newsfeeds?.videoUrl ?? ""))
                LazyYoutubePlayer(youtubeUrl: newsfeeds?.videoUrl ?? ""),
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
                    shareId),
              addVertical(22),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (newsFeedTypeEnum != FeedType.jobs.value)
                    ExpandableHtmlText(
                      htmlData: (newsfeeds?.description == null ||
                              newsfeeds?.description == '')
                          ? newsfeeds?.title ?? ''
                          : newsfeeds?.description ?? '',
                      index: index,
                      maxLines: 6,
                    ),
                  // HtmlWidget(
                  //   (newsfeeds?.description == null ||
                  //           newsfeeds?.description == '')
                  //       ? newsfeeds?.title ?? ''
                  //       : newsfeeds?.description ?? '',
                  //   textStyle: TextStyles.regular2(color: AppColors.black),
                  // ),
                  addVertical(10),
                  if (newsfeeds?.webUrl != null &&
                      newsfeeds!.webUrl!.isNotEmpty)
                    webSiteText(newsfeeds?.webUrl ?? ''),
                  if (newsfeeds?.webUrl != null &&
                      newsfeeds!.webUrl!.isNotEmpty)
                    addVertical(8),
                  if (newsFeedTypeEnum == FeedType.learnhub.value &&
                      newsfeeds?.courses?.isNotEmpty == true)
                    _learnHubWidget(newsfeeds?.courses?.first ?? Courses(),
                        newsfeeds?.createdAt ?? '', context, courseListingVM),
                  if (newsFeedTypeEnum == FeedType.catalogue.value)
                    _buildCatalogueRow(catalogueViewModel, context, shareId),
                  Divider(color: AppColors.dividerColor),
                  addVertical(4),
                  _buildStatsRow(
                      '${newsfeeds?.newsfeedsLikesAggregate?.aggregate?.count ?? 0}',
                      '${newsfeeds?.newsFeedsCommentsAggregate?.aggregate?.count ?? 0}',
                      needFeedViewModel,
                      context,
                      shareId,
                      newsfeeds?.feedType ?? FeedType.newsfeed.name),
                  addVertical(10)
                ],
              ),
              Divider(thickness: 8, color: Color(0xffEDEFF1)),
            ]),
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

  Widget _learnHubWidget(
    Courses course,
    String createdAt,
    BuildContext context,
    CourseListingViewModel courseListingVM,
  ) {
    return Container(
      width: double.infinity,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
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
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBlueColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    course.type ?? "",
                    style: TextStyles.regular1(
                      color: AppColors.typeTextColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _timeChip(
                    "Posted on : ${DateFormatUtils.formatDate(createdAt)}"),
                if (course.address?.isNotEmpty == true)
                  _timeChip(course.address?.first.city ?? ""),
                GestureDetector(
                  onTap: () async {
                    await courseListingVM.getCourseDetails(
                      context,
                      newsfeeds?.courses?.first.id ?? "",
                    );
                    navigationService.navigateTo(RouteList.courseDetailScreen);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "View Details",
                        style:
                            TextStyles.medium1(color: AppColors.primaryColor),
                      ),
                      SvgPicture.asset(
                        ImageConst.nextArrow,
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _jobsWidget(
      Jobs job,
      String createdAt,
      BuildContext context,
      NewsFeedViewModel newsFeedVM,
      String jobId) {
    return Container(
      width: double.infinity,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sectionWidget("Title", job.title ?? ""),
                _sectionWidget("Role", job.jRole ?? ""),
                _chipWidget(job.typeofEmployment ?? [], "")
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _timeChip(
                    "Posted on : ${DateFormatUtils.formatDate(createdAt)}"),
                GestureDetector(
                  onTap: () async {
                    await newsFeedVM.getJobDetailsByIds(context, jobId);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "View Details",
                        style:
                            TextStyles.medium1(color: AppColors.primaryColor),
                      ),
                      SvgPicture.asset(
                        ImageConst.nextArrow,
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeChip(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(255, 241, 229, 0),
            Color.fromRGBO(255, 241, 229, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        time,
        style: TextStyles.semiBold(
            fontSize: 10, color: const Color.fromRGBO(255, 112, 0, 1)),
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

  Widget _buildHeader(
      String? imageUrl,
      String? name,
      String? date,
      BuildContext context,
      Newsfeeds? newsfeeds,
      NewsFeedViewModel viewModel,
      AddNewsFeedViewModel addNewsVM) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.greyLight,
            radius: 26.5,
            child: (imageUrl != null && imageUrl.isNotEmpty)
                ? SizedBox(
                    height: 52,
                    width: 52,
                    child: ClipOval(
                        child: CachedNetworkImageWidget(
                            imageUrl: imageUrl,
                            fit: BoxFit.contain,
                            errorWidget: SvgPicture.asset(ImageConst.logo))),
                  )
                : SvgPicture.asset(ImageConst.logo),
          ),
          addHorizontal(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name ?? 'Dental Interface',
                    style: TextStyles.clashMedium(
                        fontSize: 16, color: AppColors.black)),
                Text(jiffyDataWidget(date ?? '', format: 'dd-MM-yyyy hh:mm a'),
                    style:
                        TextStyles.regular1(color: AppColors.lightGeryColor)),
              ],
            ),
          ),
          addHorizontal(15),
          NewsMenuWidget(newsfeeds: newsfeeds)
        ],
      ),
    );
  }

  Widget _buildCatalogueRow(CatalogueViewModel catalogueVM,
      BuildContext context, String? categoryId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.email_outlined, color: AppColors.primaryColor),
                addHorizontal(6),
                Text(newsfeeds?.dentalSupplier?.email ?? '',
                    style: TextStyles.regular1(color: AppColors.black)),
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
        Expanded(
          child: AppButton(
              text: 'View',
              height: 40,
              width: 100,
              onTap: () async {
                await catalogueVM.getCatalogDetails(context, categoryId ?? '');
                final id =
                    catalogueVM.cataloguesByIdData?.catalogueCategoryId ?? '';
                await catalogueVM.getReletedCatalog(context, id);
                await navigationService.navigateTo(RouteList.catalogueDetails);
              }),
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
                Image.asset(ImageConst.pdf),
                addVertical(11),
                Text(name,
                    style: TextStyles.regular1(color: AppColors.lightGeryColor),
                    textAlign: TextAlign.center),
              ],
            ),
          );
        } else {
          return CachedNetworkImageWidget(imageUrl: url, fit: BoxFit.contain);
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
              Image.asset(ImageConst.pdf),
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
            height: 300,
            color: Colors.grey[200],
            child: child,
          ),
        ),
      ),
    );
  }

  bool _isValidYoutubeUrl(String url) {
    return url.contains('youtube.com') || url.contains('youtu.be');
  }

  Widget _buildStatsRow(
      String likeCount,
      String commentCount,
      NewsFeedViewModel viewModel,
      BuildContext context,
      String feedId,
      String? category) {
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
                  Text('$likeCount Likes',
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
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.backgroundColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: [
                Image.asset(ImageConst.comment),
                addHorizontal(8),
                Text('$commentCount comments',
                    style: TextStyles.regular3(color: AppColors.black))
              ],
            ),
          ),
        )
      ],
    );
  }
}
