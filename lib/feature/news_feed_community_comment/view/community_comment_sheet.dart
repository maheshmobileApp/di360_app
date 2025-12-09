import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_comment_res.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/view/community_comment_reply_widget.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/view_model/news_feed_community_comment_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  List<NewsFeedsComments>? _sortedComments;

  @override
  void initState() {
    super.initState();
    _initializeSortedComments();
  }

  void _initializeSortedComments() {
    if (widget.newsfeeds?.newsFeedsComments != null) {
      // Create a deep copy to ensure we have a fresh list
      _sortedComments = List.from(widget.newsfeeds!.newsFeedsComments!);
      _sortedComments!.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      // Pre-create GlobalKeys to avoid duplicates
      for (var comment in _sortedComments!) {
        if (comment.id != null && !_replyKeys.containsKey(comment.id)) {
          _replyKeys[comment.id!] = GlobalKey();
        }
      }
    }
  }

  @override
  void didUpdateWidget(CommunityCommentSheet oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Always reinitialize when widget updates to ensure fresh data
    if (oldWidget.newsfeeds != widget.newsfeeds ||
        _hasCommentsChanged(oldWidget.newsfeeds?.newsFeedsComments,
            widget.newsfeeds?.newsFeedsComments)) {
      _initializeSortedComments();
    }
  }

  // Helper method to check if comments have actually changed
  bool _hasCommentsChanged(List<NewsFeedsComments>? oldComments,
      List<NewsFeedsComments>? newComments) {
    if (oldComments == null && newComments == null) return false;
    if (oldComments == null || newComments == null) return true;
    if (oldComments.length != newComments.length) return true;

    // Check if any comment content has changed
    for (int i = 0; i < oldComments.length; i++) {
      if (oldComments[i].id != newComments[i].id ||
          oldComments[i].comments != newComments[i].comments ||
          oldComments[i].createdAt != newComments[i].createdAt) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsFeedCommunityCommentViewModel>(context);

    // Always use the latest data from widget.newsfeeds
    final currentComments = widget.newsfeeds?.newsFeedsComments;

    // Update sorted comments if the source data has changed
    if (currentComments != null &&
        (_sortedComments == null ||
            _hasCommentsChanged(_sortedComments, currentComments))) {
      _initializeSortedComments();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _sortedComments?.isEmpty ?? true
          ? Center(
              child: Text('No Comments',
                  style: TextStyles.clashSemiBold(
                      color: AppColors.black, fontSize: 20)))
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _sortedComments?.length ?? 0,
              itemBuilder: (context, index) {
                final comments = _sortedComments?[index];
                return _buildCommentTile(
                    comments, viewModel, widget.newsfeeds?.id ?? '');
              },
            ),
    );
  }

  Widget _buildCommentTile(NewsFeedsComments? comments,
      NewsFeedCommunityCommentViewModel viewModel, String feedId) {
    if (comments?.id == null) {
      return const SizedBox.shrink();
    }

    final replyKey = _replyKeys[comments!.id!];

    if (replyKey == null) {
      return const SizedBox.shrink();
    }

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
                          comments.adminUser?.profileImage ??
                          '',
                      errorWidget: SvgPicture.asset(ImageConst.logo),
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
                          Text(comments.commenterName ?? '',
                              style: TextStyles.semiBold(
                                  color: AppColors.black, fontSize: 14)),
                          addHorizontal(20),
                          Row(
                            children: [
                              Text(
                                DateFormatUtils.formatDateTime(
                                  comments.createdAt ?? '',
                                ),
                                style: TextStyles.regular1(
                                    fontSize: 10,
                                    color: AppColors.lightGeryColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                              addHorizontal(15),
                              if (comments.dentalAdminId == viewModel.userID ||
                                  comments.dentalPracticeId ==
                                      viewModel.userID ||
                                  comments.dentalProfessionalId ==
                                      viewModel.userID ||
                                  comments.dentalSupplierId == viewModel.userID)
                                _buildCommentMenu(comments, viewModel, feedId),
                            ],
                          ),
                        ],
                      ),
                      addVertical(6),
                      Text(
                        comments.comments ?? '',
                        style: TextStyles.regular2(
                            color: AppColors.bottomNavUnSelectedColor),
                      ),
                    ],
                  ),
                ),
                addVertical(5),
                GestureDetector(
                  onTap: () => _handleReplyTap(comments, viewModel),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text('Reply',
                        style: TextStyles.bold2(color: AppColors.black)),
                  ),
                ),
                _buildRepliesSection(comments, feedId, replyKey),
              ],
            ),
          ),
        ],
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
    final comment = comments.comments ?? '';
    viewModel.commentController.text = comment;
    viewModel.updateIsReply(false, comments.id ?? '', '', commentupdate: true);
  }

  void _handleReplyTap(
      NewsFeedsComments comments, NewsFeedCommunityCommentViewModel viewModel) {
    viewModel.updateHintText('Reply to @${comments.commenterName}',
        removeReplyVal: true);
    viewModel.commentController.clear();
    viewModel.updateIsReply(
        true, comments.id ?? '', comments.commenterName ?? '');
    FocusScope.of(navigatorKey.currentContext!)
        .requestFocus(viewModel.replyFocusNode);
  }

  Widget _buildRepliesSection(
      NewsFeedsComments comments, String feedId, GlobalKey replyKey) {
    return MeasureSize(
      onChange: (size) {
        final newHeight = size.height - 35;
        if (_replyHeights[comments.id] != newHeight) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _replyHeights[comments.id ?? ''] = newHeight;
              });
            }
          });
        }
      },
      child: Container(
        key: replyKey,
        child: ListView.builder(
          itemCount: comments.commentReply?.length ?? 0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final commentReply = comments.commentReply?[index];
            return CommunityCommentReplyWidget(
                comments: commentReply, feedId: feedId);
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
