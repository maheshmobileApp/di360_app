import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_profile_listing/view/job_profile_enquiries_card.dart';
import 'package:di360_flutter/feature/job_profile_listing/view/job_profile_request_card.dart';
import 'package:di360_flutter/feature/talents/model/job_profile.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:flutter/material.dart';

class MyJobProfileScreen extends StatefulWidget {
  final JobProfiles jobsListingData;

  const MyJobProfileScreen({
    super.key,
    required this.jobsListingData,
  });

  @override
  State<MyJobProfileScreen> createState() => _MyJobProfileScreenState();
}

class _MyJobProfileScreenState extends State<MyJobProfileScreen>
    with BaseContextHelpers, SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final String? profileImageUrl =
        (widget.jobsListingData.profileImage.isNotEmpty)
            ? widget.jobsListingData.profileImage.first.url
            : null;

    final int requestCount = widget.jobsListingData.jobHirings.length;
    final int enquiryCount =
        widget.jobsListingData.talentEnquiries?.length ?? 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          menuWidget(),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.geryColor,
                      backgroundImage:
                          profileImageUrl != null && profileImageUrl.isNotEmpty
                              ? NetworkImage(profileImageUrl)
                              : null,
                      child:
                          (profileImageUrl == null || profileImageUrl.isEmpty)
                              ? const Icon(Icons.person,
                                  size: 40, color: AppColors.lightGeryColor)
                              : null,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(229, 244, 237, 1),
                          borderRadius: BorderRadius.circular(30),
                          border:
                              Border.all(color: AppColors.whiteColor, width: 1),
                        ),
                        child: Text(
                          widget.jobsListingData.adminStatus ?? '',
                          style: TextStyles.medium1(
                            color: AppColors.greenColor,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                addVertical(8),
                Text(widget.jobsListingData.fullName ?? "",
                    style: TextStyles.medium2(color: AppColors.black)),
                addVertical(4),
                Text(widget.jobsListingData.jobDesignation ?? "",
                    style: TextStyles.regular2(color: AppColors.black)),
                addVertical(8),
                _chipWidget(widget.jobsListingData.workType),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primaryColor,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.lightGeryColor,
            tabs: const [
              Tab(text: "Requests"),
              Tab(text: "Enquiries"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                requestCount == 0
                    ? Center(
                        child: Text(
                          "No Requests Found",
                          style: TextStyles.medium2(color: AppColors.black),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: requestCount,
                        itemBuilder: (context, index) {
                          return JobProfileRequestCard(
                            jobsListingData: widget.jobsListingData,
                            index: index,
                          );
                        },
                      ),
                enquiryCount == 0
                    ? Center(
                        child: Text(
                          "No Enquiries Found",
                          style: TextStyles.medium2(color: AppColors.black),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: enquiryCount,
                        itemBuilder: (context, index) {
                          return JobProfileEnquiriesCard(
                            jobsListingData: widget.jobsListingData,
                            index: index,
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chipWidget(List<String> types) {
    if (types.isEmpty) return const SizedBox();
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: types.map((type) {
        final label = type.trim().isEmpty ? '' : type;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.secondaryBlueColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            style: TextStyles.regular1(
              fontSize: 12,
              color: AppColors.primaryBlueColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }

  Widget menuWidget() {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      onSelected: (value) {
        if (value == "Delete") {
        } else if (value == "Active") {
        } else if (value == "Inactive") {
        } else if (value == "Preview") {}
      },
      itemBuilder: (context) {
        final items = <PopupMenuEntry<String>>[
          PopupMenuItem(
            value: "Preview",
            child: _buildRow(Icons.remove_red_eye, AppColors.black, "Preview"),
          ),
          PopupMenuItem(
            value: "Edit",
            child: _buildRow(Icons.edit_outlined, AppColors.blueColor, "Edit"),
          ),
          PopupMenuItem(
            value: "Delete",
            child:
                _buildRow(Icons.delete_outline, AppColors.redColor, "Delete"),
          ),
        ];

        return items;
      },
    );
  }

  Widget _buildRow(IconData icon, Color color, String title) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyles.semiBold(fontSize: 14, color: color),
        ),
      ],
    );
  }
}
