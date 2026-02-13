import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/catalogue/catalogue_view_model/catalogue_view_model.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/news_feed/view/images_full_view.dart';
import 'package:di360_flutter/feature/news_feed/view/inline_video_play.dart';
import 'package:di360_flutter/feature/news_feed/view/pdf_word_viewr.dart';
import 'package:di360_flutter/feature/news_feed_community/enums/feed_type_enum.dart';
import 'package:di360_flutter/feature/news_feed_community/widgets/youtube_player_widget.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/share_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
  final int likes;
  final int comments;
  final bool isLiked;
  final Newsfeeds? newsfeeds;

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
    required this.likes,
    required this.feedType,
    this.isLiked = false,
    this.newsfeeds,
  }) {}

  @override
  Widget build(BuildContext context) {
    final feedTypeEnum = FeedType.fromString(feedType);
    final catelougeViewModel = Provider.of<CatalogueViewModel>(context);

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _logoWithTitle(
                            logoUrl,
                            companyName,
                            createdAt,
                          ),
                        ),
                        if (type == "SUPPLIER" ||
                            (type == "PROFESSIONAL" &&
                                feedUserRole != "SUPPLIER" && newsfeeds?.userId == LocalStorage.getStringVal(LocalStorageConst.userId)))
                          Row(
                            children: [
                              _menuWidget(context, type),
                            ],
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const SizedBox(height: 8),
                    HtmlWidget(
                      description,
                      textStyle: TextStyles.regular2(color: AppColors.black),
                    ),
                    const SizedBox(height: 8),

                    (imageUrls?.isNotEmpty ?? false)
                        ? _buildImageRow(imageUrls)
                        : SizedBox.shrink(),
                    if (newsfeeds?.videoUrl != null &&
                        newsfeeds!.videoUrl!.isNotEmpty &&
                        _isValidYoutubeUrl(newsfeeds!.videoUrl!))
                      YoutubeThumbnailPlayerWidget(videoUrl: newsfeeds!.videoUrl!),
                    const SizedBox(height: 8),

                    if (newsfeeds?.webUrl != null && newsfeeds!.webUrl!.isNotEmpty)
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

                    if (feedTypeEnum == FeedType.LEARNHUB &&
                        course?.isNotEmpty == true)
                      _learnHubWidget(course?.first ?? Courses(), createdAt),
                    if (feedTypeEnum == FeedType.CATALOGUE)
                      _buildCatalogueRow(catelougeViewModel, context),
                    if (feedTypeEnum == FeedType.JOBS &&
                        job?.isNotEmpty == true)
                      _jobsWidget(job?.first ?? Jobs(), createdAt),

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
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          size: 20, feedId: id,),

                        const Spacer(),

                        /// 💬 Comment Icon + Count
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
        height: 200,
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

  Widget _mediaCard({
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
  }

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
  ) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.geryColor,
              radius: 30,
              child: logo.isNotEmpty
                  ? ClipOval(
                      child: CachedNetworkImageWidget(
                        imageUrl: logo,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.person,
                      size: 20, color: AppColors.lightGeryColor),
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
              Text(DateFormatUtils.formatDateTime(createdAt),
                  style: TextStyles.regular1(color: Colors.grey)),
            ],
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

  Widget _buildCatalogueRow(
      CatalogueViewModel catalogueVM, BuildContext context) {
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
              await catalogueVM.getCatalogDetails(
                  context, newsfeeds?.payload?.catalogueId ?? '');
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

  Widget _jobsWidget(Jobs job, String createdAt) {
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

  Widget _menuWidget(BuildContext context, String type) {
    return PopupMenuButton<String>(
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero, // removes inside padding
      constraints: const BoxConstraints(
        minWidth: 0,
        minHeight: 0,
      ), // remove default 48x48
      icon: Icon(
        Icons.more_vert,
        size: 20,
        color: AppColors.bottomNavUnSelectedColor,
      ),
      onSelected: (value) => onMenuAction?.call(value, id),
      itemBuilder: (context) => [
        if (type == "PROFESSIONAL" && (newsfeeds?.userId == LocalStorage.getStringVal(LocalStorageConst.userId)) ||
            (type == "SUPPLIER" && feedUserRole == "SUPPLIER")) ...[
          _popupItem("Edit", Icons.edit, AppColors.blueColor),
          _popupItem("Delete", Icons.delete, AppColors.redColor)
        ],
        if (type == "SUPPLIER" && feedUserRole == "SUPPLIER") ...[
          if (status == "UNPUBLISHED" || status == "PENDING")
            _popupItem("Publish", Icons.send, AppColors.blueColor),
          if (status == "PUBLISHED" || status == "PENDING")
            _popupItem("Unpublish", Icons.send, AppColors.redColor),
        ] else if (type != "PROFESSIONAL") ...[
          if (status == "UNPUBLISHED" || status == "PENDING")
            _popupItem("Publish", Icons.send, AppColors.blueColor),
          if (status == "PUBLISHED" || status == "PENDING")
            _popupItem("Unpublish", Icons.send, AppColors.redColor),
        ]
      ],
    );
  }

  PopupMenuItem<String> _popupItem(String label, IconData icon, Color color) {
    return PopupMenuItem(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(label, style: TextStyles.semiBold(color: color, fontSize: 14)),
        ],
      ),
    );
  }

  bool _isValidYoutubeUrl(String url) {
    return url.contains('youtube.com') || url.contains('youtu.be');
  }
}
