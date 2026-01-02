import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/add_news_feed_view_model.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsMenuWidget extends StatelessWidget {
  final Newsfeeds? newsfeeds;
  const NewsMenuWidget({super.key, this.newsfeeds});

  @override
  Widget build(BuildContext context) {
    final needFeedViewModel = Provider.of<NewsFeedViewModel>(context);
    final addNeedFeedViewModel = Provider.of<AddNewsFeedViewModel>(context);
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.all(0),
      onSelected: (value) async {
        if (value == 'edit') {
          await addNeedFeedViewModel.fetchNewsfeedCategories();
          await addNeedFeedViewModel.editFeedObject(newsfeeds);
          navigationService.navigateTo(RouteList.addNewsFeed);
        } else if (value == 'delete') {
          showAlertMessage(
              context, 'Are you really want to delete this NewsFeed ?',
              onBack: () {
            needFeedViewModel.deleteTheNewsFeed(context, newsfeeds?.id ?? '');
            navigationService.goBack();
          });
        } else if (value == 'report') {
          showReportBottomSheet(context, () {
            navigationService.goBack();
            needFeedViewModel.reportNewsFeed(context, newsfeeds?.id ?? '');
          });
        } else if (value == 'block') {
          showUserBlockPopup(context, 'Are you sure Block this user',
              confirmAction: () {
            navigationService.goBack();
            needFeedViewModel.blockUser(
                context,
                newsfeeds?.dentalSupplier?.id ??
                    newsfeeds?.dentalPractice?.id ??
                    newsfeeds?.dentalProfessional?.id ??
                    '');
          });
        }
      },
      itemBuilder: (context) => [
        if (newsfeeds?.dentalAdminId == needFeedViewModel.userID ||
            newsfeeds?.dentalPracticeId == needFeedViewModel.userID ||
            newsfeeds?.dentalProfessionalId == needFeedViewModel.userID ||
            newsfeeds?.dentalSupplierId == needFeedViewModel.userID) ...[
          PopupMenuItem(
              value: "edit",
              child: buildRow(Icons.edit, AppColors.blueColor, "Edit")),
          PopupMenuItem(
              value: "delete",
              child: buildRow(Icons.delete, AppColors.redColor, "Delete"))
        ],
        if (newsfeeds?.dentalAdminId != needFeedViewModel.userID ||
            newsfeeds?.dentalPracticeId != needFeedViewModel.userID ||
            newsfeeds?.dentalProfessionalId != needFeedViewModel.userID ||
            newsfeeds?.dentalSupplierId != needFeedViewModel.userID) ...[
          PopupMenuItem(
              value: "report",
              child: buildRow(Icons.report, AppColors.primaryColor, "Report")),
          PopupMenuItem(
              value: "block",
              child: buildRow(Icons.block, AppColors.redColor, "Block"))
        ]
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                    InputTextField(title: 'Report', hintText: 'Enter report'),
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
                              text: 'Submited',
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
