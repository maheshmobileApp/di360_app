import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/news_feed/view/images_full_view.dart';
import 'package:di360_flutter/feature/news_feed/view/inline_video_play.dart';
import 'package:di360_flutter/feature/news_feed/view/pdf_word_viewr.dart';
import 'package:di360_flutter/feature/news_feed_community/enums/feed_type_enum.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/expanded_html_widget.dart';
import 'package:di360_flutter/widgets/share_widget.dart';
import 'package:di360_flutter/widgets/youtube_palyer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsFeedCommunityCard extends StatelessWidget with BaseContextHelpers {
  final String id;
  final String logoUrl;
  final String feedUserRole;
  final String companyName;
  final String courseTitle;
  final String description;
  final String status;
  final List<String> types;
  final String createdAt;
  final int registeredCount;
  final String chipTitle;
  final String feedType;
  final List<PostImage>? imageUrls;
  final List<Courses>? course;
  final List<Jobs>? job;
  final VoidCallback? onTapRegistered;
  final Function(String action, String id)? onMenuAction;
  final VoidCallback? onDetailView;
  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onCommunityTap;
  final int likes;
  final int comments;
  final bool isLiked;
  final Newsfeeds? newsfeeds;
  final int index;
  final String communityLogo;
  final String userName;
  final String communityUserId;

  NewsFeedCommunityCard({
    super.key,
    required this.id,
    required this.logoUrl,
    required this.feedUserRole,
    required this.comments,
    required this.companyName,
    required this.courseTitle,
    required this.description,
    required this.status,
    required this.types,
    required this.imageUrls,
    required this.createdAt,
    required this.registeredCount,
    this.course,
    this.job,
    this.onTapRegistered,
    this.onMenuAction,
    this.onDetailView,
    required this.chipTitle,
    this.onLikeTap,
    this.onCommentTap,
    this.onCommunityTap,
    required this.likes,
    required this.feedType,
    this.isLiked = false,
    this.newsfeeds,
    required this.index,
    required this.communityLogo,
    required this.userName,
    required this.communityUserId,
  }) {}

  @override
  Widget build(BuildContext context) {
    final feedTypeEnum = feedType;
    final catelougeViewModel = Provider.of<CatalogueViewModel>(context);
    final directoryVM = Provider.of<DirectoryViewModel>(context);

    final newsFeedCommunityViewModel =
        Provider.of<NewsFeedCommunityViewModel>(context);
    final String shareId = _fetchId(newsfeeds);
    newsFeedCommunityViewModel.getUserId();
    final currentUserId = newsFeedCommunityViewModel.userID ?? '';

    final isSameUser = newsfeeds?.userId == currentUserId;
    final logoAvailable = feedUserRole == UserRole.professional.value &&
        newsfeeds?.communityType == "COMMUNITY_USER";

    return FutureBuilder<String>(
      future: LocalStorage.getStringVal(LocalStorageConst.type),
      builder: (context, snapshot) {
        final type = snapshot.data ?? '';

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // 🔹 Top Card
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Logo + Title + Menu
                    _tagWidget(
                        newsfeeds?.feedType ?? '',
                        newsfeeds?.dentalSupplier?.businessName ??
                            newsfeeds?.dentalPractice?.businessName ??
                            newsfeeds?.dentalProfessional?.name ??
                            '',
                        newsfeeds?.courses?.isNotEmpty == true
                            ? newsfeeds?.courses?.first.type ?? ''
                            : ""),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _logoWithTitle(
                              logoUrl,
                              companyName,
                              createdAt,
                              communityLogo,
                              userName,
                              logoAvailable,
                              communityUserId,
                              directoryVM,
                              context,
                              onCommunityTap,
                              getDirectoryId(
                                  newsfeeds, newsfeeds?.userRole ?? "")),
                        ),
                        /*if (type == UserRole.supplier.value ||
                            (type == UserRole.professional.value &&
                                feedUserRole != UserRole.supplier.value &&
                                isSameUser))*/
                        Row(
                          children: [
                            _menuWidget(context, type, imageUrls, isSameUser),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    (imageUrls?.isNotEmpty ?? false)
                        ? _buildImageRow(imageUrls)
                        : SizedBox.shrink(),
                    const SizedBox(height: 8),
                    if (newsfeeds?.feedType == FeedType.learnhub.value)
                      Text(
                        "Course Description :",
                        style: TextStyles.semiBold(
                            fontSize: 14, color: AppColors.black),
                      ),
                    ExpandableHtmlText(
                      htmlData: description,
                      index: index,
                    ),
                    if (newsfeeds?.videoUrl != null &&
                        newsfeeds?.videoUrl?.isNotEmpty == true &&
                        _isValidVideoUrl(newsfeeds?.videoUrl ?? ""))
                      LazyYoutubePlayer(youtubeUrl: newsfeeds?.videoUrl ?? ""),
                    const SizedBox(height: 8),

                    if (newsfeeds?.webUrl != null &&
                        newsfeeds?.webUrl?.isNotEmpty == true)
                      webSiteText(newsfeeds?.webUrl ?? ""),

                    if (course?.isNotEmpty == true)
                      ((course?.first.courseBannerImage?.isNotEmpty ?? false) &&
                              (course?.first.courseBannerImage?.first.url !=
                                  null))
                          ? Center(
                              child: CachedNetworkImageWidget(
                                height: 150,
                                imageUrl: course
                                        ?.first.courseBannerImage?.first.url ??
                                    "",
                                fit: BoxFit.contain,
                              ),
                            )
                          : SizedBox.shrink(),

                    if (feedTypeEnum == FeedType.learnhub.value &&
                        course?.isNotEmpty == true)
                      _learnHubWidget(course?.first ?? Courses(), createdAt),
                    if (feedTypeEnum == FeedType.catalogue.value)
                      _buildCatalogueRow(catelougeViewModel, context, shareId),
                    if (feedTypeEnum == FeedType.jobs.value &&
                        job?.isNotEmpty == true)
                      _jobsWidget(job?.first ?? Jobs(), createdAt,
                          newsfeeds?.title ?? ""),

                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// ❤️ Like Button + Count
                        GestureDetector(
                          onTap: onLikeTap,
                          child: Row(
                            children: [
                              _circleIcon(
                                child: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked
                                      ? Colors.orangeAccent
                                      : Colors.grey,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                likes.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 15),

                        /// 🔗 Share Button
                        ShareWidget(
                          category: feedType,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          size: 20,
                          feedId: shareId,
                        ),

                        const Spacer(),

                        /// 💬 Comment Icon + Count
                        if (newsfeeds?.commentsEnabled ?? false)
                          GestureDetector(
                            onTap: onCommentTap,
                            child: Row(
                              children: [
                                const Icon(Icons.comment,
                                    color: Colors.black, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  "${comments.toString()} Comments",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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

  Widget _buildImageRow(List<PostImage>? allMediaList) {
    final mediaList = allMediaList ?? [];
    if (mediaList.isEmpty) return SizedBox();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: mediaList.length == 1
          ? _buildSingleMedia(mediaList.first, mediaList)
          : _buildMultipleMedia(mediaList),
    );
  }

  Widget _buildSingleMedia(PostImage media, List<PostImage> allMedia) {
    return GestureDetector(
      onTap: () => navigationService
          .push(ImageViewerScreen(postImage: allMedia as List<PostImage>?)),
      child: Container(
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _buildMediaWidget(media, isFullSize: true),
        ),
      ),
    );
  }

  Widget _buildMultipleMedia(List<PostImage> mediaList) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: mediaList.length,
        separatorBuilder: (_, __) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          final media = mediaList[index];
          return GestureDetector(
            onTap: () => navigationService.push(
                ImageViewerScreen(postImage: mediaList as List<PostImage>?)),
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildMediaWidget(media),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMediaWidget(PostImage media, {bool isFullSize = false}) {
    final type = media.type ?? media.mimeType ?? '';
    final url = media.url ?? '';
    final name = media.name ?? '';

    // Video handling
    if (type.contains('video') || name.endsWith('.mp4')) {
      return Stack(
        fit: StackFit.expand,
        children: [
          InlineVideoPlayer(videoUrl: url),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(Icons.play_arrow, color: Colors.white, size: 16),
            ),
          ),
        ],
      );
    }

    // PDF handling
    if (type.contains('pdf') || name.endsWith('.pdf')) {
      return Container(
        color: Colors.red[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.picture_as_pdf,
                size: isFullSize ? 40 : 40, color: Colors.red),
            SizedBox(height: 8),
            if (isFullSize)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  name.isNotEmpty ? name : 'PDF Document',
                  style:
                      TextStyles.medium3(fontSize: 12, color: Colors.red[700]!),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      );
    }

    // Word document handling
    if (type.contains('msword') ||
        name.endsWith('.doc') ||
        name.endsWith('.docx')) {
      return Container(
        color: Colors.blue[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description,
                size: isFullSize ? 60 : 40, color: Colors.blue),
            SizedBox(height: 8),
            if (isFullSize)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  name.isNotEmpty ? name : 'Word Document',
                  style: TextStyles.medium3(color: Colors.blue[700]!),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      );
    }

    // Image handling (default)
    return CachedNetworkImageWidget(
      imageUrl: url,
      fit: BoxFit.contain,
      errorWidget: Container(
        color: Colors.grey[200],
        child: Icon(Icons.broken_image, color: Colors.grey[400]),
      ),
    );
  }

  /* Widget _mediaCard({
    required Widget child,
    VoidCallback? onTap,
    bool isFullWidth = false,
  }) {
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
  }*/

  Widget _circleIcon({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }

  Widget _logoWithTitle(
      String logo,
      String company,
      String createdAt,
      String communityLogo,
      String userName,
      bool logoAvailable,
      String communityUserId,
      DirectoryViewModel directoryVM,
      BuildContext context,
      VoidCallback? onCommunityTap,
      String newsfeedCreatedId) {
    return GestureDetector(
      onTap: onCommunityTap,
      /*() async {
        Loaders.circularShowLoader(context);

        await directoryVM.GetDirectorDetails(communityUserId);
        await directoryVM.getDirectory(communityUserId);

        Loaders.circularHideLoader(context);

        navigationService.navigateTo(RouteList.directoryDetailsScreen);
      },*/
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                // ignore: unnecessary_null_comparison
                backgroundColor: (logo != null && logo.isNotEmpty)
                    ? AppColors.greyLight
                    : AppColors.primaryColor,
                radius: 26.5,
                // ignore: unnecessary_null_comparison
                child: (logo != null && logo.isNotEmpty)
                    ? SizedBox(
                        height: 52,
                        width: 52,
                        child: ClipOval(
                            child: CachedNetworkImageWidget(
                                imageUrl: communityLogo,
                                fit: BoxFit.contain,
                                errorWidget:
                                    Image.asset(ImageConst.directorProfile))),
                      )
                    : Text(
                        company[0].toUpperCase(),
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
                    child: (communityLogo.isNotEmpty)
                        ? SizedBox(
                            height: 30,
                            width: 30,
                            child: ClipOval(
                                child: CachedNetworkImageWidget(
                                    imageUrl: logo,
                                    fit: BoxFit.contain,
                                    errorWidget: Image.asset(
                                        ImageConst.directorProfile))),
                          )
                        : Text(
                            userName[0].toUpperCase(),
                            style:
                                TextStyles.bold5(color: AppColors.whiteColor),
                          ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(company, style: TextStyles.bold3(color: AppColors.black)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (userName.isNotEmpty)
                      GestureDetector(
                        onTap: () async {
                          Loaders.circularShowLoader(context);

                          await directoryVM.GetDirectorDetails(newsfeedCreatedId);
                          await directoryVM.getDirectory(newsfeedCreatedId);

                          Loaders.circularHideLoader(context);

                          navigationService
                              .navigateTo(RouteList.directoryDetailsScreen);
                        },
                        child: Text("$userName ",
                            style: TextStyles.regular1(
                                color: Colors.black, fontSize: 14)),
                      ),
                    Flexible(
                      child: Text(DateFormatUtils.formatDateTime(createdAt),
                          style: TextStyles.regular1(color: Colors.grey)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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

  Widget _buildCatalogueRow(CatalogueViewModel catalogueVM,
      BuildContext context, String catalogueId) {
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
        AppButton(
            text: 'View',
            height: 40,
            width: 100,
            onTap: () async {
              await catalogueVM.getCatalogDetails(context, catalogueId);
              final id =
                  catalogueVM.cataloguesByIdData?.catalogueCategoryId ?? '';
              await catalogueVM.getReletedCatalog(context, id);
              await navigationService.navigateTo(RouteList.catalogueDetails);
            })
      ],
    );
  }

  Widget _learnHubWidget(Courses course, String createdAt) {
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
                  onTap: onDetailView,
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

  Widget _jobsWidget(Jobs job, String createdAt, String? title) {
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
                _sectionWidget("Title", title ?? ""),
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
                  onTap: onDetailView,
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

  Widget _chipWidget(List<String> types, String meetingLink) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: types.map((type) {
        final label = type.isEmpty ? 'N/A' : type;
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
                  label,
                  style: TextStyles.regular1(
                    color: AppColors.typeTextColor,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            (meetingLink != "" && type == "Webinar")
                ? _meetingLinkWidget(meetingLink)
                : SizedBox.shrink(),
          ],
        );
      }).toList(),
    );
  }

  Widget _meetingLinkWidget(String link) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: const Color.fromARGB(37, 255, 255, 255),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.HINT_COLOR)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        child: GestureDetector(
          onTap: () async {
            final url = Uri.parse(link);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              scaffoldMessenger("Invalid link !!");
            }
          },
          child: Text(
            "Meeting Link",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.regular1(
              color: AppColors.bottomNavUnSelectedColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuWidget(BuildContext context, String type,
      List<PostImage>? imageUrls, bool isSameUser) {
    return PopupMenuButton<String>(
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero, // removes inside padding
      constraints: const BoxConstraints(
          minWidth: 0, minHeight: 0), // remove default 48x48
      icon: Icon(Icons.more_vert,
          size: 20, color: AppColors.bottomNavUnSelectedColor),
      onSelected: (value) => onMenuAction?.call(value, id),
      itemBuilder: (context) => [
        if (isSameUser && feedType == FeedType.newsfeed.value) ...[
          _popupItem("Edit", Icons.edit, AppColors.blueColor),
        ],
        if (type == UserRole.supplier.value &&
            feedUserRole == UserRole.supplier.value) ...[
          if (status == "UNPUBLISHED" || status == "PENDING")
            _popupItem("Publish", Icons.send, AppColors.blueColor),
          if (status == "PUBLISHED")
            _popupItem("Unpublish", Icons.send, AppColors.redColor),
        ] else if (type != UserRole.professional.value) ...[
          if (status == "UNPUBLISHED" || status == "PENDING")
            _popupItem("Publish", Icons.send, AppColors.blueColor),
          if (status == "PUBLISHED")
            _popupItem("Unpublish", Icons.send, AppColors.redColor),
        ],
        if (!isSameUser) ...[
          _popupItem("Hide Post", Icons.hide_source, AppColors.redColor),
          _popupItem("Report Post", Icons.report, AppColors.redColor),
          _popupItem("Block Profile", Icons.block, AppColors.redColor),
          if (imageUrls?.isNotEmpty == true)
            _popupItem("Save Media", Icons.save, AppColors.greenColor)
        ],
      ],
    );
  }

  PopupMenuItem<String> _popupItem(String label, IconData icon, Color color) {
    return PopupMenuItem(
      value: label,
      child: Row(children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Text(label, style: TextStyles.semiBold(color: color, fontSize: 14))
      ]),
    );
  }

  bool _isValidVideoUrl(String url) {
    return url.contains('youtube.com') ||
        url.contains('youtu.be') ||
        url.contains('drive.google.com') ||
        url.contains('loom.com') ||
        url.contains('vimeo.com');
  }
}
