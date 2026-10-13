import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_comment_res.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/view_model/news_feed_community_comment_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityCommentReplyWidget extends StatefulWidget
    with BaseContextHelpers {
  final NewsFeedsComments? comments;
  final String feedId;
  final int depth;
  const CommunityCommentReplyWidget(
      {super.key, this.comments, required this.feedId, this.depth = 0});

  @override
  State<CommunityCommentReplyWidget> createState() =>
      _CommunityCommentReplyWidgetState();
}

class _CommunityCommentReplyWidgetState
    extends State<CommunityCommentReplyWidget> with BaseContextHelpers {
  String get _commenterName =>
      widget.comments?.dentalSupplier?.businessName ??
      widget.comments?.dentalPractice?.businessName ??
      widget.comments?.dentalProfessional?.name ??
      widget.comments?.adminUser?.name ??
      widget.comments?.commenterName ??
      'Unknown';

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsFeedCommunityCommentViewModel>(context);
    final replyCount = widget.comments?.repliesAggregate?.aggregate?.count ?? 0;
    final isExpanded = viewModel.expandedReplies[widget.comments?.id] ?? false;
    final nestedReplies = viewModel.repliesDataCache[widget.comments?.id] ?? [];

    if (widget.comments?.id == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(left: widget.depth * 12.0, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.black,
                    radius: 18.5,
                    child: CircleAvatar(
                      backgroundColor: AppColors.whiteColor,
                      radius: 18,
                      child: ClipOval(
                        child: CachedNetworkImageWidget(
                          imageUrl: widget
                                  .comments?.dentalSupplier?.logo?.url ??
                              widget.comments?.dentalPractice?.logo?.url ??
                              widget.comments?.dentalProfessional?.profileImage
                                  ?.url ??
                              widget.comments?.adminUser?.profileImage?.url ??
                              '',
                          errorWidget: Image.asset(ImageConst.directorProfile),
                        ),
                      ),
                    ),
                  ),
                  /*if (widget.depth > 0)
                    Positioned(
                      top: 1,
                      bottom: 18,
                      left: -48.7,
                      child: CustomPaint(
                        size: const Size(40, 0),
                        painter: CurvedLinePainter(),
                      ),
                    ),*/
                ],
              ),
              addHorizontal(8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.backgroundColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              _commenterName,
                              style: TextStyles.semiBold(
                                  color: AppColors.black, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          addHorizontal(8),
                          Flexible(
                            child: Text(
                              DateFormatUtils.formatDate(
                                widget.comments?.createdAt ?? '',
                              ),
                              style: TextStyles.regular1(
                                  fontSize: 10,
                                  color: AppColors.lightGeryColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.comments?.createdById == viewModel.userID)
                            _buildMenu(context, viewModel),
                        ],
                      ),
                      addVertical(4),
                      Text(
                        widget.comments?.commentText ?? '',
                        style: TextStyles.regular1(
                            color: AppColors.bottomNavUnSelectedColor),
                      ),
                      if ((widget.comments?.commentsAttachments?.isNotEmpty ??
                          false))
                        _buildMediaRow(widget.comments?.commentsAttachments),
                    ],
                  ),
                ),
              ),
            ],
          ),
          addVertical(4),
          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: Row(
              children: [
                if (((replyCount) > 0) && !(viewModel.expandedReplies[widget.comments?.id] ?? false))
                  GestureDetector(
                    onTap: () async {
                      if (!isExpanded) {
                        await viewModel.loadReplies(
                            context, widget.comments!.id!);
                      } else {
                        viewModel.toggleReplyExpansion(widget.comments!.id!);
                      }
                    },
                    child: Text(
                      isExpanded ? "Hide replies" : "View $replyCount replies",
                      style: TextStyles.bold2(color: AppColors.black),
                    ),
                  ),
                if (replyCount > 0) addHorizontal(16),
                GestureDetector(
                  onTap: () {
                    viewModel.updateHintText('Reply to @$_commenterName',
                        removeReplyVal: true);
                    viewModel.commentController.clear();
                    viewModel.updateIsReply(
                        true, widget.comments?.id ?? '', _commenterName);
                    FocusScope.of(navigatorKey.currentContext!)
                        .requestFocus(viewModel.replyFocusNode);
                  },
                  child: Text('Reply',
                      style: TextStyles.bold2(color: AppColors.black)),
                ),
              ],
            ),
          ),
          if (isExpanded && nestedReplies.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: nestedReplies.length,
                itemBuilder: (context, index) => CommunityCommentReplyWidget(
                  comments: nestedReplies[index],
                  feedId: widget.feedId,
                  depth: widget.depth + 1,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenu(
      BuildContext context, NewsFeedCommunityCommentViewModel viewModel) {
    return GestureDetector(
      onTapDown: (details) {
        final offset = details.globalPosition;
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          items: [
            PopupMenuItem(
              value: 'edit',
              child: Row(children: [
                const Icon(Icons.edit, color: Colors.blue, size: 18),
                const SizedBox(width: 8),
                Text('Edit',
                    style:
                        TextStyles.semiBold(color: Colors.blue, fontSize: 14)),
              ]),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(children: [
                const Icon(Icons.delete, color: Colors.red, size: 18),
                const SizedBox(width: 8),
                Text('Delete',
                    style:
                        TextStyles.semiBold(color: Colors.red, fontSize: 14)),
              ]),
            ),
          ],
        ).then((value) {
          if (value == 'edit') {
            /*FocusScope.of(navigatorKey.currentContext!)
                .requestFocus(viewModel.replyFocusNode);
            final comment = widget.comments?.commentText ?? '';
            viewModel.commentController.text = comment;
            viewModel.setEditAttachments(widget.comments?.commentsAttachments);
            viewModel.selectedCommentId = widget.comments?.id;
            viewModel.updateIsReply(
                false, widget.comments?.id ?? '', _commenterName,
                isedit: true);*/
            viewModel.EditReplyComment(widget.comments);
          } else if (value == 'delete') {
            viewModel.deleteTheReplyComment(context, widget.comments?.id ?? '',
                widget.feedId, widget.comments?.parentCommentId ?? '');
          }
        });
      },
      child: const Icon(Icons.more_horiz, size: 20),
    );
  }

  Widget _buildMediaRow(List<CommentsAttachments>? mediaList) {
    final list = mediaList ?? [];
    if (list.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        height: 80,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final media = list[index];
            return Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _buildMediaWidget(media),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMediaWidget(CommentsAttachments media) {
    final type = media.type ?? '';
    final url = media.url ?? '';
    final name = media.name ?? '';

    // Video handling
    if (type.contains('video') || name.endsWith('.mp4')) {
      return Container(
        color: Colors.black87,
        child: const Center(
          child: Icon(Icons.play_circle_fill, color: Colors.white, size: 32),
        ),
      );
    }

    // PDF handling
    if (type.contains('pdf') || name.endsWith('.pdf')) {
      return Container(
        color: Colors.red[50],
        child: Center(
          child: Icon(Icons.picture_as_pdf, size: 32, color: Colors.red),
        ),
      );
    }

    // Document handling
    if (type.contains('msword') ||
        name.endsWith('.doc') ||
        name.endsWith('.docx')) {
      return Container(
        color: Colors.blue[50],
        child: Center(
          child: Icon(Icons.description, size: 32, color: Colors.blue),
        ),
      );
    }

    // Image handling (default)
    return CachedNetworkImageWidget(
      imageUrl: url,
      fit: BoxFit.cover,
      errorWidget: Container(
        color: Colors.grey[200],
        child: Icon(Icons.broken_image, color: Colors.grey[400]),
      ),
    );
  }
}

class CurvedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width / 2, 0); // Start from top center
    path.lineTo(size.width / 2, size.height / 8); // Vertical line
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 0.80,
      size.width,
      size.height,
    ); // Curve to bottom-right

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
