import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_profile_listing/view/job_profile_enquiries_view.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/feature/talent_listing/model/get_hiring_talent_list_res.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/job_time_chip.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class JobProfileRequestCard extends StatelessWidget with BaseContextHelpers {
  final Jobhirings? jobsListingData;
  final dynamic parmas;
  final int index;
  final String? type;
  final String? professionalId;

  const JobProfileRequestCard({
    super.key,
    required this.jobsListingData,
    required this.index,
    this.type,
    this.professionalId,
    this.parmas,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<JobProfileListingViewModel>(context);

    final String time = _getShortTime(jobsListingData?.createdAt ?? '');
    final String? profileImageUrl =
        jobsListingData?.dentalSupplier?.logo != null &&
                jobsListingData?.dentalSupplier?.logo?.url != null &&
                jobsListingData?.dentalSupplier?.logo?.url != ""
            ? jobsListingData?.dentalSupplier?.logo?.url
            : '';
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
                    profileImageUrl ?? "",
                    jobsListingData?.dentalSupplier?.name ?? jobsListingData?.dentalPractice?.name ?? '',
                    jobsListingData?.dentalSupplier?.directories?.email ?? jobsListingData?.dentalPractice?.directories?.email ?? "",
                    jobsListingData?.dentalSupplier?.directories?.phone ?? jobsListingData?.dentalPractice?.directories?.phone ?? "",
                  ),
                ),
                Row(
                  children: [
                    JobTimeChip(time: time),
                    const SizedBox(width: 4),
                    menuWidget(
                        context,
                        index,
                        jobsListingData?.id ?? '',
                        jobsListingData?.hiringStatus ?? '',
                        vm,
                        type ?? "",
                        professionalId ?? ""),
                  ],
                ),
              ],
            ),
            addVertical(10),
            Row(
              children: [
                _statusChip(jobsListingData?.hiringStatus ?? ''),
                addHorizontal(10),
              ],
            ),
            addVertical(10),
            const Divider(),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    final profileId = jobsListingData?.jobProfilesId;
                    final jobId = jobsListingData?.dentalProfessionalId;
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
                      RouteList.jobProfileTalentMessage,
                      params: {
                        "id": jobsListingData?.id,
                        "dental_supplier_id": jobsListingData?.dentalSupplierId,
                        "dental_practice_id": jobsListingData?.dentalPracticeId,
                        "talentId": jobsListingData?.jobProfilesId,
                        "userId": userId
                      },
                    );
                  },
                  child: _roundedButton("Message"),
                ),
                addHorizontal(10),
                GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => JobProfileEnquiriesView(
                          applicant: vm.jobPrilfeEnquiryData,
                          profileImageUrl: profileImageUrl, // safe now
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
            child: ClipOval(
              child: CachedNetworkImageWidget(
                width: 48,
                height: 48,
                imageUrl: imageUrl,
                errorWidget: CircleAvatar(
                  child: Image.asset(ImageConst.prfImg),
                  radius: 24,
                  backgroundColor: AppColors.primaryColor,
                ),
              ),
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

  Widget menuWidget(
      BuildContext context,
      int index,
      String id,
      String activeStatus,
      JobProfileListingViewModel vm,
      String type,
      String professionalId) {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      onSelected: (value) async {
        if (value == "Interested") {
          vm.updateTalentRequestStatus(context, id, "APPROVE", professionalId);
        } else if (value == "Not Interested") {
          vm.updateTalentRequestStatus(context, id, "REJECT", professionalId);
        }
      },
      itemBuilder: (context) {
        final items = <PopupMenuEntry<String>>[
          if (type == "NotInterested" || type == "")
            PopupMenuItem(
              value: "Interested",
              child: _buildRow(Icons.check, AppColors.black, "Interested"),
            ),
          if (type == "Interested" || type == "")
            PopupMenuItem(
              value: "Not Interested",
              child:
                  _buildRow(Icons.close, AppColors.redColor, "Not Interested"),
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

  Widget _statusChip(String status) {
    Color bgColor;
    Color textColor;
    switch (status.toUpperCase()) {
      case "DRAFT":
        bgColor = AppColors.secondaryBlueColor;
        textColor = AppColors.primaryBlueColor;
        break;
      case "PENDING":
        bgColor = AppColors.pendingprimary;
        textColor = AppColors.pendingsendary;
        break;
      case "ACTIVE":
        bgColor = AppColors.activeprimary;
        textColor = AppColors.activesendary;
        break;
      case "INACTIVE":
        bgColor = AppColors.inactiveprimary;
        textColor = AppColors.inactivesendary;
        break;
      case "REJECTED":
        bgColor = AppColors.inactiveprimary;
        textColor = AppColors.inactivesendary;
        break;
      default:
        bgColor = AppColors.whiteColor;
        textColor = AppColors.pendingsendary;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: TextStyles.semiBold(fontSize: 12, color: textColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
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
