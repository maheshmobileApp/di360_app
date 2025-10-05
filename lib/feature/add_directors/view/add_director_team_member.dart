import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_team_member_foam.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/menu_widget.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_details_res.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorTeamMember extends StatelessWidget with BaseContextHelpers {
  const AddDirectorTeamMember({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final editVM = Provider.of<EditDeleteDirectorViewModel>(context);
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
                    showNewTeamMemberBottomSheet(context, editVM);
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
                  return _TeamMemberCard(
                      context, teamData, addDirectorVM, editVM);
                }).toList() ??
                [],
          ],
        ),
      ),
    );
  }

  Widget _TeamMemberCard(BuildContext context, DirectoryTeamMembers member,
      AddDirectoryViewModel addDirectorVM, EditDeleteDirectorViewModel editVM) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.cardcolor, borderRadius: BorderRadius.circular(16)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.buttomBarColor,
            child: CachedNetworkImageWidget(imageUrl: member.image?.url ?? '')),
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
              Text(member.specialization ?? '', style: TextStyles.medium2()),
              addVertical(4),
              Text(member.location ?? '', style: TextStyles.medium2())
            ],
          ),
        ),
        addHorizontal(10),
        MenuWidget(onSelected: (val) {
          if (val == 'Edit') {
            addDirectorVM.teamNameCntr.text = member.name ?? '';
            addDirectorVM.teamDesignationCntr.text =
                member.specialization ?? '';
            addDirectorVM.teamEmailIDCntr.text = member.email ?? '';
            addDirectorVM.teamLocationCntr.text = member.location ?? '';
            addDirectorVM.teamNumberCntr.text = member.phone ?? '';
            addDirectorVM.appointmentShowVal =
                member.showInAppointments ?? false;
            addDirectorVM.ourTeamShowVal = member.showInOurTeam ?? false;
            showNewTeamMemberBottomSheet(context, editVM,
                hintText: member.image?.url ?? '',
                id: member.id,
                imag: member.image?.toJson());
            editVM.updateIsEditOurTeam(true);
          } else if (val == 'Delete') {
            editVM.deleteTheOurTeam(context, member.id ?? '');
          }
        })
      ]),
    );
  }

  void showNewTeamMemberBottomSheet(
      BuildContext context, EditDeleteDirectorViewModel editVM,
      {String? hintText, String? id, dynamic imag}) {
    final addDirectorVM =
        Provider.of<AddDirectoryViewModel>(context, listen: false);
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      showDragHandle: false,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SizedBox(
          height: getSize(context).height * 0.9,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.buttomBarColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24))),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        AddDirectorTeamMemberFoam(hinttext: hintText),
                        CustomBottomButton(
                          onFirst: () {
                            editVM.updateIsEditOurTeam(false);
                            navigationService.goBack();
                          },
                          onSecond: () {
                            if (_formKey.currentState!.validate()) {
                              if (addDirectorVM.teamMemberFile?.path.isEmpty ??
                                  false || imag == null) {
                                showTopMessage(context, 'Select user picture');
                              } else {
                                editVM.isEditOurTeam
                                    ? editVM.updateTheOurTeam(
                                        context, id ?? '', imag)
                                    : addDirectorVM.addTeamMember(context);
                                navigationService.goBack();
                              }
                            }
                          },
                          firstLabel: "Close",
                          secondLabel: editVM.isEditOurTeam ? 'Update' : "Add",
                          firstBgColor: AppColors.timeBgColor,
                          firstTextColor: AppColors.primaryColor,
                          secondBgColor: AppColors.primaryColor,
                          secondTextColor: AppColors.whiteColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
