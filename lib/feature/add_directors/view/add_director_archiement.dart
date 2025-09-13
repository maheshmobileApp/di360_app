import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/add_directory_achievement_card.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart' as picker;

class AddDirectorAchievement extends StatefulWidget {
  const AddDirectorAchievement({super.key});

  @override
  State<AddDirectorAchievement> createState() => _AddDirectorAchievementState();
}

class _AddDirectorAchievementState extends State<AddDirectorAchievement>
    with BaseContextHelpers {
  bool showForm = false;
  String? fileName = '';
  String? editId = '';
  dynamic img;

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);
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
                sectionHeader('Achievements'),
                CustomAddButton(
                  label: showForm ? 'Cancel' : 'Add +',
                  onPressed: () {
                    setState(() {
                      fileName = null;
                      addDirectorVM.achievementNameController.clear();
                      showForm = !showForm;
                    });
                  },
                ),
              ],
            ),
            if (showForm) _buildAchievementForm(addDirectorVM, editVM),
            const Divider(thickness: 2),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: addDirectorVM
                  .getBasicInfoData.first.directoryAchievements?.length,
              itemBuilder: (context, index) {
                final achievement = addDirectorVM
                    .getBasicInfoData.first.directoryAchievements?[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AddDirectoryAchievementCard(
                    title: achievement?.title ?? '',
                    imageFile: achievement?.attachments?.url,
                    onDelete: () {
                      editVM.deleteTheAchieve(context, achievement?.id ?? '');
                    },
                    onEdit: () {
                      addDirectorVM.achievementNameController.text =
                          achievement?.title ?? '';
                      editVM.updateIsEditAchieve(true);
                      setState(() {
                        fileName = achievement?.attachments?.name;
                        editId = achievement?.id;
                        img = achievement?.attachments?.toJson();
                        showForm = true;
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementForm(
      AddDirectorViewModel addDirectorVM, EditDeleteDirectorViewModel editVM) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          InputTextField(
            hintText: "Enter Achievement Name",
            title: "Achievement Name",
            controller: addDirectorVM.achievementNameController,
            isRequired: true,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter achievement name'
                : null,
          ),
          addVertical(16),
          ImagePickerInputField(
            title: 'Attachment',
            isRequired: true,
            imageFile: addDirectorVM.achievementFile,
            onTap: () => imagePickerSelection(
              context,
              () => addDirectorVM
                  .pickAchievementImage(picker.ImageSource.gallery),
              () =>
                  addDirectorVM.pickAchievementImage(picker.ImageSource.camera),
            ),
            hintText: fileName ?? 'JPEG, PNG, PDF formats, up to 5 MB',
          ),
          addVertical(20),
          CustomBottomButton(
            onFirst: () {
              setState(() {
                showForm = false;
              });
              editVM.updateIsEditAchieve(false);
            },
            onSecond: () {
              if (addDirectorVM.achievementNameController.text.isEmpty) {
                scaffoldMessenger('Enter achievement name');
              } else if (addDirectorVM.achievementFile?.path.isEmpty ??
                  false || img == null) {
                scaffoldMessenger('Enter attachement');
              } else {
                editVM.isEditAchieve
                    ? editVM.updateTheAchieve(context, editId ?? '', img)
                    : addDirectorVM.addAchievement(context);
                setState(() {
                  showForm = false;
                });
                editVM.updateIsEditAchieve(false);
              }
            },
            firstLabel: "Close",
            secondLabel: editVM.isEditAchieve ? 'Update' : "Add",
            firstBgColor: AppColors.timeBgColor,
            firstTextColor: AppColors.primaryColor,
            secondBgColor: AppColors.primaryColor,
            secondTextColor: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }
}
