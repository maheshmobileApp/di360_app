import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/home/model_class/get_all_news_feeds.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/feature/news_feed/news_feed_view_model/news_feed_view_model.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildJobTypeWidget extends StatelessWidget {
  final Jobs? job;
  final Newsfeeds? newsfeeds;
  const BuildJobTypeWidget({super.key, this.job,this.newsfeeds});

  @override
  Widget build(BuildContext context) {
    final newsFeedProvider = Provider.of<NewsFeedViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start, children: [
      if (job?.bannerImage != null && job?.bannerImage?.url != null)
        CachedNetworkImageWidget(imageUrl: job?.bannerImage?.url ?? ''),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Title',
                style: TextStyles.medium3(color: AppColors.HINT_COLOR)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(newsfeeds?.title ?? '',
                  style: TextStyles.medium4(color: AppColors.black)),
            ),
            SizedBox(height: 8),
            Text('Role',
                style: TextStyles.medium3(color: AppColors.HINT_COLOR)),
            Text(job?.jRole ?? '',
                style: TextStyles.medium4(color: AppColors.black)),
          ]),
          AppButton(
              text: 'View',
              height: 40,
              width: 80,
              onTap: () async {
                newsFeedProvider.getJobDetailsByIds(context, job?.id ?? '');
              })
        ]),
      ),
      Divider(),
      Padding(
       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Text('Job description',
                  style: TextStyles.medium3(color: AppColors.HINT_COLOR)),
      ),
    ]);
  }
}
