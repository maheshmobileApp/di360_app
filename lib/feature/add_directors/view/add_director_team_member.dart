import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/model/team_members_model.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_team_member_foam.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
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
                _sectionHeader('Add Team Member'),
                CustomAddButton(
                  label: 'Add +',
                  onPressed: () {
                    showNewTeamMemberBottomSheet(context);
                  },
                ),
              ],
            ),
            addVertical(16),
            ...addDirectorVM.TeamMembers.asMap().entries.map((entry) {
              final index = entry.key;
              final teamMember = entry.value;
              return _TeamMemberCard(context, teamMember, index);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _TeamMemberCard(BuildContext context, TeamMembersModel member, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardcolor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.buttomBarColor,
            backgroundImage: member.imageFile != null
                ? FileImage(member.imageFile!)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    text: 'Appointment: ',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.lightGeryColor,
                    ),
                    children: [
                      TextSpan(
                        text: member.appointment ? 'Yes' : 'No',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                  const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    text: 'OurTeam: ',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.lightGeryColor,
                    ),
                    children: [
                      TextSpan(
                        text: member.ourTeam ? 'Yes' : 'No',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  member.Designation,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // const SizedBox(width: 10),
          // GestureDetector(
          //   onTap: () {
          //     showTeamMemberOptionsBottomSheet(context, member, index);
          //   },
          //   child: const Icon(Icons.more_vert, size: 20),
          // ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Provider.of<AddDirectorViewModel>(context, listen: false)
                  .TeamMembers
                  .remove(member);
            },
            child: const Icon(
              Icons.delete_outline,
              color: AppColors.redColor,
              size: 18,
            ),
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
  void showTeamMemberOptionsBottomSheet(
      BuildContext context, TeamMembersModel member, int index) {
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
          initialChildSize: 0.5,
          maxChildSize: 0.8,
          minChildSize: 0.4,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.buttomBarColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.buttomBarColor,
                            backgroundImage: member.imageFile != null
                                ? FileImage(member.imageFile!)
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  member.Designation,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Appointment: ${member.appointment ? 'Yes' : 'No'}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                 const SizedBox(height: 4),
                                Text(
                                  "Our Team: ${member.ourTeam? 'Yes' : 'No'}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    CustomBottomButton(
                      onFirst: () {
                        addDirectorVM.TeamMembers.remove(member);
                        Navigator.pop(context);
                      },
                      onSecond: () {
                        Navigator.pop(context);
                        showEditTeamMemberBottomSheet(context, member, index);
                      },
                      firstLabel: "Delete",
                      secondLabel: "Edit",
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

  void showEditTeamMemberBottomSheet(
      BuildContext context, TeamMembersModel TeamMembers, int index) {
    final addDirectorVM =
        Provider.of<AddDirectorViewModel>(context, listen: false);
    addDirectorVM.selectedteamember = TeamMembers;
    addDirectorVM.loadTeamData(TeamMembers);
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: AddDirectorTeamMemberFoam(),
                      ),
                    ),
                    CustomBottomButton(
                      onFirst: () {
                        addDirectorVM.TeamMembers.remove(TeamMembers);
                        Navigator.pop(context);
                      },
                      onSecond: () {
                        Navigator.pop(context);
                        addDirectorVM.updateTeam(index);
                      },
                      firstLabel: "Delete",
                      secondLabel: "Save",
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
}
