import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_comment_res.dart';
import 'package:di360_flutter/feature/news_feed_comment/comment_view_model/comment_view_model.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NewReplyCommentWidget extends StatelessWidget with BaseContextHelpers {
  final NewsFeedsComments? comments;
  final String feedId;
  final int depth;

  const NewReplyCommentWidget({
    super.key,
    this.comments,
    required this.feedId,
    this.depth = 0,
  });

  String get _commenterName =>
      comments?.dentalSupplier?.businessName ??
      comments?.dentalPractice?.name ??
      comments?.dentalProfessional?.name ??
      comments?.adminUser?.name ??
      'Dental Interface';

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommentViewModel>(context);
    final replyCount = comments?.repliesAggregate?.aggregate?.count ?? 0;
    final isExpanded = viewModel.expandedReplies[comments?.id] ?? false;
    final nestedReplies = viewModel.repliesDataCache[comments?.id] ?? [];

    return Padding(
      padding: EdgeInsets.only(left: depth * 12.0, top: 8),
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
                          imageUrl: comments?.dentalSupplier?.logo?.url ??
                              comments?.dentalPractice?.logo?.url ??
                              comments?.dentalProfessional?.profileImage?.url ??
                              comments?.adminUser?.profileImage ??
                              '',
                          errorWidget: SvgPicture.asset(ImageConst.logo),
                        ),
                      ),
                    ),
                  ),
                  if (depth > 0)
                    Positioned(
                      top: 1,
                      bottom: 18,
                      left: -48.7,
                      child: CustomPaint(
                        size: const Size(40, 0),
                        painter: CurvedLinePainter(),
                      ),
                    ),
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
                        children: [
                          Expanded(
                            child: Text(
                              _commenterName,
                              style: TextStyles.semiBold(
                                  color: AppColors.black, fontSize: 14),
                            ),
                          ),
                          if (comments?.createdById == viewModel.userID)
                            _buildMenu(context, viewModel),
                        ],
                      ),
                      addVertical(4),
                      Text(
                        comments?.commentText ?? '',
                        style: TextStyles.regular1(
                            color: AppColors.bottomNavUnSelectedColor),
                      ),
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
                if (replyCount > 0)
                  GestureDetector(
                    onTap: () async {
                      if (!isExpanded) {
                        await viewModel.getReplies(context, comments!.id!);
                      }
                      viewModel.toggleReplyExpansion(comments?.id ?? '');
                    },
                    child: Text(
                      isExpanded
                          ? 'Hide replies'
                          : 'View $replyCount replies',
                      style: TextStyles.bold2(color: AppColors.black),
                    ),
                  ),
                if (replyCount > 0) addHorizontal(16),
                GestureDetector(
                  onTap: () {
                    viewModel.updateHintText(
                        'Reply to @$_commenterName',
                        removeReplyVal: true);
                    viewModel.commentController.clear();
                    viewModel.updateIsReply(
                        true, comments?.id ?? '', _commenterName);
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
                itemBuilder: (context, index) => NewReplyCommentWidget(
                  comments: nestedReplies[index],
                  feedId: feedId,
                  depth: depth + 1,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context, CommentViewModel viewModel) {
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
                    style: TextStyles.semiBold(color: Colors.blue, fontSize: 14)),
              ]),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(children: [
                const Icon(Icons.delete, color: Colors.red, size: 18),
                const SizedBox(width: 8),
                Text('Delete',
                    style: TextStyles.semiBold(color: Colors.red, fontSize: 14)),
              ]),
            ),
          ],
        ).then((value) {
          if (value == 'edit') {
            FocusScope.of(navigatorKey.currentContext!)
                .requestFocus(viewModel.replyFocusNode);
            final comment = comments?.commentText ?? '';
            final spaceIndex = comment.indexOf(' ');
            viewModel.commentController.text =
                spaceIndex == -1 ? '' : comment.substring(spaceIndex + 1);
            viewModel.updateIsReply(
                false, comments?.id ?? '', _commenterName,
                isedit: true);
          } else if (value == 'delete') {
            viewModel.deleteTheReplyComment(
                context,
                comments?.id ?? '',
                feedId,
                comments?.parentCommentId ?? '');
          }
        });
      },
      child: const Icon(Icons.more_horiz, size: 20),
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
