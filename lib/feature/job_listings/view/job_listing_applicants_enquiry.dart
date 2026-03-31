import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_listings/model/job_applicants_respo.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class JobListingApplicantsEnquiry extends StatelessWidget
    with BaseContextHelpers {
  final JobApplicants applicant;

  const JobListingApplicantsEnquiry({super.key, required this.applicant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Enquiries",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  color: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (applicant.jobEnquiries != null)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: applicant.jobEnquiries?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ClipOval(
                                        child: SizedBox(
                                          width: 48,
                                          height: 48,
                                          child: CachedNetworkImageWidget(
                                            imageUrl: applicant
                                                    .dentalProfessional
                                                    ?.profileImage
                                                    ?.url ??
                                                '',
                                            fit: BoxFit.cover,
                                            errorWidget: Image.asset(
                                                ImageConst.prfImg,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        applicant.jobEnquiries?[index]
                                                .enquiryDescription ??
                                            '',
                                        style: TextStyles.medium2(),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            },
                          )
                        else
                          const Text("No enquiries found"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
