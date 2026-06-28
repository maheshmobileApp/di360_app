import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/add_news_feed_view_model.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/feature/news_feed_community/widgets/show_report_popup.dart';
import 'package:di360_flutter/services/download_file.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/admin_news_feed_enum.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsMenuWidget extends StatefulWidget {
  final Newsfeeds? newsfeeds;
  const NewsMenuWidget({super.key, this.newsfeeds});

  @override
  State<NewsMenuWidget> createState() => _NewsMenuWidgetState();
}

class _NewsMenuWidgetState extends State<NewsMenuWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsFeedViewModel>(context, listen: false).getUserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsFeedViewModel =
        Provider.of<NewsFeedViewModel>(context, listen: false);
    final addNeedFeedViewModel = Provider.of<AddNewsFeedViewModel>(context);
    final currentUserId = newsFeedViewModel.userID;

    final isSameUser = widget.newsfeeds?.userId == currentUserId ||
        widget.newsfeeds?.dentalPracticeId == currentUserId ||
        widget.newsfeeds?.dentalProfessionalId == currentUserId ||
        widget.newsfeeds?.dentalSupplierId == currentUserId;

    return PopupMenuButton<String>(
      iconColor: AppColors.black,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.all(0),
      onSelected: (value) async {
        if (value == 'edit') {
          await addNeedFeedViewModel.fetchNewsfeedCategories();
          await addNeedFeedViewModel.editFeedObject(widget.newsfeeds);
          navigationService.navigateTo(RouteList.addNewsFeed);
        } else if (value == 'delete') {
          showAlertMessage(
              context, 'Are you really want to delete this NewsFeed ?',
              onBack: () {
            newsFeedViewModel.deleteTheNewsFeed(
                context, widget.newsfeeds?.id ?? '');
            navigationService.goBack();
          });
        } else if (value == 'report') {
          showAdminReportBottomSheet(context, () async {
            navigationService.goBack();
            await newsFeedViewModel.BlockReportHidePostUser(
                context, widget.newsfeeds?.id ?? '', "REPORT");
            scaffoldMessenger("Post Reported Successfully");
          }, newsFeedViewModel.reportText);
        } else if (value == 'hide') {
          showUserBlockPopup(context, 'Are you sure Hide this user?',
              confirmAction: () {
            navigationService.goBack();
            newsFeedViewModel.BlockReportHidePostUser(
                context, widget.newsfeeds?.id ?? '', "HIDE");
          });
        } else if (value == 'block') {
          showUserBlockPopup(context, 'Are you sure Block this profile?',
              confirmAction: () {
            navigationService.goBack();
            newsFeedViewModel.BlockReportHidePostUser(
                context, widget.newsfeeds?.id ?? 'BLOCK', '',
                entityId: widget.newsfeeds?.userId ?? '');
          });
        } else if (value == 'Save Media') {
          final mediaList = widget.newsfeeds?.postImage ?? [];

          downloadAllFiles(context, mediaList);
        } else if (value == 'publish' ||
            value == 'unpublish' ||
            value == 'approve') {
          newsFeedViewModel.publishUnPublishNewsFeeds(
              context,
              widget.newsfeeds?.id ?? '',
              newsFeedViewModel.listingStatus ==
                      AdminNewsFeedStatus.published.value
                  ? AdminNewsFeedStatus.unPublished.value
                  : AdminNewsFeedStatus.published.value);
        } else if (value == 'reject') {
          newsFeedViewModel.publishUnPublishNewsFeeds(
              context,
              widget.newsfeeds?.id ?? '',
              AdminNewsFeedStatus.unPublished.value);
        }
      },
      itemBuilder: (context) => [
        if (newsFeedViewModel.userType == UserRole.admin.value &&
            newsFeedViewModel.selectedStatus ==
                AdminNewsFeedStatus.pendingStatus.value)
          PopupMenuItem(
              value: "approve",
              child: buildRow(
                  Icons.arrow_circle_right, AppColors.greenColor, "Approve")),
        if (newsFeedViewModel.userType == UserRole.admin.value &&
            newsFeedViewModel.selectedStatus ==
                AdminNewsFeedStatus.pendingStatus.value)
          PopupMenuItem(
              value: "reject",
              child: buildRow(Icons.delete, AppColors.redColor, "Reject")),
        if (newsFeedViewModel.userType == UserRole.admin.value &&
            newsFeedViewModel.selectedStatus ==
                AdminNewsFeedStatus.unpublishedStatus.value)
          PopupMenuItem(
              value: "publish",
              child:
                  buildRow(Icons.arrow_upward, AppColors.blueColor, "Publish")),
        if (newsFeedViewModel.userType == UserRole.admin.value &&
            newsFeedViewModel.selectedStatus ==
                AdminNewsFeedStatus.publishedStatus.value)
          PopupMenuItem(
              value: "unpublish",
              child: buildRow(
                  Icons.unpublished, AppColors.quizWrongBg, "Unpublish")),
        if (newsFeedViewModel.userType == UserRole.admin.value &&
            newsFeedViewModel.selectedStatus ==
                AdminNewsFeedStatus.publishedStatus.value)
          PopupMenuItem(
              value: "delete",
              child: buildRow(Icons.delete, AppColors.redColor, "Delete")),
        if (isSameUser) ...[
          PopupMenuItem(
              value: "edit",
              child: buildRow(Icons.edit, AppColors.blueColor, "Edit")),
          /*PopupMenuItem(
              value: "delete",
              child: buildRow(Icons.delete, AppColors.redColor, "Delete"))*/
        ],
        if (!isSameUser) ...[
          PopupMenuItem(
              value: "hide",
              child:
                  buildRow(Icons.hide_source, AppColors.redColor, "Hide Post")),
          PopupMenuItem(
              value: "report",
              child: buildRow(
                  Icons.report, AppColors.primaryColor, "Report Post")),
          PopupMenuItem(
              value: "block",
              child: buildRow(Icons.block, AppColors.redColor, "Block Profile"))
        ],
        if (widget.newsfeeds?.postImage != null &&
            widget.newsfeeds?.postImage?.isNotEmpty == true &&
            !isSameUser &&
            newsFeedViewModel.userType != UserRole.admin.value)
          PopupMenuItem(
              value: "Save Media",
              child: buildRow(Icons.save, AppColors.greenColor, "Save Media"))
      ],
    );
  }
}

Widget buildRow(IconData? icon, Color? color, String? title) {
  return Row(children: [
    Icon(icon, color: color),
    SizedBox(width: 8),
    Text(title ?? '', style: TextStyles.semiBold(fontSize: 14, color: color))
  ]);
}
