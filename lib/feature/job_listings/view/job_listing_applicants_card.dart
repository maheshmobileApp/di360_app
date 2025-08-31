import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_listings/model/job_applicants_respo.dart';
import 'package:di360_flutter/feature/job_listings/view/job_listing_applicants_enquiry.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';

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
                        ? const Icon(Icons.person, color: AppColors.whiteColor)
                        : null,
                  ),
                  addHorizontal(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${professional?.firstName ?? applicant?.firstName ?? "User"} ${professional?.lastName ?? ""}",
                          style: TextStyles.semiBold(color: AppColors.black),
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
                    index!,
                    applicant?.id ?? '',
                    applicant?.status ?? '',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 16, color: AppColors.bottomNavUnSelectedColor),
                      addHorizontal(6),
                      Expanded(
                        child: Text(
                          applicant?.cityName ?? "",
                          style: TextStyles.regular1(
                              color: AppColors.bottomNavUnSelectedColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  addVertical(6),
                  Row(children: [_statusChip(applicant?.status ?? "")]),
                ],
              ),
            ),
            addVertical(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            addVertical(8),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  _roundedButton("Resume"),
                  addHorizontal(10),
                  InkWell(onTap: () {
                     navigationService
                                .navigateTo(RouteList.JobListingApplicantsMessege); 
                  }, child: _roundedButton("Message")),
                  addHorizontal(10),
                  InkWell(
                      onTap: () {
                        if (applicant == null) {
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
                          builder: (context) => JobListingApplicantsEnquiry(
                            applicant: applicant, // safe now
                          ),
                        );
                      },
                      child: _roundedButton("Enquiry")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roundedButton(String label) {
    IconData icon;

    if (label == "Resume") {
      icon = Icons.picture_as_pdf;
    } else if (label == "Message") {
      icon = Icons.message_outlined;
    } else {
      icon = Icons.help_outline;
    }

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
          Icon(icon, size: 16, color: AppColors.primaryColor),
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
        String newStatus = "";
        switch (value) {
          case "Shortlist":
            newStatus = "SHORTLISTED";
            break;
          case "Organize Interview":
            newStatus = "INTERVIEWS";
            break;
          case "Accept":
            newStatus = "ACCEPTED";
            break;
          case "Decline":
            newStatus = "DECLINED";
            break;
        }
        if (newStatus.isNotEmpty) {
          vm.updateJobApplicantStatus(context, id, newStatus);
        }
      },
      itemBuilder: (context) => [
        if (status == 'APPLIED' ||
            status == 'ACCEPTED' ||
            status == 'DECLINED' ||
            status == "INTERVIEWS")
          PopupMenuItem(
            value: "Shortlist",
            child: _buildRow(AppColors.black, "Shortlist"),
          ),
        if (status == 'APPLIED' ||
            status == 'ACCEPTED' ||
            status == 'DECLINED' ||
            status == 'SHORTLISTED')
          PopupMenuItem(
              value: "Organize Interview",
              child: _buildRow(AppColors.black, "Organize Interview")),
        if (status == 'APPLIED' ||
            status == 'INTERVIEWS' ||
            status == 'SHORTLISTED')
          PopupMenuItem(
              value: "Accept", child: _buildRow(AppColors.black, "Accept")),
        if (status == 'APPLIED' ||
            status == 'ACCEPTED' ||
            status == "INTERVIEWS" ||
            status == 'SHORTLISTED')
          PopupMenuItem(
              value: "Decline", child: _buildRow(AppColors.black, "Decline")),
        if (
            status == 'DECLINED' 
            )
          PopupMenuItem(
              value: "Accept", child: _buildRow(AppColors.black, "Accept")),
      ],
    );
  }

  Widget _buildRow(Color? color, String? title) {
    return Row(children: [
      Text(title ?? '', style: TextStyles.semiBold(fontSize: 14, color: color))
    ]);
  }

  Widget _statusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(253, 245, 229, 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: TextStyles.semiBold(
          fontSize: 12,
          color: const Color.fromRGBO(225, 146, 0, 1),
        ),
      ),
    );
  }
}
