import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/professional_add_director/view/add_profess_director/add_social_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherInforScreen extends StatelessWidget {
  const OtherInforScreen({super.key});

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
                sectionHeader('Add Social Account URL'),
                CustomAddButton(
                  label: 'Add +',
                  onPressed: () {
                    addDirectorVM.selectedAccount = null;
                    addDirectorVM.socialAccountsurlCntr.clear();
                    editVM.updateIsEditSocialMed(false);
                    showBusinessTimingsBottomSheet(context, '');
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
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.45,
            maxChildSize: 0.9,
            minChildSize: 0.3,
            expand: false,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
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
                              horizontal: 16, vertical: 20),
                          child: AddSocialForm(id: id),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
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
            if(socialList?.isNotEmpty ?? false)
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
                      Text(data?.mediaName ?? '', style: TextStyles.medium2()),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            addDirectVM.selectedAccount = data?.mediaName;
                            addDirectVM.socialAccountsurlCntr.text =
                                data?.mediaLink ?? '';
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
