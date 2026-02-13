import 'package:di360_flutter/common/banner/generic_list_view_with_banners.dart';
import 'package:di360_flutter/common/banner/list_banner.dart';
import 'package:di360_flutter/common/banner/utils.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/talents/view_model/talents_view_model.dart';
import 'package:di360_flutter/feature/talents/views/talents_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TalentsView extends StatefulWidget {
  const TalentsView({super.key});

  @override
  State<TalentsView> createState() => _TalentsViewState();
}

class _TalentsViewState extends State<TalentsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final talentViewModel =
          Provider.of<TalentsViewModel>(context, listen: false);
      talentViewModel.fetchTalentsForSelectedView(context, loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final talentViewModel = Provider.of<TalentsViewModel>(context);
    return RefreshIndicator(
      onRefresh: () async => await talentViewModel.refreshTalents(context),
      child: talentViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : talentViewModel.talentList.isEmpty
              ? const Center(child: Text("No Talents Available"))
              : GenericListViewWithBanners(
                  controller: _scrollController,
                  items: talentViewModel.talentList,
                  itemBuilder: (BuildContext context, int index) {
                    final talentData = talentViewModel.talentList[index];
                    return InkWell(
                        onTap: () {
                          navigationService.navigateToWithParams(
                              RouteList.talentdetailsScreen,
                              params: talentViewModel.talentList[index]);
                        },
                        child: TalentsCard(talentList: talentData));
                  },
                  bannerIndices: BannerUtils.calculateBannerIndices(
                      talentViewModel.talentList.length),
                  bannerBuilder: (BuildContext context, int bannerPosition) {
                    return ListBanner();
                  },
                  loadingWidget: talentViewModel.hasMoreTalents &&
                          talentViewModel.isLoadingMore
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : null,
                ),
    );
  }
}
