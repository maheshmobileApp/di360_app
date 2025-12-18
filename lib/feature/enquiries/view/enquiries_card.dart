import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/enquiries/model/enquiries_list_res.dart';
import 'package:di360_flutter/feature/enquiries/view/enquiries_list_view.dart';
import 'package:di360_flutter/feature/enquiries/view_model/enquiries_view_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/job_time_chip.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class EnquiriesCard extends StatelessWidget with BaseContextHelpers {
  final JobEnquiries? enquiry;
  final int? index;

  const EnquiriesCard({
    super.key,
    required this.enquiry,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final Jobs? job = enquiry?.jobs;
    final String time = _getShortTime(enquiry?.createdAt ?? '') ?? '';
    final vm = Provider.of<EnquiriesViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _logoWithTitle(
                    context,
                    enquiry?.jobs?.logo ?? '',
                    enquiry?.jobs?.title ?? '',
                    enquiry?.jobs?.jRole ?? '',
                    enquiry?.jobs?.companyName ?? '',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        JobTimeChip(time: time),
                        addHorizontal(4),
                        _EnquiriesMenu(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            addVertical(8),
            // Employment types
            if (enquiry != null)
              Row(
                children: [
                  Expanded(
                      child:
                          _chipWidget(enquiry?.jobs?.typeofEmployment ?? [])),
                ],
              ),
            //addVertical(10),
            // Description
            //_descriptionWidget(''),
            const Divider(),
            // Actions
            Row(
              children: [
                InkWell(
                  onTap: () async {
                     if (enquiry?.id == null || enquiry?.jobId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Applicant or Job ID not available"),
                        ),
                      );
                      return;
                    }

                    final userId = await LocalStorage.getStringVal(
                        LocalStorageConst.userId);

                     navigationService.navigateToWithParams(
                      RouteList.enquiryMessagesView,
                      params: {
                        "jobId": enquiry?.jobId ?? "",
                        "applicantId":enquiry?.id?? "",
                        "userId": userId,
                        "type": "applicant",
                        
                      },
                    );
                  },
                  child: _roundedButton("Message"),
                ),
                addHorizontal(10),
                GestureDetector(
                  onTap: () async {
                    await vm.getApplicantEnquiryData(
                      context,
                      enquiry?.jobs?.id ?? '',
                    );
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => EnquiriesListView(
                        applicant: vm.applicantEnquiriesListData,
                        profileImageUrl:
                            enquiry?.dentalProfessional?.profileImage?.url ??
                                '',
                      ),
                    );
                  },
                  child: _roundedButton("Enquiry"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoWithTitle(BuildContext context, String imageUrl, String title,
      String role, String companyName) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
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
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.error),
                      ),
                    ),
                  )
                : const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey,
                  ),
          ),
        ),
        addHorizontal(6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    TextStyles.semiBold(fontSize: 16, color: AppColors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              addVertical(4),
              Text(
                role,
                style: TextStyles.regular2(color: AppColors.geryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                companyName,
                style: TextStyles.regular2(color: AppColors.lightGeryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _descriptionWidget(String description) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        description.isNotEmpty ? description : "",
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.regular1(
          color: AppColors.bottomNavUnSelectedColor,
        ),
      ),
    );
  }

  Widget _chipWidget(List<String> types) {
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
          ),
        );
      }).toList(),
    );
  }

  Widget _roundedButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1E5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            label == "Message" ? Icons.chat : Icons.live_help_outlined,
            size: 18,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyles.medium1(
              fontSize: 13,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _EnquiriesMenu() {
    return PopupMenuButton<String>(
      iconColor: Colors.grey,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (value) {
        if (value == "Preview") {
          if (enquiry?.jobs != null) {
            navigationService.navigateToWithParams(
              RouteList.jobdetailsScreen,
              params: enquiry?.jobs,
            );
          }
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "Preview",
          child: _buildRow(Icons.remove_red_eye, AppColors.black, "Preview"),
        ),
      ],
    );
  }

  Widget _buildRow(IconData icon, Color color, String title) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        addHorizontal(8),
        Text(
          title,
          style: TextStyles.semiBold(fontSize: 14, color: color),
        ),
      ],
    );
  }

  String? _getShortTime(String createdAt) {
    try {
      return Jiffy.parse(createdAt).fromNow();
    } catch (_) {
      return '';
    }
  }
}
