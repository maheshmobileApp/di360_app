import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_listings/model/job_applicants_respo.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class JobListingApplicantsCard extends StatelessWidget with BaseContextHelpers {
  final JobApplicants? jobsListingData;
  final JobListingsViewModel vm;
  final int? index;

  const JobListingApplicantsCard({
    super.key,
    required this.jobsListingData,
    required this.vm,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final applicant = jobsListingData;
    final professional = applicant?.dentalProfessional;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(116, 130, 148, 0.2),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Top Section: Avatar + Name + Role + Menu ----
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.geryColor,
                    backgroundImage: professional?.profileImage?.url != null
                        ? NetworkImage(professional!.profileImage!.url!)
                        : null,
                    child: professional?.profileImage?.url == null
                        ? const Icon(Icons.person,
                            color: AppColors.whiteColor)
                        : null,
                  ),
                  addHorizontal(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${professional?.firstName ?? applicant?.firstName ?? "User"} ${professional?.lastName ?? ""}",
                          style:
                              TextStyles.semiBold(color: AppColors.black),
                        ),
                        addVertical(2),
                        Text(
                          professional?.name ?? "Job Role",
                          style: TextStyles.regular2(
                            color: AppColors.bottomNavUnSelectedColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  menuWidget(
                    vm,
                    context,
                    index ?? 0,
                    applicant?.id ?? '',
                    applicant?.status ?? '',
                  ),
                ],
              ),
            ),

            // ---- City + Experience ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 16,
                          color: AppColors.bottomNavUnSelectedColor),
                      addHorizontal(6),
                      Expanded(
                        child: Text(
                          applicant?.cityName ??
                              "123 Marsh Street, Armidale, NSW",
                          style: TextStyles.regular1(
                              color: AppColors.bottomNavUnSelectedColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  addVertical(6),
                  Row(
                    children: [
                      SvgPicture.asset(
                        ImageConst.briefcaseSvg,
                        height: 16,
                        width: 16,
                      ),
                      addHorizontal(6),
                      Text(
                        "${applicant?.status ?? '0'} Yrs Experience",
                        style: TextStyles.regular1(
                          color: AppColors.bottomNavUnSelectedColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // ---- Profile Summary ----
            addVertical(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                applicant?.jobApplicantMessages != null &&
                        applicant!.jobApplicantMessages!.isNotEmpty
                    ? applicant.jobApplicantMessages!.first.toString()
                    : "About me / Profile Summary, short description here...",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.regular1(
                    color: AppColors.bottomNavUnSelectedColor),
              ),
            ),

            // ---- Bottom Buttons ----
            addVertical(8),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  _roundedButton("Message"),
                  addHorizontal(10),
                  _roundedButton("Enquiry"),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios,
                      size: 12, color: AppColors.primaryColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- Helper Buttons ----
  Widget _roundedButton(String label) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.timeBgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            label == "Message" ? Icons.message_outlined : Icons.help_outline,
            size: 16,
            color: AppColors.primaryColor,
          ),
          addHorizontal(4),
          Text(
            label,
            style: TextStyles.medium1(
              color: AppColors.primaryColor,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // ---- Popup Menu ----
  Widget menuWidget(
    JobListingsViewModel vm,
    BuildContext context,
    int index,
    String id,
    String status,
  ) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      offset: const Offset(0, 40),
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.more_vert,
          color: AppColors.bottomNavUnSelectedColor),
      onSelected: (value) {
        switch (value) {
          case "Decline":
            showAlertMessage(
                context, 'Are you sure you want to delete this listing?',
                onBack: () {
              navigationService.goBack();
              vm.removeJobsListingData(context, id);
            });
            break;
        }
      },
      itemBuilder: (context) => [
        _popupItem("View", Icons.remove_red_eye, AppColors.black),
        _popupItem("Accept", Icons.check_circle_outline, AppColors.greenColor),
        _popupItem("Shortlist", Icons.person_add_alt, AppColors.primaryBlueColor),
        _popupItem("Decline", Icons.block, AppColors.primaryBlueColor),
      ],
    );
  }

  PopupMenuItem<String> _popupItem(String label, IconData icon, Color color) {
    return PopupMenuItem(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          addHorizontal(8),
          Text(label,
              style: TextStyles.semiBold(color: color, fontSize: 14)),
        ],
      ),
    );
  }
}
