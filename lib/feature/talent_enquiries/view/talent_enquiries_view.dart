import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/talent_enquiries/view_model/talent_enquiry_view_model.dart';
import 'package:di360_flutter/feature/talent_enquiries/widgets/talent_enquiry_card.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TalentEnquiriesView extends StatefulWidget {
  const TalentEnquiriesView({super.key});

  @override
  State<TalentEnquiriesView> createState() => _TalentListingScreenState();
}

class _TalentListingScreenState extends State<TalentEnquiriesView>
    with BaseContextHelpers {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<TalentEnquiryViewModel>(context, listen: false);
      vm.getCoursesListingData();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final vm = Provider.of<TalentEnquiryViewModel>(context, listen: false);
      vm.getCoursesListingData(loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TalentEnquiryViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBarWidget(searchWidget: false,
          ),
      body: Column(
        children: [
          Expanded(
            child: vm.talentEnquiryData?.talentEnquiries == null ||
                    vm.talentEnquiryData?.talentEnquiries?.isEmpty == true
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Enquiries Found",
                          style: TextStyles.medium2(color: AppColors.black),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: vm.talentEnquiryData!.talentEnquiries!.length + (vm.isLoadingMoreEnquiries ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == vm.talentEnquiryData!.talentEnquiries!.length) {
                        return Center(child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(color: AppColors.primaryColor),
                        ));
                      }
                      final jobData = vm.talentEnquiryData?.talentEnquiries?[index];
                      try {
                        return TalentEnquiryCard(
                          jobProfiles: jobData,
                          vm: vm,
                          index: index,
                        );
                      } catch (e, st) {
                        debugPrint("🔥 Error in card #$index: $e\n$st");
                        return const Text("Error rendering card");
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
