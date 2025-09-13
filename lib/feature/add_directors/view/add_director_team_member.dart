import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_team_member_foam.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_details_res.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorTeamMember extends StatelessWidget with BaseContextHelpers {
  const AddDirectorTeamMember({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sectionHeader('Add Team Member'),
                CustomAddButton(
                  label: 'Add +',
                  onPressed: () {
                    showNewTeamMemberBottomSheet(context);
                  },
                ),
              ],
            ),
            addVertical(16),
            ...addDirectorVM.getBasicInfoData.first.directoryTeamMembers
                    ?.asMap()
                    .entries
                    .map((data) {
                  final teamData = data.value;
                  return _TeamMemberCard(context, teamData,addDirectorVM);
                }).toList() ??
                [],
          ],
        ),
      ),
    );
  }

  Widget _TeamMemberCard(BuildContext context, DirectoryTeamMembers member,AddDirectorViewModel addDirectorVM) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardcolor,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.buttomBarColor,
              child:
                  CachedNetworkImageWidget(imageUrl: member.image?.url ?? '')),
          addHorizontal(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name ?? '',
                  style: TextStyles.bold3(color: AppColors.black),
                ),
                addVertical(4),
                Text(member.specialization ?? '',style: TextStyles.medium2()),
                addVertical(4),
                Text(member.location ?? '',style: TextStyles.medium2())
              ],
            ),
          ),
          addHorizontal(10),
          GestureDetector(
              onTap: () {
                addDirectorVM.teamNameCntr.text = member.name ?? '';
                addDirectorVM.teamDesignationCntr.text = member.specialization ?? '';
                addDirectorVM.teamEmailIDCntr.text = member.email ?? '';
                addDirectorVM.teamLocationCntr.text = member.location ?? '';
                addDirectorVM.teamNumberCntr.text = member.phone ?? '';
                addDirectorVM.appointmentShowVal = member.showInAppointments ?? false;
                addDirectorVM.ourTeamShowVal = member.showInOurTeam ?? false;
                showNewTeamMemberBottomSheet(context);
              },
              child: Icon(Icons.edit, color: AppColors.blueColor, size: 25)),
          addHorizontal(20),
          GestureDetector(
            onTap: () {},
            child:
                Icon(Icons.delete_outline, color: AppColors.redColor, size: 25),
          ),
        ],
      ),
    );
  }

  void showNewTeamMemberBottomSheet(BuildContext context) {
    final addDirectorVM =
        Provider.of<AddDirectorViewModel>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.6,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.buttomBarColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24))
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        child: AddDirectorTeamMemberFoam(),
                      ),
                    ),
                    CustomBottomButton(
                      onFirst: () => Navigator.pop(context),
                      onSecond: () {
                        addDirectorVM.addTeamMember(context);
                        Navigator.pop(context);
                      },
                      firstLabel: "Close",
                      secondLabel: "Add",
                      firstBgColor: AppColors.timeBgColor,
                      firstTextColor: AppColors.primaryColor,
                      secondBgColor: AppColors.primaryColor,
                      secondTextColor: AppColors.whiteColor,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // void showTeamMemberOptionsBottomSheet(
  //     BuildContext context, TeamMembersModel member, int index) {
  //   final addDirectorVM =
  //       Provider.of<AddDirectorViewModel>(context, listen: false);
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: AppColors.black,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return DraggableScrollableSheet(
  //         initialChildSize: 0.5,
  //         maxChildSize: 0.8,
  //         minChildSize: 0.4,
  //         expand: false,
  //         builder: (context, scrollController) {
  //           return Container(
  //             decoration: const BoxDecoration(
  //               color: AppColors.buttomBarColor,
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //             ),
  //             child: SafeArea(
  //               top: false,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(16),
  //                     child: Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         CircleAvatar(
  //                           radius: 24,
  //                           backgroundColor: AppColors.buttomBarColor,
  //                           backgroundImage: member.imageFile != null
  //                               ? FileImage(member.imageFile!)
  //                               : null,
  //                         ),
  //                         const SizedBox(width: 12),
  //                         Expanded(
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 member.name,
  //                                 style: const TextStyle(
  //                                   fontWeight: FontWeight.w600,
  //                                   fontSize: 16,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                               const SizedBox(height: 4),
  //                               Text(
  //                                 member.Designation,
  //                                 style: TextStyle(
  //                                   fontSize: 14,
  //                                   color: Colors.grey.shade700,
  //                                 ),
  //                               ),
  //                               const SizedBox(height: 4),
  //                               Text(
  //                                 "Appointment: ${member.appointment ? 'Yes' : 'No'}",
  //                                 style: const TextStyle(
  //                                   fontSize: 14,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                               const SizedBox(height: 4),
  //                               Text(
  //                                 "Our Team: ${member.ourTeam ? 'Yes' : 'No'}",
  //                                 style: const TextStyle(
  //                                   fontSize: 14,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   const Spacer(),
  //                   CustomBottomButton(
  //                     onFirst: () {
  //                       addDirectorVM.TeamMembers.remove(member);
  //                       Navigator.pop(context);
  //                     },
  //                     onSecond: () {
  //                       Navigator.pop(context);
  //                       showEditTeamMemberBottomSheet(context, member, index);
  //                     },
  //                     firstLabel: "Delete",
  //                     secondLabel: "Edit",
  //                     firstBgColor: AppColors.timeBgColor,
  //                     firstTextColor: AppColors.primaryColor,
  //                     secondBgColor: AppColors.primaryColor,
  //                     secondTextColor: AppColors.whiteColor,
  //                   )
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // void showEditTeamMemberBottomSheet(
  //     BuildContext context, TeamMembersModel TeamMembers, int index) {
  //   final addDirectorVM =
  //       Provider.of<AddDirectorViewModel>(context, listen: false);
  //   addDirectorVM.selectedteamember = TeamMembers;
  //   addDirectorVM.loadTeamData(TeamMembers);
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: AppColors.black,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return DraggableScrollableSheet(
  //         initialChildSize: 0.85,
  //         maxChildSize: 0.95,
  //         minChildSize: 0.6,
  //         expand: false,
  //         builder: (context, scrollController) {
  //           return Container(
  //             decoration: const BoxDecoration(
  //               color: AppColors.buttomBarColor,
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //             ),
  //             child: SafeArea(
  //               top: false,
  //               child: Column(
  //                 children: [
  //                   Expanded(
  //                     child: SingleChildScrollView(
  //                       controller: scrollController,
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 16, vertical: 20),
  //                       child: AddDirectorTeamMemberFoam(),
  //                     ),
  //                   ),
  //                   CustomBottomButton(
  //                     onFirst: () {
  //                       addDirectorVM.TeamMembers.remove(TeamMembers);
  //                       Navigator.pop(context);
  //                     },
  //                     onSecond: () {
  //                       Navigator.pop(context);
  //                       addDirectorVM.updateTeam(index);
  //                     },
  //                     firstLabel: "Delete",
  //                     secondLabel: "Save",
  //                     firstBgColor: AppColors.timeBgColor,
  //                     firstTextColor: AppColors.primaryColor,
  //                     secondBgColor: AppColors.primaryColor,
  //                     secondTextColor: AppColors.whiteColor,
  //                   )
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
