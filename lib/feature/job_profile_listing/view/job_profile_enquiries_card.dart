import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listing_applicants_enquiry.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/feature/job_profile_listing/view/job_profile_enquiries_view.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/job_time_chip.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class JobProfileEnquiriesCard extends StatelessWidget with BaseContextHelpers {
  final TalentEnquiriesData jobsListingData;

  final int? index;
  const JobProfileEnquiriesCard({
    super.key,
    required this.jobsListingData,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(jobsListingData.createdAt ?? '');
    final String? profileImageUrl = jobsListingData.dentalSuppliers?.logo?.url ?? '';
    final vm = Provider.of<JobProfileListingViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color.fromRGBO(220, 224, 228, 1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _logoWithTitle(
                    jobsListingData.dentalSuppliers?.logo?.url ?? "",
                    jobsListingData.dentalSuppliers?.name ?? '',
                    jobsListingData.dentalSuppliers?.directories?.first.email ??
                        "",
                    jobsListingData.dentalSuppliers?.directories?.first.phone ??
                        "",
                  ),
                ),
                Row(
                  children: [
                    JobTimeChip(time: time),
                  ],
                ),
              ],
            ),
            addVertical(10),
            const Divider(),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    final profileId = jobsListingData.id;
                    final jobId = jobsListingData.id;
                    if (profileId == null || jobId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Talent or Job ID not available"),
                        ),
                      );
                      return;
                    }
                    final userId = await LocalStorage.getStringVal(
                        LocalStorageConst.userId);
                    navigationService.navigateToWithParams(
                      RouteList.JobListingApplicantsMessege,
                      params: {
                        "jobId": jobId,
                        "applicantId": profileId,
                        "userId": userId,
                      },
                    );
                  },
                  child: _roundedButton("Message"),
                ),
                addHorizontal(10),
                InkWell(
                    onTap: () async {
                      await vm.getJobProfileEnquiry(context,"","");
                      if (vm.jobPrilfeEnquiryData == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Applicant data not available")),
                        );
                        return;
                      }
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => JobProfileEnquiriesView(
                          applicant: vm.jobPrilfeEnquiryData,   
                          profileImageUrl: profileImageUrl,// safe now
                        ),
                      );
                    },
                    child: _roundedButton("Enquiry")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoWithTitle(
    String imageUrl,
    String name,
    String emial,
    String phonenumber,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.geryColor,
          radius: 24,
          child: CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.whiteColor,
            child: (imageUrl.isNotEmpty)
                ? ClipOval(
                    child: CachedNetworkImageWidget(
                      width: 48,
                      height: 48,
                      imageUrl: imageUrl,
                      errorWidget: const CircleAvatar(
                        backgroundColor: AppColors.geryColor,
                        child: Icon(Icons.error),
                      ),
                    ),
                  )
                : const CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.geryColor,
                  ),
          ),
        ),
        addHorizontal(6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style:
                    TextStyles.semiBold(fontSize: 16, color: AppColors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                emial,
                style: TextStyles.regular2(color: AppColors.geryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                phonenumber,
                style: TextStyles.regular1(color: AppColors.lightGeryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getShortTime(String? createdAt) {
    if (createdAt == null || createdAt.isEmpty) return '';
    try {
      return Jiffy.parse(createdAt).fromNow();
    } catch (_) {
      return '';
    }
  }

  Widget _roundedButton(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFFFF1E5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(label == "Message" ? Icons.chat : Icons.live_help_outlined,
              size: 20, color: AppColors.primaryColor),
          const SizedBox(width: 2),
          Text(label,
              style: TextStyles.medium1(
                  fontSize: 13, color: AppColors.primaryColor)),
        ]),
      );
}
