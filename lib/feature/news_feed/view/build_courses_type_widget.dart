import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/expanded_html_widget.dart';
import 'package:di360_flutter/widgets/jiffy_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildCoursesTypeWidget extends StatelessWidget {
  final Courses? courses;
  final Newsfeeds? newsfeeds;
  final int index;
  const BuildCoursesTypeWidget(
      {super.key, this.courses, this.newsfeeds, required this.index});

  @override
  Widget build(BuildContext context) {
    final newsFeedProvider = Provider.of<NewsFeedViewModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (courses?.presenters?.first.presentedByImage != null &&
                courses?.presenters?.first.presentedByImage?.url != null)
              CachedNetworkImageWidget(
                  imageUrl:
                      courses?.presenters?.first.presentedByImage?.url ?? ''),
                      SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Presented By',
                              style: TextStyles.medium3(
                                  color: AppColors.HINT_COLOR)),
                          Text(courses?.presenters?.first.presentedByName ?? '',
                              maxLines: 2,
                              style:
                                  TextStyles.medium4(color: AppColors.black)),
                          SizedBox(height: 8),
                          Text('CPD HOURS',
                              style: TextStyles.medium3(
                                  color: AppColors.HINT_COLOR)),
                          Text('${courses?.cpdPoints ?? 0}',
                              style:
                                  TextStyles.medium4(color: AppColors.black)),
                        ]),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.blueColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                          'Posted On: ${jiffyDataWidget(newsfeeds?.createdAt, format: 'yyyy-MM-dd')}'),
                    ),
                  )
                ]),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Course Description',
                    style: TextStyles.medium3(color: AppColors.HINT_COLOR)),
                SizedBox(height: 10),
                ExpandableHtmlText(
                  htmlData: (newsfeeds?.description == null ||
                          newsfeeds?.description == '')
                      ? newsfeeds?.title ?? ''
                      : newsfeeds?.description ?? '',
                  index: index,
                  maxLines: 6,
                )
                // HtmlWidget(
                //   (newsfeeds?.description == null ||
                //           newsfeeds?.description == '')
                //       ? newsfeeds?.title ?? ''
                //       : newsfeeds?.description ?? '',
                //   textStyle: TextStyles.regular2(color: AppColors.black)
                // )
              ],
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.blueColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    courses?.type ?? '',
                    style: TextStyles.medium2(color: AppColors.blueColor),
                  ),
                ),
              ),
              AppButton(
                  text: 'View',
                  height: 40,
                  width: 80,
                  onTap: () async {
                    //  newsFeedProvider.getJobDetailsByIds(context, job?.id ?? '');
                  })
            ])
          ]),
    );
  }
}
