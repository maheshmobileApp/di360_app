import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/view/community_comment_feed_details.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/view/community_comment_sheet.dart';
import 'package:di360_flutter/feature/news_feed_community_comment/view_model/news_feed_community_comment_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/feature/home/model_class/news_feed_comment_res.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/jiffy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CommunityCommentScreen extends StatefulWidget {
  final Newsfeeds? newsfeeds;
  const CommunityCommentScreen({super.key, required this.newsfeeds});

  @override
  State<CommunityCommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommunityCommentScreen>
    with BaseContextHelpers {
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
    final viewModel = Provider.of<NewsFeedCommunityCommentViewModel>(context);
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
                      ? Image.asset(ImageConst.directorProfile)
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
                              errorWidget: Image.asset(ImageConst.directorProfile)))),
            ),
            addHorizontal(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      widget.newsfeeds?.dentalSupplier?.businessName ??
                          widget.newsfeeds?.dentalPractice?.businessName ??
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
                    CommunityCommentFeedDetails(newsfeeds: widget.newsfeeds),
                    CommunityCommentSheet(newsfeeds: widget.newsfeeds),
                  ],
                ),
              ),
            ),
            _buildCommentInputField(context, viewModel, widget.newsfeeds),
            // File attachments preview
            // File attachments preview
            if (viewModel.existingAttachments.isNotEmpty || viewModel.selectedFiles.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...List.generate(
                      viewModel.existingAttachments.length,
                      (index) => _buildExistingFilePreview(
                          viewModel.existingAttachments[index], index, viewModel),
                    ),
                    ...List.generate(
                      viewModel.selectedFiles.length,
                      (index) => _buildFilePreview(
                          viewModel.selectedFiles[index], index, viewModel),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentInputField(BuildContext context,
      NewsFeedCommunityCommentViewModel viewModel, Newsfeeds? newsfeeds) {
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
                      child: Icon(Icons.attachment,
                          color: AppColors.lightGeryColor),
                      onTap: () {
                        viewModel.pickFiles();
                      },
                    ),
                    addHorizontal(10),
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

  Widget _buildExistingFilePreview(CommentsAttachments attachment, int index,
      NewsFeedCommunityCommentViewModel viewModel) {
    final ext = attachment.name?.split('.').last.toLowerCase();
    return Stack(
      children: [
        Container(
          width: 60,
          height: 60,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ['jpg', 'png', 'jpeg'].contains(ext)
                ? CachedNetworkImageWidget(
                    imageUrl: attachment.url ?? '',
                    fit: BoxFit.cover,
                    errorWidget: Icon(Icons.broken_image, color: Colors.grey),
                  )
                : _getFileIcon(ext),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => viewModel.removeExistingAttachment(index),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
              child: const Icon(Icons.close, color: Colors.white, size: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilePreview(dynamic file, int index, NewsFeedCommunityCommentViewModel viewModel) {
    final extension = file.extension?.toLowerCase();
    return Stack(
      children: [
        Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _getFileIcon(extension),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => viewModel.removeFile(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 14),
            ),
          ),
        )
      ],
    );
  }

  Widget _getFileIcon(String? extension) {
    if (['jpg', 'png', 'jpeg'].contains(extension)) {
      return Icon(Icons.image, size: 30, color: Colors.blue);
    } else if (extension == 'pdf') {
      return Icon(Icons.picture_as_pdf, size: 30, color: Colors.red);
    } else if (['mp4', 'mov', 'avi'].contains(extension)) {
      return Icon(Icons.videocam, size: 30, color: Colors.purple);
    } else {
      return Icon(Icons.insert_drive_file, size: 30, color: Colors.grey);
    }
  }
}
