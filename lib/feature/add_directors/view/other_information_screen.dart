import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_timings_foam.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherInformationScreen extends StatelessWidget {
  const OtherInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);
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
      backgroundColor: Colors.transparent,
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
                color: Colors.white,
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
                        child: AddDirectorTimingsFoam(id: id),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget timingsWidget(
      AddDirectorViewModel addDirectVM, EditDeleteDirectorViewModel editVM) {
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
                  InkWell(
                      onTap: () {
                        List<String> parts = obj?.clinicTime?.split('-') ?? [];
                        addDirectVM.selectWeekCntr.text = obj?.weekName ?? '';
                        addDirectVM.serviceStartTimeCntr.text = parts[0].trim();
                        addDirectVM.serviceEndTimeCntr.text = parts[1].trim();
                        editVM.updateIsEditTimings(true);
                        showBusinessTimingsBottomSheet(context, obj?.id ?? '');
                      },
                      child: Icon(Icons.edit,
                          color: AppColors.blueColor, size: 25)),
                  SizedBox(width: 20),
                  InkWell(
                      onTap: () =>
                          editVM.deleteTheTimimngs(context, obj?.id ?? ''),
                      child: Icon(Icons.delete,
                          color: AppColors.redColor, size: 25)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget socialURLWidget(
      AddDirectorViewModel addDirectVM, EditDeleteDirectorViewModel editVM) {
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
                  child: Row(
                    children: [
                      Text(data?.mediaName, style: TextStyles.medium2()),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            addDirectVM.selectedAccount = data?.mediaName;
                            addDirectVM.socialAccountsurlCntr.text =
                                data?.mediaLink;
                            editVM.updateIsEditSocialMed(true);
                            showBusinessTimingsBottomSheet(
                                context, data?.id ?? '');
                          },
                          child: Icon(Icons.edit,
                              color: AppColors.blueColor, size: 25)),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () =>
                            editVM.deleteTheTimimngs(context, data?.id ?? ''),
                        child: Icon(Icons.delete,
                            color: AppColors.redColor, size: 25),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
