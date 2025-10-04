import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_timings_foam.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherInformationScreen extends StatelessWidget {
  const OtherInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final editVM = Provider.of<EditDeleteDirectorViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sectionHeader('Add Business Timings'),
                CustomAddButton(
                  label: 'Add +',
                  onPressed: () {
                    addDirectorVM.selectWeekCntr.clear();
                    addDirectorVM.serviceStartTimeCntr.clear();
                    addDirectorVM.serviceEndTimeCntr.clear();
                    addDirectorVM.selectedAccount = null;
                    addDirectorVM.selectedDays = null;
                    addDirectorVM.socialAccountsurlCntr.clear();
                    editVM.updateIsEditTimings(false);
                    editVM.updateIsEditSocialMed(false);
                    showBusinessTimingsBottomSheet(context, '');
                  },
                ),
              ],
            ),
            SizedBox(height: 15),
            timingsWidget(addDirectorVM, editVM),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sectionHeader('Add Social Accounts'),
                CustomAddButton(
                  label: 'Add +',
                  onPressed: () {
                    addDirectorVM.selectWeekCntr.clear();
                    addDirectorVM.serviceStartTimeCntr.clear();
                    addDirectorVM.serviceEndTimeCntr.clear();
                    addDirectorVM.selectedAccount = null;
                    addDirectorVM.selectedDays = null;
                    addDirectorVM.socialAccountsurlCntr.clear();
                    editVM.updateIsEditTimings(false);
                    editVM.updateIsEditSocialMed(false);
                    showSocialAccountBottomSheet(context, '');
                  },
                ),
              ],
            ),
            SizedBox(height: 15),
            socialURLWidget(addDirectorVM, editVM)
          ],
        ),
      ),
    );
  }

  void showBusinessTimingsBottomSheet(BuildContext context, String id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      showDragHandle: false,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SafeArea(
              top: false,
              child: AddDirectorTimingsFoam(id: id),
            ),
          ),
        );
      },
    );
  }

  void showSocialAccountBottomSheet(BuildContext context, String id) {
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
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: AddSocialAccountForm(id: id),
          ),
        );
      },
    );
  }

  Widget timingsWidget(
      AddDirectoryViewModel addDirectVM, EditDeleteDirectorViewModel editVM) {
    final timeList = addDirectVM.getBasicInfoData.first.directoryLocations
        ?.where((v) => v.status == "TIME")
        .toList();
    return Container(
      decoration: BoxDecoration(
          color: AppColors.cardcolor, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: timeList?.length,
          itemBuilder: (context, index) {
            final obj = timeList?[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(obj?.weekName ?? '',
                          style: TextStyles.medium2(
                              color: AppColors.primaryColor)),
                      SizedBox(height: 5),
                      Text(obj?.clinicTime ?? '',
                          style: TextStyles.medium2(color: AppColors.black))
                    ],
                  ),
                  Spacer(),
                  MenuWidget(onSelected: (v) {
                    if (v == 'Edit') {
                      List<String> parts = obj?.clinicTime?.split('-') ?? [];
                      addDirectVM.selectWeekCntr.text = obj?.weekName ?? '';
                      addDirectVM.selectedDays = obj?.weekName ?? '';
                      addDirectVM.serviceStartTimeCntr.text = parts[0].trim();
                      addDirectVM.serviceEndTimeCntr.text = parts[1].trim();
                      editVM.updateIsEditTimings(true);
                      showBusinessTimingsBottomSheet(context, obj?.id ?? '');
                    } else if (v == 'Delete') {
                      editVM.deleteTheTimimngs(context, obj?.id ?? '');
                    }
                  })
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget socialURLWidget(
      AddDirectoryViewModel addDirectVM, EditDeleteDirectorViewModel editVM) {
    final socialList = addDirectVM.getBasicInfoData.first.directoryLocations
        ?.where((v) => v.status == "SOCIAL")
        .toList();
    return Container(
      decoration: BoxDecoration(
          color: AppColors.cardcolor, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionHeader('Social Accounts'),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: socialList?.length,
              itemBuilder: (context, index) {
                final data = socialList?[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Text(data?.mediaName, style: TextStyles.medium2()),
                    Spacer(),
                    MenuWidget(onSelected: (v) {
                      if (v == 'Edit') {
                        addDirectVM.selectedAccount = data?.mediaName;
                        addDirectVM.socialAccountsurlCntr.text =
                            data?.mediaLink;
                        editVM.updateIsEditSocialMed(true);
                        showBusinessTimingsBottomSheet(context, data?.id ?? '');
                      } else if (v == 'Delete') {
                        editVM.deleteTheTimimngs(context, data?.id ?? '');
                      }
                    })
                  ]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
