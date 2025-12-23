import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class JobProfileEnquiriesView extends StatelessWidget with BaseContextHelpers {
  final JobProfileEnquiriesResList? applicant;
  final String? profileImageUrl;

  const JobProfileEnquiriesView({
    super.key,
    required this.applicant,
    this.profileImageUrl,
  });

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
                        if (applicant?.talentEnquiries != null)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: applicant?.talentEnquiries!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.end,
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        child: CachedNetworkImageWidget(
                                            imageUrl: profileImageUrl ?? '',
                                            fit: BoxFit.fill,
                                            errorWidget:
                                                Image.asset(ImageConst.prfImg)),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        DateFormatUtils.formatDateTime(applicant
                                                ?.talentEnquiries![index]
                                                .createdAt ??
                                            ''),
                                        style: TextStyles.regular1(),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    applicant?.talentEnquiries![index]
                                            .enquiryDescription ??
                                        '',
                                    style: TextStyles.medium2(),
                                  )
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
