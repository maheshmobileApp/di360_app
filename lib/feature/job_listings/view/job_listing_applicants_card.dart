import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_listings/model/job_applicants_respo.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
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

            // ---- City + Experience ----
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
                          applicant?.cityName ??
                              "",
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
                      // Text(
                      //   "${applicant?.status ?? '0',
                      //   style: TextStyles.regular1(
                      //     color: AppColors.bottomNavUnSelectedColor,
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),

            // ---- Profile Summary ----
            addVertical(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              // child: Text(
              //   applicant?.jobApplicantMessages != null &&
              //           applicant!.jobApplicantMessages!.isNotEmpty
              //       ? applicant.jobApplicantMessages!.first.toString()
              //       : "",
              //   maxLines: 2,
              //   overflow: TextOverflow.ellipsis,
              //   style: TextStyles.regular1(
              //       color: AppColors.bottomNavUnSelectedColor),
              // ),
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
                  InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                         
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) => const EnquiryBottomSheet(),
                        );
                      },
                      child: _roundedButton("Enquiry")),
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
        //   "APPLIED",
        // "INTERVIEWS",
        // "ACCEPTED",
        // "REJECT",
        // "SHORTLISTED",
        // if (value == "Shortlist") {
        //     vm.updateJobApplicantStatus(context, id,"SHORTLISTED");
        // } else if (value == "Organize Interview") {
        //     vm.updateJobApplicantStatus(context, id, "INTERVIEWS");
        // } else if (value == "Accept") {
        //   vm.updateJobApplicantStatus(context, id,"ACCEPTED");
        // } else if (value == "Decline") {
        //   //  vm.updateJobApplicantStatus(context, id, vm.selectedstatusesforapplicatnts);
        // }
      },
      itemBuilder: (context) => [
        if (status == 'APPLIED' ||
            status == 'ACCEPTED' ||
            status == "INTERVIEWS")
          PopupMenuItem(
            value: "Shortlist",
            child: _buildRow(AppColors.black, "Shortlist"),
          ),
        if (status == 'APPLIED' ||
            status == 'ACCEPTED' ||
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
      ],
    );
  }

  Widget _buildRow(Color? color, String? title) {
    return Row(children: [
      Text(title ?? '', style: TextStyles.semiBold(fontSize: 14, color: color))
    ]);
  }
}

class EnquiryBottomSheet extends StatelessWidget {
  const EnquiryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Enquiry",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),

                // Card Content
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(radius: 24),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("User name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Text("Dental Hygienist",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(Icons.location_on, size: 16),
                            SizedBox(width: 4),
                            Expanded(
                              child:
                                  Text("138 Marsh Street, Armidale, NSW 2350"),
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          children: [
                            Icon(Icons.work, size: 16),
                            SizedBox(width: 4),
                            Text("5 Yrs Experience"),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "About me / Profile Summary, The entire course was re-recorded from scratch and was therefore com...",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),

              // Spacer(),

                // Input field
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Type your enquiry message",
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            // send enquiry
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
