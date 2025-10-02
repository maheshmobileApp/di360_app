import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_catalogues/add_catalogue_view_model/add_catalogu_view_model.dart';
import 'package:di360_flutter/feature/add_catalogues/view/catalogue_card_widget.dart';
import 'package:di360_flutter/feature/news_feed/notification_view_model/notification_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MyCataloguesScreen extends StatefulWidget {
  const MyCataloguesScreen({super.key});

  @override
  State<MyCataloguesScreen> createState() => _MyCataloguesScreenState();
}

class _MyCataloguesScreenState extends State<MyCataloguesScreen>
    with BaseContextHelpers {

      @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((s) {
      final catalogVM = context.read<AddCatalogueViewModel>();
      catalogVM.getMyCataloguesData(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final notificationVM = Provider.of<NotificationViewModel>(context);
    final myCatalogVM = Provider.of<AddCatalogueViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            title: Stack(
              clipBehavior: Clip.none,
              children: [
                Text(
                  'Dental Interface',
                  style: TextStyles.bold4(color: AppColors.black),
                ),
                Positioned(
                  top: -9,
                  right: -18,
                  child: SvgPicture.asset(
                    ImageConst.logo,
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
            actions: [
              Builder(
                builder: (context) => GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SvgPicture.asset(ImageConst.notification,
                            color: AppColors.black),
                        if (notificationVM.notificationCount != 0)
                          Positioned(
                              top: -16,
                              right: -13,
                              child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: AppColors.primaryColor,
                                  child: Text(
                                      '${notificationVM.notificationCount}',
                                      style: TextStyles.medium1(
                                          color: AppColors.whiteColor))))
                      ],
                    )),
              ),
              addHorizontal(15),
              SvgPicture.asset(ImageConst.search, color: AppColors.black),
              addHorizontal(15),
              GestureDetector(
                  onTap: () {
                    myCatalogVM.initializeFilterOptions();
                    navigationService.navigateTo(RouteList.myCatalogueFilter);
                  },
                  child: SvgPicture.asset(ImageConst.filter,
                      color: AppColors.black)),
              if (myCatalogVM.catalogFilterApply == true)
                GestureDetector(
                  onTap: () => myCatalogVM.clearSelections(),
                  child: Icon(Icons.close, color: AppColors.black),
                ),
              addHorizontal(15)
            ]),
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: myCatalogVM.statuses.length,
                itemBuilder: (context, index) {
                  String status = myCatalogVM.statuses[index];
                  bool isSelected = myCatalogVM.selectedStatus == status;
                  return GestureDetector(
                    onTap: () {
                      myCatalogVM.changeStatus(status, context);
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
                              "${myCatalogVM.statusCountMap[status]}",
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
              child: myCatalogVM.myCatalogueList?.isEmpty ?? false
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageConst.noCatalogue),
                          addVertical(10),
                          Text(
                            "No Catalogues",
                            style: TextStyles.medium2(color: AppColors.black),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: myCatalogVM.myCatalogueList?.length,
                      itemBuilder: (context, index) {
                        return CatalogueCard(
                            item: myCatalogVM.myCatalogueList?[index]);
                      },
                    ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            myCatalogVM.clearAddCatalogueData();
            navigationService.navigateTo(RouteList.addCatalogScreen);
          },
          child: SvgPicture.asset(ImageConst.addFeed),
        ));
  }
}
