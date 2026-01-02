import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/campaign/view_model/campaign_view_model.dart';
import 'package:di360_flutter/feature/campaign/widgets/campaign_card.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/view_model/filter_view_model.dart';
import 'package:di360_flutter/feature/my_learning_hub/widgets/filter_section_widget.dart';
import 'package:di360_flutter/feature/news_feed/view/notifaction_panel.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CampaignListingView extends StatefulWidget {
  const CampaignListingView({super.key});

  @override
  State<CampaignListingView> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<CampaignListingView>
    with BaseContextHelpers {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final viewModel = Provider.of<CampaignViewModel>(context, listen: false);
    Loaders.circularShowLoader(context);
    await viewModel.getCampaignListing();
    Loaders.circularHideLoader(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CampaignViewModel>(context);
    final courseListingVM = Provider.of<CourseListingViewModel>(context);
    final filterVM = Provider.of<FilterViewModel>(context);
     var floatingActionButton = FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
       
        navigationService.navigateTo(RouteList.createCampaignView);
       
      },
      child: SvgPicture.asset(ImageConst.addFeed),
    );

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        endDrawer: NotificationsPanel(),
        appBar: AppBarWidget(
            title: 'Campaign management',
            filterWidget: GestureDetector(
                onTap: () {
                  filterVM.fetchCourseCategory(context);
                  filterVM.fetchCourseType(context);

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => FilterBottomSheet(
                      onApply: () {
                        /*myLearningHubVM.getCoursesWithFilters(
                            context,
                            filterVM.selectedOptions['Filter by Type'],
                            filterVM.selectedOptions['Category'], filterVM.selectedDate.toString());
                        navigationService.goBack();*/
                      },
                      onClear: () {
                        /*filterVM.clearAll();
                         myLearningHubVM.getCoursesWithFilters(
                            context,
                            filterVM.selectedOptions['Filter by Type'],
                            filterVM.selectedOptions['Category'], filterVM.selectedDate.toString());*/
                      },
                    ),
                  );
                },
                child: SvgPicture.asset(ImageConst.filter,
                    color: AppColors.black))),
         
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
          child: Column(
            children: [
              /*if (viewModel.searchBarOpen)
                SearchWidget(
                  controller: viewModel.searchController,
                  hintText: "Search Course...",
                  onClear: () {
                   /* myLearningHubVM.searchController.clear();
                    myLearningHubVM.getCoursesWithMyRegistrations(context);*/
                  },
                  onSearch: () {
                   /* myLearningHubVM.getCoursesWithMyRegistrations(context);*/
                  },
                ),*/
              Expanded(
                child: viewModel.campaignListData?.smsCampaign?.isEmpty ?? false
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No Data.",
                              style: TextStyles.medium2(color: AppColors.black),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            viewModel.campaignListData?.smsCampaign?.length,
                        itemBuilder: (context, index) {
                          final campaignData =
                              viewModel.campaignListData?.smsCampaign?[index];
                          return CampaignCard(
                            id: campaignData?.id??"" ,
                            campaignName: campaignData?.campaignName??"",
                            date: campaignData?.scheduleDate??"",
                            type: campaignData?.messageChannel??"",
                            status: campaignData?.status??"",
                            repeat: campaignData?.isRepeating??"",
                            time: campaignData?.scheduleTimeLocal??"", createdBy: '',
                            onMenuAction: (action,id){
                              switch (action) {
                                case 'Delete':
                                  viewModel.deleteCampaign(context,id);
                                  break;
                                default:
                                  break;
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: floatingActionButton);
  }
}
