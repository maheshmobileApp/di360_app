import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_comment_res.dart';
import 'package:di360_flutter/feature/news_feed_comment/comment_view_model/comment_view_model.dart';
import 'package:di360_flutter/feature/news_feed_comment/view/reply_comment_widget.dart';
import 'package:di360_flutter/main.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/jiffy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CommentBottomSheet extends StatefulWidget with BaseContextHelpers {
  final Newsfeeds? newsfeeds;
  const CommentBottomSheet({super.key, this.newsfeeds});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet>
    with BaseContextHelpers {
  final Map<String, double> _replyHeights = {};
  final Map<String, GlobalKey> _replyKeys = {};

  // @override
  // void dispose() {
  //   final viewModel = Provider.of<CommentViewModel>(context, listen: false);
  //   if (viewModel.replyFocusNode.hasFocus) {
  //     viewModel.replyFocusNode.unfocus();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommentViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: widget.newsfeeds?.newsFeedsComments?.isEmpty ?? true
          ? Center(
              child: Text('No Comments',
                  style: TextStyles.clashSemiBold(
                      color: AppColors.black, fontSize: 20)))
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.newsfeeds?.newsFeedsComments?.length,
              itemBuilder: (context, index) {
                final comments = widget.newsfeeds?.newsFeedsComments?[index];
                return _buildCommentTile(
                    comments, viewModel, widget.newsfeeds?.id ?? '');
              },
            ),
    );
  }

  Widget _buildCommentTile(
      NewsFeedsComments? comments, CommentViewModel viewModel, String feedId) {
    final replyKey =
        _replyKeys.putIfAbsent(comments?.id ?? '', () => GlobalKey());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = replyKey.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox;
        final newHeight = renderBox.size.height - 35;
        if (_replyHeights[comments?.id] != newHeight) {
          setState(() {
            _replyHeights[comments?.id ?? ''] = newHeight;
          });
        }
      }
    });

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
                      imageUrl: comments?.commentProImg ??
                          comments?.dentalSupplier?.logo?.url ??
                          comments?.dentalPractice?.logo?.url ??
                          comments?.dentalProfessional?.profileImage?.url ??
                          comments?.adminUser?.profileImage ??
                          '',
                      errorWidget: SvgPicture.asset(ImageConst.logo),
                    ),
                  ),
                ),
              ),
              if ((comments?.commentReply?.isNotEmpty ?? false))
                Container(
                  width: 2,
                  height: (comments?.commentReply?.isNotEmpty ?? false)
                      ? (_replyHeights[comments?.id]
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(comments?.commenterName ?? '',
                              style: TextStyles.semiBold(
                                  color: AppColors.black, fontSize: 14)),
                          addHorizontal(20),
                          Expanded(
                            child: Text(
                              jiffyDataWidget(comments?.createdAt ?? '',
                                  format: 'dd MMMM yyyy'),
                              style: TextStyles.regular2(
                                  color: AppColors.lightGeryColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          addHorizontal(15),
                          if (comments?.dentalAdminId == viewModel.userID ||
                              comments?.dentalPracticeId == viewModel.userID ||
                              comments?.dentalProfessionalId ==
                                  viewModel.userID ||
                              comments?.dentalSupplierId == viewModel.userID)
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
                                  items: [
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit,
                                              color: Colors.blue, size: 18),
                                          SizedBox(width: 8),
                                          Text(
                                            'Edit',
                                            style: TextStyles.semiBold(
                                                color: Colors.blue,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete,
                                              color: Colors.red, size: 18),
                                          SizedBox(width: 8),
                                          Text(
                                            'Delete',
                                            style: TextStyles.semiBold(
                                                color: Colors.red,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ).then((value) {
                                  if (value == 'edit') {
                                    FocusScope.of(navigatorKey.currentContext!)
                                        .requestFocus(viewModel.replyFocusNode);
                                    final comment = comments?.comments ?? '';
                                    viewModel.commentController.text = comment;
                                    viewModel.updateIsReply(
                                        false, comments?.id ?? '', '',
                                        commentupdate: true);
                                  } else if (value == 'delete') {
                                    viewModel.deleteTheComment(
                                        context, comments?.id ?? '', feedId);
                                  }
                                });
                              },
                              child: Icon(Icons.more_horiz, size: 20),
                            )
                        ],
                      ),
                      addVertical(6),
                      Text(
                        comments?.comments ?? '',
                        style: TextStyles.regular2(
                            color: AppColors.bottomNavUnSelectedColor),
                      ),
                    ],
                  ),
                ),
                addVertical(5),
                GestureDetector(
                  onTap: () {
                    viewModel.updateHintText('Reply to @${comments?.commenterName}',removeReplyVal: true);
                    viewModel.commentController.clear();
                    viewModel.updateIsReply(true, comments?.id ?? '',
                        comments?.commenterName ?? '');
                    FocusScope.of(navigatorKey.currentContext!)
                        .requestFocus(viewModel.replyFocusNode);
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text('Reply',
                        style: TextStyles.bold2(color: AppColors.black)),
                  ),
                ),
                Container(
                  key: replyKey,
                  child: ListView.builder(
                    itemCount: comments?.commentReply?.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final commentReply = comments?.commentReply?[index];
                      return ReplyCommentWidget(
                          comments: commentReply, feedId: feedId);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
