import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_comment_res.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/view_model/news_feed_community_comment_view_model.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CommunityCommentReplyWidget extends StatelessWidget with BaseContextHelpers {
  final CommentReply? comments;
  final String feedId;
  const CommunityCommentReplyWidget({super.key, this.comments, required this.feedId});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsFeedCommunityCommentViewModel>(context);
    return Column(
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
                Positioned(
                    top: 1,
                    bottom: 18,
                    left: -48.7,
                    child: CustomPaint(
                      size: Size(40, 0),
                      painter: CurvedLinePainter(),
                    ))
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
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          comments?.dentalSupplier?.name ??
                              comments?.dentalPractice?.name ??
                              comments?.dentalProfessional?.name ??
                              comments?.adminUser?.name ??
                              '',
                          style: TextStyles.semiBold(
                              color: AppColors.black, fontSize: 16),
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
                                              color: Colors.blue, fontSize: 14),
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
                                              color: Colors.red, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ).then((value) {
                                if (value == 'edit') {
                                  FocusScope.of(context)
                                      .requestFocus(viewModel.replyFocusNode);
                                  final comment = comments?.replyText ?? '';
                                  final spaceIndex = comment.indexOf(' ');
                                  late String last;
                                  if (spaceIndex == -1) {
                                    last = '';
                                  } else {
                                    last = comment.substring(spaceIndex + 1);
                                  }
                                  viewModel.commentController.text = last;
                                  viewModel.updateIsReply(
                                      false,
                                      comments?.id ?? '',
                                      comments?.dentalSupplier?.name ??
                                          comments?.dentalPractice?.name ??
                                          comments?.dentalProfessional?.name ??
                                          comments?.adminUser?.name ??
                                          '',
                                      isedit: true);
                                } else if (value == 'delete') {
                                  viewModel.deleteTheReplyComment(
                                      context, comments?.id ?? '', feedId);
                                }
                              });
                            },
                            child: Icon(Icons.more_horiz, size: 20),
                          )
                      ],
                    ),
                    Text(
                      comments?.replyText ?? '',
                      style: TextStyles.regular1(
                          color: AppColors.bottomNavUnSelectedColor),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        addVertical(6),
        GestureDetector(
          onTap: () {
            viewModel.updateHintText(
                'Reply to @${comments?.dentalSupplier?.name ?? comments?.dentalPractice?.name ?? comments?.dentalProfessional?.name ?? comments?.adminUser?.name}',
                removeReplyVal: true);
            viewModel.commentController.clear();
            viewModel.updateIsReply(
                true,
                comments?.commentId ?? '',
                comments?.dentalSupplier?.name ??
                    comments?.dentalPractice?.name ??
                    comments?.dentalProfessional?.name ??
                    comments?.adminUser?.name ??
                    '');
            FocusScope.of(context).requestFocus(viewModel.replyFocusNode);
          },
          child: Align(
              alignment: Alignment.bottomRight,
              child: Text('Reply',
                  style: TextStyles.bold2(color: AppColors.black))),
        ),
      ],
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
