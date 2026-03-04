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

class BuildJobTypeWidget extends StatelessWidget {
  final Jobs? job;
  final Newsfeeds? newsfeeds;
  final int index;
  const BuildJobTypeWidget({super.key, this.job, this.newsfeeds,required this.index});

  @override
  Widget build(BuildContext context) {
    final newsFeedProvider = Provider.of<NewsFeedViewModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (job?.bannerImage != null && job?.bannerImage?.url != null)
              CachedNetworkImageWidget(imageUrl: job?.bannerImage?.url ?? ''),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title',
                              style: TextStyles.medium3(
                                  color: AppColors.HINT_COLOR)),
                          Text(newsfeeds?.title ?? '',
                              maxLines: 2,
                              style:
                                  TextStyles.medium4(color: AppColors.black)),
                          SizedBox(height: 8),
                          Text('Role',
                              style: TextStyles.medium3(
                                  color: AppColors.HINT_COLOR)),
                          Text(job?.jRole ?? '',
                              style:
                                  TextStyles.medium4(color: AppColors.black)),
                        ]),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.blueColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
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
                Text('Job description',
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
              Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: job?.typeofEmployment
                          ?.map((e) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.blueColor.withOpacity(0.1)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                child: Text(e,
                                    style: TextStyles.regular2(
                                        color: AppColors.blueColor)),
                              )))
                          .toList() ??
                      []),
              AppButton(
                  text: 'View',
                  height: 40,
                  width: 80,
                  onTap: () async {
                    newsFeedProvider.getJobDetailsByIds(context, job?.id ?? '');
                  })
            ])
          ]),
    );
  }
}
