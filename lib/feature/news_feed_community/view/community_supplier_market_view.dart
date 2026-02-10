import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class CommunitySupplierMarketView extends StatefulWidget {
  @override
  _CreateCategoryViewState createState() => _CreateCategoryViewState();
}

class _CreateCategoryViewState extends State<CommunitySupplierMarketView>
    with ValidationMixins {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        title:  "Community",
        searchWidget: false,
      ),
      body: Column(
        children: [
          _titleWidget("Join Request", () {
            navigationService.navigateTo(RouteList.joinRequestView);
          }),
          _titleWidget("Partnership Request", () {
            navigationService.navigateTo(RouteList.partnershipRequestView);
          }),
          _titleWidget("Membership Registration", () {
            navigationService.navigateTo(RouteList.membershipRegistrationView);
          }),
          _titleWidget("Partnership Registration", () {
            navigationService.navigateTo(RouteList.partnershipRegistrationView);
          }),
          _titleWidget("News Feed Categories", () {
            navigationService.navigateTo(RouteList.newsFeedCategoriesView);
          }),
        ],
      ),
    );
  }

  Widget _titleWidget(String name, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: GestureDetector(
        onTap: onTap,
        child: Row(children: [
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
            name,
            style: TextStyles.medium3(color: AppColors.black),
          ),
        ]),
      ),
    );
  }
}
