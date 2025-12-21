import 'package:cached_network_image/cached_network_image.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_profile_listing/view/job_profile_enquiries_view.dart';
import 'package:di360_flutter/feature/talent_enquiries/model/get_talent_enquiry_res.dart';
import 'package:di360_flutter/feature/talent_enquiries/view_model/talent_enquiry_view_model.dart';
import 'package:di360_flutter/feature/talent_listing/view_model/talent_listing_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/job_time_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class TalentEnquiryCard extends StatelessWidget with BaseContextHelpers {
  final TalentEnquiries? jobProfiles;
  final TalentEnquiryViewModel vm;
  final int? index;

  const TalentEnquiryCard({
    super.key,
    required this.jobProfiles,
    required this.vm,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(jobProfiles?.createdAt ?? '') ?? '';
    final String? profileImageUrl =
        (jobProfiles?.jobProfiles?.profileImage?.first.url?.isNotEmpty == true)
            ? jobProfiles!.jobProfiles!.profileImage?.first.url
            : null;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _logoWithTitle(
                    context,
                    profileImageUrl,
                    jobProfiles?.jobProfiles?.fullName ?? '',
                    jobProfiles?.jobProfiles?.professionType ?? '',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                       // _TalentMenu(jobProfiles?.hiringStatus ?? '',context, vm),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            addVertical(8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _chipWidget(jobProfiles?.jobProfiles?.workType ?? [])),
                JobTimeChip(time: time),
              ],
            ),
            addVertical(10),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        final profileId = jobProfiles?.id;
                        final jobId = jobProfiles?.jobProfiles?.professionType??"";
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
                          RouteList.TalentListingMessageScreen,
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
                
                  ],
                ),
                
                  Row(
                        children: [
                          Text(
                            "View Details",
                            style: TextStyles.medium1(
                                color: AppColors.primaryColor),
                          ),
                          SvgPicture.asset(
                            ImageConst.nextArrow,
                            width: 26,
                            height: 26,
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoWithTitle(
      BuildContext context, String? imageUrl, String title, String role) {
    Widget avatarChild;
    if (imageUrl != null &&
        imageUrl.isNotEmpty &&
        Uri.tryParse(imageUrl)?.hasAbsolutePath == true) {
      avatarChild = CachedNetworkImage(
        imageUrl: imageUrl,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => const Icon(Icons.error),
      );
    } else {
      avatarChild = const Icon(Icons.person, size: 30);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[200],
          child: ClipOval(child: avatarChild),
        ),
        addHorizontal(6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(role,
                  style:
                      TextStyles.semiBold(fontSize: 16, color: AppColors.black),
                  overflow: TextOverflow.ellipsis,maxLines: 2,),
              addVertical(4),
              Text(title,
                  style: TextStyles.regular2(color: AppColors.black),
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chipWidget(List<String> types) {
    if (types.isEmpty) return const SizedBox();
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: types
          .where((type) => type.isNotEmpty)
          .map((type) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBlueColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  type,
                  style: TextStyles.regular1(
                      fontSize: 12, color: AppColors.primaryBlueColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
    );
  }

  Widget _statusChip(String adminStatus) {
    final status = adminStatus.toLowerCase();
    Color bgColor;
    Color textColor;
    switch (status) {
      case "pending":
        bgColor = const Color.fromRGBO(225, 146, 0, 0.1);
        textColor = const Color.fromRGBO(225, 146, 0, 1);
        break;
      case "approve":
        bgColor = const Color.fromRGBO(0, 147, 79, 0.1);
        textColor = const Color.fromRGBO(0, 147, 79, 1);
        break;
      case "rejected":
      case "reject":
        bgColor = const Color.fromRGBO(215, 19, 19, 0.1);
        textColor = const Color.fromRGBO(215, 19, 19, 1);
        break;
      default:
        bgColor = const Color.fromRGBO(253, 245, 229, 1);
        textColor = const Color.fromRGBO(225, 146, 0, 1);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(30)),
      child: Text(
        status,
        style: TextStyles.semiBold(fontSize: 12, color: textColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
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

  Widget _TalentMenu(String adminStatus,BuildContext context,TalentListingViewModel vm) {
    return PopupMenuButton<String>(
      iconColor: Colors.grey,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (value) async{
        if (value == "Preview") {
          //final profileId = jobProfiles?.jobProfiles?.id ?? jobProfiles?.jobProfilesId ?? "";
          
          //await vm.getTalentPreviewData(context, profileId);
          
          if (vm.talentPreviewData != null) {
            navigationService.navigateToWithParams(
              RouteList.talentdetailsScreen,
              params: {'talentData': vm.talentPreviewData},
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Talent data not available")),
            );
          }
        } else if (value == "Cancel") {

        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "Preview",
          child: _buildRow(Icons.remove_red_eye, AppColors.black, "Preview"),
        ),
        PopupMenuItem(
          value: "Cancel",
          child: _buildRow(Icons.cancel, AppColors.redColor, "Cancel"),
        ),
      ],
    );
  }

  Widget _buildRow(IconData icon, Color color, String title) => Row(children: [
        Icon(icon, color: color, size: 18),
        addHorizontal(8),
        Text(title, style: TextStyles.semiBold(fontSize: 14, color: color))
      ]);

  String? _getShortTime(String createdAt) {
    return Jiffy.parse(createdAt).fromNow();
  }
}
