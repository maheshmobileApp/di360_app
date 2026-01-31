import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/campaign/model/get_campaign_list_res.dart';
import 'package:di360_flutter/feature/campaign/view_model/campaign_view_model.dart';
import 'package:di360_flutter/feature/campaign/widgets/campaign_card.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/search_widget.dart';
import 'package:di360_flutter/feature/news_feed/view/notifaction_panel.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:di360_flutter/widgets/top_right_filter_dialog.dart';
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
    var floatingActionButton = FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        viewModel.setRepeatMode(false);
        viewModel.clearFields();
        navigationService.navigateTo(RouteList.createCampaignView);
      },
      child: SvgPicture.asset(ImageConst.addFeed),
    );

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        endDrawer: NotificationsPanel(),
        appBar: AppBarWidget(
            title: 'Campaign management',
            searchAction: (){
               viewModel.toggleSearchBar();
            },
            filterWidget: GestureDetector(
                onTap: () {
                  _openFilterDialog(context, viewModel);
                },
                child: SvgPicture.asset(ImageConst.filter,
                    color: AppColors.black))),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            children: [
              if (viewModel.searchBarOpen)
                SearchWidget(
                  controller: viewModel.searchController,
                  hintText: "Search Campaign...",
                  searchButton: false,
                  onChanged: (value) {
                    viewModel.notifyListeners();
                  },
                  onClear: () {
                    viewModel.notifyListeners();
                  },
                ),
              Expanded(
                child: viewModel.filteredCampaigns.isEmpty
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
                        itemCount: viewModel.filteredCampaigns.length,
                        itemBuilder: (context, index) {
                          final campaignData = viewModel.filteredCampaigns[index];
                          return CampaignCard(
                            id: campaignData?.id ?? "",
                            campaignName: campaignData?.campaignName ?? "",
                            date: campaignData?.scheduleDate ?? "",
                            type: campaignData?.messageChannel ?? "",
                            status: campaignData?.status ?? "",
                            repeat: campaignData?.isRepeating ?? "",
                            time: campaignData?.scheduleTimeLocal ?? "",
                            createdBy: '',
                            onMenuAction: (action, id) async {
                              switch (action) {
                                case 'Delete':
                                  showAlertMessage(context,
                                      'Are you sure you want to remove this Campaign?',
                                      onBack: () {
                                    navigationService.goBack();
                                    viewModel.deleteCampaign(context, id);
                                  });

                                  break;
                                case 'Preview':
                                  _showPreviewDialog(context, campaignData);
                                  break;
                                case 'View Details':
                                  _showPreviewDialog(context, campaignData);
                                  break;
                                case 'Repeat':
                                  viewModel.setRepeatMode(true);
                                  await viewModel.getCampaignDetails(id);

                                  navigationService
                                      .navigateTo(RouteList.createCampaignView);
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

  bool _isHtmlContent(String text) {
    return text.contains('<html>') ||
        text.contains('<!DOCTYPE') ||
        text.contains('<body>');
  }

  void _showPreviewDialog(BuildContext context, SmsCampaign? data) {
    final messageText = (data?.messageText ?? "").trim();
    final isHtml = _isHtmlContent(messageText);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: AppColors.whiteColor,
          title: Text(
            data?.messageChannel == "SMS" ? "SMS Preview" : "Email Preview",
            style: TextStyles.bold3(color: AppColors.black),
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
              maxWidth: double.maxFinite,
            ),
            child: isHtml
                ? SingleChildScrollView(
                    child: HtmlWidget(
                      messageText,
                      textStyle: TextStyles.medium1(color: AppColors.black),
                      customStylesBuilder: (element) {
                        if (element.localName == 'body') {
                          return {'background-color': 'transparent'};
                        }
                        return null;
                      },
                    ),
                  )
                : SingleChildScrollView(
                    child: Text(
                      messageText,
                      style: TextStyles.regular3(color: AppColors.black),
                    ),
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style:
                    TextStyles.semiBold(color: AppColors.black, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  void _openFilterDialog(BuildContext context, CampaignViewModel viewModel) {
    TopRightFilterDialog.show(
      context,
      title: 'Filter Campaigns',
      filterOptions: [
        FilterOption(
          title: 'SMS',
          onChanged: (val) {
            viewModel.setSmsFilterStatus(val);
          },
        ),
        FilterOption(
          title: 'Email',
          onChanged: (val) {
            viewModel.setEmailFilterStatus(val);
          },
        ),
        FilterOption(
          title: 'HTML',
          onChanged: (val) {
            viewModel.setHtmlFilterStatus(val);
          },
        ),
        FilterOption(
          title: 'Email with PDF',
          onChanged: (val) {
            viewModel.setEmailWithPdfFilterStatus(val);
          },
        ),
      ],
      clearAll: () {
        viewModel.clearAllFilters();
      },
      onClose: () {
        Navigator.of(context).pop();
      },
      
    );
  }
}
