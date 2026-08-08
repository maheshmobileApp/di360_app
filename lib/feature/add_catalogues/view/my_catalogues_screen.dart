import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_catalogues/add_catalogue_view_model/add_catalogu_view_model.dart';
import 'package:di360_flutter/feature/add_catalogues/view/catalogue_card_widget.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((s) {
      final catalogVM = context.read<AddCatalogueViewModel>();
      catalogVM.getMyCataloguesData(context);
      catalogVM.setCommunityStatus();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context
            .read<AddCatalogueViewModel>()
            .getMyCataloguesData(context, isPagination: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myCatalogVM = Provider.of<AddCatalogueViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBarWidget(
            title: "My Catalogues",
            logo: false,
            filterWidget: Row(children: [
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
                )
            ])),
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: myCatalogVM.userType == UserRole.admin.value
                    ? myCatalogVM.adminStatuses.length
                    : myCatalogVM.statuses.length,
                itemBuilder: (context, index) {
                  String status = myCatalogVM.userType == UserRole.admin.value
                      ? myCatalogVM.adminStatuses[index]
                      : myCatalogVM.statuses[index];
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
                      child: Row(children: [
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
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                              "${myCatalogVM.userType == UserRole.admin.value ? myCatalogVM.statusCountMap[status] : myCatalogVM.statusCountMap[status]}",
                              style: TextStyles.regular2(
                                  color: isSelected
                                      ? AppColors.black
                                      : AppColors.whiteColor)),
                        )
                      ]),
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
                      controller: _scrollController,
                      itemCount: (myCatalogVM.myCatalogueList?.length ?? 0) +
                          (myCatalogVM.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == myCatalogVM.myCatalogueList?.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return CatalogueCard(
                            item: myCatalogVM.myCatalogueList?[index]);
                      },
                    ),
            )
          ],
        ),
        /*floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            myCatalogVM.clearAddCatalogueData();
            navigationService.navigateTo(RouteList.addCatalogScreen);
          },
          child: SvgPicture.asset(ImageConst.addFeed),
        )*/);
  }
}
