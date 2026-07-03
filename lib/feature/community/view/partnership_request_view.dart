import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/community/model/contacts_res.dart';
import 'package:di360_flutter/feature/community/model/get_partnership_members.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/feature/community/widgets/partnership_request_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartnershipRequestView extends StatefulWidget {
  @override
  State<PartnershipRequestView> createState() => _PartnershipRequestViewState();
}

class _PartnershipRequestViewState extends State<PartnershipRequestView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<CommunityViewModel>(context, listen: false);
      viewModel.changeStatus("All", context);
      viewModel.getPartnershipRequest();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final viewModel = Provider.of<CommunityViewModel>(context, listen: false);
      viewModel.getPartnershipRequest(loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommunityViewModel>(context);
    final partnershipRequests =
        viewModel.partnershipMembers?.partnershipMembers;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(
        logo: false,
        title: "Partnership Requests",
        searchWidget: false,
      ),
      body: Column(
        children: [
          statusWidget(viewModel),
          (partnershipRequests?.length != 0 && partnershipRequests != null)
              ? Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(10),
                    itemCount: partnershipRequests.length +
                        (viewModel.isLoadingMorePartnership ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == partnershipRequests.length) {
                        return Center(
                            child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ));
                      }
                      return PartnershipRequestCard(
                          contactName:
                              partnershipRequests[index].contactName ?? "",
                          firstName:
                              partnershipRequests[index].companyName ?? "",
                          email: partnershipRequests[index].email ?? "",
                          phone: partnershipRequests[index].phone ?? "",
                          state: partnershipRequests[index].state ?? "",
                          status: partnershipRequests[index].status ?? "",
                          onMenuAction: (action) async {
                            switch (action) {
                              case "Approve":
                                await viewModel.approvePartnershipRequest(
                                    partnershipRequests[index].id ?? "",
                                    "APPROVED",
                                    context);
                                showPartnerApprovedDialog(context, viewModel,
                                    partnershipRequests[index]);

                                break;
                              case "Reject":
                                await viewModel.approvePartnershipRequest(
                                    partnershipRequests[index].id ?? "",
                                    "REJECTED",
                                    context);

                                break;
                            }
                          });
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

  void showPartnerApprovedDialog(BuildContext context,
      CommunityViewModel viewModel, PartnershipMembers data) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 24,
                  ),
                  decoration: const BoxDecoration(
                    color: const Color(0xFFF3F5F7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  
                  child: const Text(
                    "Partner Approved",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6D00),
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Partner has been approved successfully.",
                        style: TextStyles.bold4(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Would you like to add this partner to your contact book?",
                        style: TextStyles.medium3(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                // Buttons
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          viewModel.setContactDetailsFromPartners(data);
                          navigationService
                              .replaceWith(RouteList.createContactView);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8C1A),
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          "Add",
                          style: TextStyles.bold4(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {
                          navigationService.goBack();
                        },
                        child: Text(
                          "Skip",
                          style: TextStyles.bold4(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  SizedBox statusWidget(CommunityViewModel communityVM) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: communityVM.statuses.length,
        itemBuilder: (context, index) {
          String status = communityVM.statuses[index];
          bool isSelected = communityVM.selectedStatus == status;
          return GestureDetector(
            onTap: () {
              communityVM.changeStatus(status, context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.primaryColor : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Row(
                children: [
                  Text(
                    status,
                    style: TextStyles.regular2(
                      color:
                          isSelected ? AppColors.whiteColor : AppColors.black,
                    ),
                  ),
                  SizedBox(width: 6),
                  /*Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "",
                      style: TextStyles.regular2(
                        color:
                            isSelected ? AppColors.black : AppColors.whiteColor,
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
