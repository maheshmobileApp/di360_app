import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/news_feed_comment/comment_view_model/comment_view_model.dart';
import 'package:di360_flutter/feature/news_feed_comment/view/comment_sheet.dart';
import 'package:di360_flutter/feature/news_feed_comment/view/feed_details.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/jiffy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final Newsfeeds? newsfeeds;
  const CommentScreen({super.key, this.newsfeeds});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> with BaseContextHelpers {
  // @override
  // void dispose() {
  //   final viewModel = Provider.of<CommentViewModel>(context, listen: false);
  //   if (viewModel.replyFocusNode.hasFocus) {
  //     viewModel.replyFocusNode.unfocus();
  //   }
  //   viewModel.replyFocusNode.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommentViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: GestureDetector(
          onTap: () => navigationService.goBack(),
          child:
              Icon(Icons.keyboard_arrow_left, color: AppColors.black, size: 40),
        ),
        titleSpacing: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.black,
              radius: 23.5,
              child: CircleAvatar(
                  radius: 23,
                  backgroundColor: AppColors.whiteColor,
                  child: ((widget.newsfeeds?.dentalSupplier?.logo?.url ??
                              widget.newsfeeds?.dentalPractice?.logo?.url ??
                              widget.newsfeeds?.dentalProfessional?.profileImage
                                  ?.url ??
                              widget.newsfeeds?.dentalSupplier?.directories
                                  ?.first.logo?.url ??
                              '') ==
                          '')
                      ? SvgPicture.asset(ImageConst.logo)
                      : ClipOval(
                          child: CachedNetworkImageWidget(
                              imageUrl:
                                  widget.newsfeeds?.dentalSupplier?.logo?.url ??
                                      widget.newsfeeds?.dentalPractice?.logo
                                          ?.url ??
                                      widget.newsfeeds?.dentalProfessional
                                          ?.profileImage?.url ??
                                      widget.newsfeeds?.dentalSupplier
                                          ?.directories?.first.logo?.url ??
                                      '',
                              errorWidget: SvgPicture.asset(ImageConst.logo)))),
            ),
            addHorizontal(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      widget.newsfeeds?.dentalSupplier?.name ??
                          widget.newsfeeds?.dentalPractice?.name ??
                          widget.newsfeeds?.dentalProfessional?.name ??
                          'Dental Interface',
                      style: TextStyles.clashMedium(
                          fontSize: 16, color: AppColors.black)),
                  Text(
                      jiffyDataWidget(widget.newsfeeds?.createdAt ?? '',
                          format: 'dd-MM-yyyy hh:mm a'),
                      style:
                          TextStyles.regular1(color: AppColors.lightGeryColor)),
                ],
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FeedDetails(newsfeeds: widget.newsfeeds),
                    CommentBottomSheet(newsfeeds: widget.newsfeeds),
                  ],
                ),
              ),
            ),
            _buildCommentInputField(context, viewModel, widget.newsfeeds),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentInputField(
      BuildContext context, CommentViewModel viewModel, Newsfeeds? newsfeeds) {
    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.dividerColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    addHorizontal(10),
                    Expanded(
                      child: TextFormField(
                        controller: viewModel.commentController,
                        focusNode: viewModel.replyFocusNode,
                        onFieldSubmitted: (value) {
                          viewModel.updateHintText('Write your comment...',
                              removeReplyVal: false);
                        },
                        decoration: InputDecoration(
                            hintText:
                                viewModel.hintText ?? "Write your comment...",
                            border: InputBorder.none,
                            hintStyle: TextStyles.regular1(
                                color: AppColors.lightGeryColor)),
                      ),
                    ),
                    GestureDetector(
                        child: Image.asset(ImageConst.sendIcon,
                            color: AppColors.black),
                        onTap: () {
                          if (viewModel.commentController.text.isEmpty) {
                            scaffoldMessenger('Please enter comment');
                          } else {
                            FocusScope.of(context).unfocus();
                            viewModel.replyFocusNode.unfocus();
                            viewModel.replyFocusNode.canRequestFocus = false;
                            if (viewModel.isReply) {
                              viewModel.replyCommentTheFeed(
                                  context, newsfeeds?.id ?? '');
                            } else if (viewModel.replyCommentUpdate) {
                              viewModel.updateTheReplyCommentTheFeed(
                                  context, newsfeeds?.id ?? '');
                            } else if (viewModel.commentUpdate) {
                              viewModel.updateTheComment(
                                  context, newsfeeds?.id ?? '');
                            } else {
                              viewModel.addCommentTheFeed(
                                  context, newsfeeds?.id ?? '');
                            }
                            viewModel.updateHintText('Write your comment...',
                                removeReplyVal: false);
                          }
                        }),
                    addHorizontal(10)
                  ],
                ),
              ),
            ),
          ),
          if (viewModel.removeReplyFeild)
            Positioned(
                right: 5,
                top: -10,
                child: InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    viewModel.replyFocusNode.unfocus();
                    viewModel.replyFocusNode.canRequestFocus = false;
                    viewModel.updateHintText('Write your comment...',
                        removeReplyVal: false);
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.black,
                    child: Icon(
                      Icons.close,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ))
        ],
      ),
    );
  }
}
