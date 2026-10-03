import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_comment_res.dart';
import 'package:di360_flutter/feature/news_feed/view/inline_video_play.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/view/community_comment_reply_widget.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/view/image_viewr_screen_community.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/view_model/news_feed_community_comment_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityCommentSheet extends StatefulWidget with BaseContextHelpers {
  final Newsfeeds? newsfeeds;
  const CommunityCommentSheet({super.key, this.newsfeeds});

  @override
  State<CommunityCommentSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommunityCommentSheet>
    with BaseContextHelpers {
  final Map<String, double> _replyHeights = {};
  final Map<String, GlobalKey> _replyKeys = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsFeedCommunityCommentViewModel>(context);

    final comments = [...?viewModel.newsFeedComments?.newsFeedsComments];

    comments.sort((a, b) => (b.createdAt ?? "").compareTo(a.createdAt ?? ""));

    for (final comment in comments) {
      if (comment.id != null && !_replyKeys.containsKey(comment.id)) {
        _replyKeys[comment.id!] = GlobalKey();
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: comments.isEmpty
          ? Center(
              child: Text(
                "No Comments",
                style: TextStyles.clashSemiBold(
                  color: AppColors.black,
                  fontSize: 20,
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return _buildCommentTile(
                  comments[index],
                  viewModel,
                  widget.newsfeeds?.id ?? "",
                );
              },
            ),
    );
  }

  Widget _buildCommentTile(NewsFeedsComments? comments,
      NewsFeedCommunityCommentViewModel viewModel, String feedId,
      {int depth = 0}) {
    if (comments?.id == null) {
      return const SizedBox.shrink();
    }

    final replyKey = _replyKeys[comments!.id!];

    if (replyKey == null) {
      return const SizedBox.shrink();
    }
    final apiCount = comments.repliesAggregate?.aggregate?.count ?? 0;
    final cacheCount = viewModel.repliesDataCache[comments.id]?.length ?? 0;

    final replyCount = apiCount > cacheCount ? apiCount : cacheCount;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.black,
                radius: 20.5,
                child: CircleAvatar(
                  backgroundColor: AppColors.whiteColor,
                  radius: 20,
                  child: ClipOval(
                    child: CachedNetworkImageWidget(
                      imageUrl: comments.commentProImg ??
                          comments.dentalSupplier?.logo?.url ??
                          comments.dentalPractice?.logo?.url ??
                          comments.dentalProfessional?.profileImage?.url ??
                          comments.adminUser?.profileImage?.url ??
                          '',
                      errorWidget: Image.asset(ImageConst.directorProfile),
                    ),
                  ),
                ),
              ),
              if ((comments.commentReply?.isNotEmpty ?? false))
                Container(
                  width: 2,
                  height: (comments.commentReply?.isNotEmpty ?? false)
                      ? (_replyHeights[comments.id]
                              ?.clamp(0, double.infinity) ??
                          80)
                      : 0,
                  color: Colors.grey.shade400,
                ),
            ],
          ),
          addHorizontal(8),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_getCommenterName(comments),
                              style: TextStyles.semiBold(
                                  color: AppColors.black, fontSize: 14)),
                          addHorizontal(20),
                          Row(
                            children: [
                              Text(
                                DateFormatUtils.formatDate(
                                  comments.createdAt ?? '',
                                ),
                                style: TextStyles.regular1(
                                    fontSize: 10,
                                    color: AppColors.lightGeryColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                              addHorizontal(15),
                              if (comments.dentalSupplier?.id ==
                                      viewModel.userID ||
                                  comments.dentalPractice?.id ==
                                      viewModel.userID ||
                                  comments.dentalProfessional?.id ==
                                      viewModel.userID ||
                                  comments.adminUser?.id == viewModel.userID)
                                _buildCommentMenu(comments, viewModel, feedId),
                            ],
                          ),
                        ],
                      ),
                      addVertical(6),
                      Text(
                        comments.commentText ?? '',
                        style: TextStyles.regular2(
                            color: AppColors.bottomNavUnSelectedColor),
                      ),
                      _buildImageRow(comments.commentsAttachments),
                    ],
                  ),
                ),
                addVertical(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (((replyCount) > 0) && !(viewModel.expandedReplies[comments.id] ?? false))
                      GestureDetector(
                        onTap: () => _handleViewReplyTap(comments, viewModel),
                        child: Text(
                          viewModel.expandedReplies[comments.id] ?? false
                              ? 'Hide replies'
                              : 'View $replyCount replies',
                          style: TextStyles.bold2(color: AppColors.black),
                        ),
                      ),
                    GestureDetector(
                      onTap: () => _handleReplyTap(comments, viewModel),
                      child: Text('Reply',
                          style: TextStyles.bold2(color: AppColors.black)),
                    ),
                  ],
                ),
                if (viewModel.expandedReplies[comments.id] ?? false)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: _buildRepliesSection(
                        comments.id ?? "", feedId, replyKey, viewModel,
                        depth: depth + 1),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleViewReplyTap(NewsFeedsComments comments,
      NewsFeedCommunityCommentViewModel viewModel) async {
    final commentId = comments.id ?? '';
    final isExpanded = viewModel.expandedReplies[commentId] ?? false;

    if (isExpanded) {
      // Collapsing replies
      viewModel.toggleReplyExpansion(commentId);
    } else {
      // Expanding replies - load them first if not already loaded
      if (!viewModel.repliesDataCache.containsKey(commentId)) {
        await viewModel.loadReplies(context, commentId);
      }
      // Now toggle to show the replies
      viewModel.toggleReplyExpansion(commentId);
    }
  }

  Widget _buildImageRow(List<CommentsAttachments>? allMediaList) {
    final mediaList = allMediaList ?? [];
    if (mediaList.isEmpty) return SizedBox();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: mediaList.length == 1
          ? _buildSingleMedia(mediaList.first, mediaList)
          : _buildMultipleMedia(mediaList),
    );
  }

  Widget _buildSingleMedia(
      CommentsAttachments media, List<CommentsAttachments> allMedia) {
    return GestureDetector(
      onTap: () => navigationService.push(ImageViewrScreenCommunity(
          postImage: allMedia as List<CommentsAttachments>?)),
      child: Container(
        width: double.infinity,
        height: 100,
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

  Widget _buildMultipleMedia(List<CommentsAttachments> mediaList) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: mediaList.length,
        separatorBuilder: (_, __) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          final media = mediaList[index];
          return GestureDetector(
            onTap: () => navigationService.push(ImageViewrScreenCommunity(
                postImage: mediaList as List<CommentsAttachments>?)),
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

  Widget _buildMediaWidget(CommentsAttachments media,
      {bool isFullSize = false}) {
    final type = media.type ?? media.type ?? '';
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

  Widget _buildCommentMenu(NewsFeedsComments comments,
      NewsFeedCommunityCommentViewModel viewModel, String feedId) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final offset = details.globalPosition;
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          items: [
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  const Icon(Icons.edit, color: Colors.blue, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Edit',
                    style:
                        TextStyles.semiBold(color: Colors.blue, fontSize: 14),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  const Icon(Icons.delete, color: Colors.red, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Delete',
                    style: TextStyles.semiBold(color: Colors.red, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ).then((value) {
          if (value == 'edit') {
            _handleEditComment(comments, viewModel);
          } else if (value == 'delete') {
            viewModel.deleteTheComment(context, comments.id ?? '', feedId);
          }
        });
      },
      child: const Icon(Icons.more_horiz, size: 20),
    );
  }

  void _handleEditComment(
      NewsFeedsComments comments, NewsFeedCommunityCommentViewModel viewModel) {
    FocusScope.of(navigatorKey.currentContext!)
        .requestFocus(viewModel.replyFocusNode);
    final comment = comments.commentText ?? '';
    viewModel.commentController.text = comment;
    viewModel.setEditAttachments(comments.commentsAttachments);
    viewModel.selectedCommentId = comments.id;

    viewModel.updateIsReply(
      false,
      comments.id ?? '',
      '',
      commentupdate: true,
    );
  }

  String _getCommenterName(NewsFeedsComments? comments) {
    return comments?.dentalSupplier?.businessName ??
        comments?.dentalPractice?.businessName ??
        comments?.dentalProfessional?.name ??
        comments?.adminUser?.name ??
        comments?.commenterName ??
        'Unknown';
  }

  void _handleReplyTap(
      NewsFeedsComments comments, NewsFeedCommunityCommentViewModel viewModel) {
    final commenterName = _getCommenterName(comments);
    viewModel.updateHintText('Reply to @$commenterName', removeReplyVal: true);
    viewModel.commentController.clear();
    viewModel.updateIsReply(
      true,
      comments.id ?? '',
      commenterName,
      refreshId: comments.id ?? "",
    );
    FocusScope.of(navigatorKey.currentContext!)
        .requestFocus(viewModel.replyFocusNode);
  }

  Widget _buildRepliesSection(String commentId, String feedId,
      GlobalKey replyKey, NewsFeedCommunityCommentViewModel viewModel,
      {int depth = 1}) {
    final replies = viewModel.repliesDataCache[commentId] ?? [];
    return MeasureSize(
      onChange: (size) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {});
          }
        });
      },
      child: Container(
        key: replyKey,
        child: ListView.builder(
          itemCount: replies?.length ?? 0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final commentReply = replies[index];
            return CommunityCommentReplyWidget(
                comments: commentReply, feedId: feedId, depth: depth);
          },
        ),
      ),
    );
  }
}

// Helper widget to measure size changes
class MeasureSize extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize!);
  }
}
