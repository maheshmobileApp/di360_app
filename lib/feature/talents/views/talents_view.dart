import 'package:di360_flutter/common/banner/generic_list_view_with_banners.dart';
import 'package:di360_flutter/common/banner/list_banner.dart';
import 'package:di360_flutter/common/banner/utils.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/feature/talents/views/talents_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TalentsView extends StatelessWidget {
  const TalentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final talentViewModel = Provider.of<TalentsViewModel>(context);
    return (talentViewModel.talentList.isEmpty)
        ? Center(
            child: const Text("No Jobs Available"),
          )
        :  GenericListViewWithBanners(
    items: talentViewModel.talentList,
    itemBuilder: (BuildContext context, int index) {
      final talentData = talentViewModel.talentList[index];
      return InkWell(
          onTap: () {
            navigationService.navigateToWithParams(
                RouteList.talentdetailsScreen,
                params: talentViewModel.talentList[index]);
          },
          child: TalentsCard(
            talentList: talentData
          ));
    },
    bannerIndices:
        BannerUtils.calculateBannerIndices(talentViewModel.talentList.length),
    bannerBuilder: (BuildContext context, int bannerPosition) {
      return ListBanner();
    },
        );
}
}
