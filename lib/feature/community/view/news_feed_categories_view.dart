import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/community/widgets/news_feed_category_card.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NewsFeedCategoriesView extends StatefulWidget {
  @override
  _NewsFeedCategoriesViewState createState() => _NewsFeedCategoriesViewState();
}

class _NewsFeedCategoriesViewState extends State<NewsFeedCategoriesView>
    with ValidationMixins {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      final viewModel = Provider.of<CommunityViewModel>(context, listen: false);
      final newsFeedVM = Provider.of<NewsFeedCommunityViewModel>(context, listen: false);

      await viewModel.getNewsFeedCategories(context);
      

      viewModel.getDirectory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommunityViewModel>(context);
    final joinRequests = viewModel.newsFeedCategoriesData?.newsfeedCategories;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        title: "News Feed Categories",
        searchWidget: false,
      ),
      body: Column(
        children: [
          (joinRequests?.length != 0 && joinRequests != null)
              ? Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: joinRequests.length,
                    itemBuilder: (context, index) {
                      return NewsFeedCategoryCard(
                          categoryName: joinRequests[index].categoryName ?? "",
                          createdAt: joinRequests[index].createdAt ?? "",
                          updatedAt: joinRequests[index].updatedAt ?? "",
                          onMenuAction: (action) async {
                            switch (action) {
                              case "Edit":
                                viewModel.updateEditMode(true);
                                viewModel.updateEditCategoryId(
                                  joinRequests[index].id ?? "",
                                );

                                viewModel.categoryController.text =
                                    joinRequests[index].categoryName ?? "";
                                navigationService
                                    .navigateTo(RouteList.createCategoryView);

                                break;
                              case "Delete":
                                showAlertMessage(context,
                                    'Are you sure you want to delete this Category?',
                                    onBack: () async {
                                  await viewModel.deleteCategory(context,
                                      joinRequests[index].id ?? "");
                                      navigationService.goBack();
                                });

                                break;
                            }
                          });
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
