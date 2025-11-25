import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/community/widgets/news_feed_category_card.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/feature/news_feed_community/widgets/news_feed_community_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NewsFeedCommunityView extends StatefulWidget {
  @override
  _NewsFeedCategoriesViewState createState() => _NewsFeedCategoriesViewState();
}

class _NewsFeedCategoriesViewState extends State<NewsFeedCommunityView>
    with ValidationMixins {
  String selectedFilter = 'all';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel =
          Provider.of<NewsFeedCommunityViewModel>(context, listen: false);
      viewModel.getAllNewsFeeds();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsFeedCommunityViewModel>(context);
    final joinRequests = viewModel.newsFeedCommunityData?.newsfeeds;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        title: "Community",
        searchWidget: true,
        filterWidget: PopupMenuButton<String>(
          icon: SvgPicture.asset(ImageConst.filter, color: AppColors.black),
          onSelected: (String value) {
            // Handle filter selection
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              value: 'all',
              child: Text('All Posts'),
            ),
            PopupMenuItem<String>(
              value: 'recent',
              child: Text('Recent Posts'),
            ),
            PopupMenuItem<String>(
              value: 'popular',
              child: Text('Popular Posts'),
            ),
            PopupMenuItem<String>(
              value: 'my_posts',
              child: Text('My Posts'),
            ),
          ],
        )
      ),
      body: Column(
        children: [
          (joinRequests?.length != 0 && joinRequests != null)
              ? Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: joinRequests.length,
                    itemBuilder: (context, index) {
                      final newsItem = joinRequests[index];
                      return NewsFeedCommunityCard(
                        createdAt: newsItem.createdAt ?? "",
                        id: newsItem.id ?? '',
                        logoUrl:
                            newsItem.dentalProfessional?.profileImage?.url ??
                                '',
                        companyName: newsItem.dentalProfessional?.name ?? '',
                        courseTitle: newsItem.description ?? '',
                        status: newsItem.status ?? '',
                        description: newsItem.description ?? '',
                        types: [],
                        registeredCount: 0,
                        chipTitle: newsItem.categoryType ?? '',
                        comments: newsItem.newsFeedsComments?.length??0,
                        likes: newsItem.newsfeedsLikes?.length ?? 0,
                        onCommentTap: () {},
                        onLikeTap: () {},
                        onShareTap: () {},
                      );
                    },
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Text(
                      "No Join Requests",
                      style: TextStyles.medium3(
                          color: AppColors.black, fontSize: 16),
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: GestureDetector(
          onTap: () {
            navigationService.navigateTo(RouteList.createCategoryView);
          },
          child: SvgPicture.asset(ImageConst.createSupport)),
    );
  }
}
