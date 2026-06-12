import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/add_news_feed_view_model.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/services/download_file.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
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
    final needFeedViewModel = Provider.of<NewsFeedViewModel>(context, listen:false);
    final addNeedFeedViewModel = Provider.of<AddNewsFeedViewModel>(context);
    final currentUserId = needFeedViewModel.userID;

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
            needFeedViewModel.deleteTheNewsFeed(context, widget.newsfeeds?.id ?? '');
            navigationService.goBack();
          });
        } else if (value == 'report') {
          showReportBottomSheet(context, () {
            navigationService.goBack();
            needFeedViewModel.reportNewsFeed(context, widget.newsfeeds?.id ?? '');
          });
        } else if (value == 'hide') {
          showUserBlockPopup(context, 'Are you sure Hide this user?',
              confirmAction: () {
            navigationService.goBack();
            needFeedViewModel.HideUser(context, widget.newsfeeds?.id ?? '',
                widget.newsfeeds?.feedType ?? '', widget.newsfeeds?.id ?? '');
          });
        } else if (value == 'block') {
          showUserBlockPopup(context, 'Are you sure Block this profile?',
              confirmAction: () {
            navigationService.goBack();
            needFeedViewModel.blockProfile(
                context,
                widget.newsfeeds?.dentalProfessional?.id ??
                    widget.newsfeeds?.dentalSupplier?.id ??
                    widget.newsfeeds?.dentalPractice?.id ??
                    '',
                widget.newsfeeds?.feedType ?? '',
                widget.newsfeeds?.id ?? '');
          });
        } else if (value == 'Save Media') {
          final mediaList = widget.newsfeeds?.postImage ?? [];

          downloadAllFiles(context, mediaList);
        }
      },
      itemBuilder: (context) => [
        if (isSameUser && widget.newsfeeds?.communityType == "BOTH") ...[
          PopupMenuItem(
              value: "edit",
              child: buildRow(Icons.edit, AppColors.blueColor, "Edit")),
          /*PopupMenuItem(
              value: "delete",
              child: buildRow(Icons.delete, AppColors.redColor, "Delete"))*/
        ],
        if (!isSameUser) ...[
          PopupMenuItem(
              value: "report",
              child: buildRow(
                  Icons.report, AppColors.primaryColor, "Report Post")),
          PopupMenuItem(
              value: "block",
              child:
                  buildRow(Icons.block, AppColors.redColor, "Block Profile")),
          PopupMenuItem(
              value: "hide",
              child:
                  buildRow(Icons.hide_source, AppColors.redColor, "Hide Post")),
        ],
        if (widget.newsfeeds?.postImage != null &&
            widget.newsfeeds?.postImage?.isNotEmpty == true &&
            !isSameUser)
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

void showReportBottomSheet(BuildContext context, Function()? sumbitedAction) {
  final _formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    showDragHandle: false,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Report',
                              style: TextStyles.bold5(
                                  color: AppColors.primaryColor)),
                          InkWell(
                              onTap: () => navigationService.goBack(),
                              child: Icon(Icons.close,
                                  color: AppColors.primaryColor))
                        ]),
                    SizedBox(height: 20),
                    InputTextField(
                      title: 'Report',
                      hintText: 'Enter report',
                      maxLines: 5,
                    ),
                    SizedBox(height: 40),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                            width: 150,
                            height: 45,
                            radius: 12,
                            text: 'Cancel',
                            onTap: () => navigationService.goBack(),
                          ),
                          AppButton(
                              width: 150,
                              height: 45,
                              radius: 12,
                              text: 'Submit',
                              onTap: sumbitedAction)
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
