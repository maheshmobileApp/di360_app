import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityMarketView extends StatefulWidget {
  @override
  _CreateCategoryViewState createState() => _CreateCategoryViewState();
}

class _CreateCategoryViewState extends State<CommunityMarketView>
    with ValidationMixins {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommunityViewModel>(context);
    final newsCommunityVM = Provider.of<NewsFeedCommunityViewModel>(context);
    final list =
        viewModel.getJoinedCommunityMembersData?.communityMembers ?? [];
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        title: "Community",
        searchWidget: false,
      ),
      body: Column(
        children: [
          (list.length != 0)
              ? Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () async {
                            newsCommunityVM.listingStatus = "PUBLISHED";
                            newsCommunityVM.setProfCommunityId(
                                list[index].communityId ?? "");
                            navigationService
                                .navigateTo(RouteList.newsFeedCommunityView);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Row(
                              children: [
                                CircleAvatar(
                                    backgroundColor: AppColors.primaryColor,
                                    radius: 20,
                                    child: Icon(
                                      Icons.group,
                                      color: AppColors.whiteColor,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  list[index].communityName ?? "",
                                  style: TextStyles.medium3(
                                      color: AppColors.black),
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Text(
                      "No Partnership Requests",
                      style: TextStyles.medium3(
                          color: AppColors.black, fontSize: 16),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
