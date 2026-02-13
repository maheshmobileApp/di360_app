import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/banners/view_model/banners_view_model.dart';
import 'package:di360_flutter/feature/banners/widgets/banners_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BannersListScreen extends StatefulWidget {
  const BannersListScreen({super.key});

  @override
  State<BannersListScreen> createState() => _BannersListScreenState();
}

class _BannersListScreenState extends State<BannersListScreen>
    with BaseContextHelpers {
  @override
  Widget build(BuildContext context) {
    final bannersVM = Provider.of<BannersViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBarWidget(),
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bannersVM.statuses.length,
                itemBuilder: (context, index) {
                  String status = bannersVM.statuses[index];
                  bool isSelected = bannersVM.selectedStatus == status;
                  return GestureDetector(
                    onTap: () {
                      bannersVM.changeStatus(status, context);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: AppColors.primaryColor)),
                      child: Row(
                        children: [
                          Text(status,
                              style: TextStyles.regular2(
                                  color: isSelected
                                      ? AppColors.whiteColor
                                      : AppColors.black)),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${bannersVM.statusCountMap[status]}",
                              style: TextStyles.regular2(
                                  color: isSelected
                                      ? AppColors.black
                                      : AppColors.whiteColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Expanded(
              child: bannersVM.bannersList.isNotEmpty == false
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SvgPicture.asset(ImageConst.noCatalogue),
                          addVertical(10),
                          Text(
                            "No Banners",
                            style: TextStyles.medium2(color: AppColors.black),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: bannersVM.bannersList.length,
                      itemBuilder: (context, index) {
                        return BannersCard(
                          item: bannersVM.bannersList[index],
                        );
                      },
                    ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () async {
            bannersVM.clearAddBannerData();
            await navigationService.navigateTo(RouteList.addBanners);
            _loadData();
          },
          child: SvgPicture.asset(ImageConst.addFeed),
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
    // _loadData();
  }

  Future<void> _loadData() async {
    Loaders.circularShowLoader(context);
    await context.read<BannersViewModel>().getBannerData(context);
    if (mounted) {
      Loaders.circularHideLoader(context);
    }
  }
}
