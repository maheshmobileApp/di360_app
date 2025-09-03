import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/add_directory_achievement_card.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
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
                _sectionHeader('Achievements'),
                CustomAddButton(
                  label: showForm ? 'Cancel' : 'Add +',
                  onPressed: () {
                    setState(() {
                      showForm = !showForm;
                    });
                  },
                ),
              ],
            ),

            if (showForm) _buildAchievementForm(addDirectorVM),

            const Divider(thickness: 2),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: addDirectorVM.Achievements.length,
              itemBuilder: (context, index) {
                final achievement = addDirectorVM.Achievements[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AddDirectoryAchievementCard(
                    title: achievement.name,
                    imageFile: achievement.imageFile,
                    achievement: achievement,
                    index: index,
                    onDelete: () {
                      setState(() {
                        addDirectorVM.Achievements.removeAt(index);
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

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _buildAchievementForm(AddDirectorViewModel addDirectorVM) {
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
            controller: addDirectorVM.AchievementNameController,
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
            onTap: () => _imagePickerSelection(
              context,
              () => addDirectorVM.pickAchievementImage(picker.ImageSource.gallery),
              () => addDirectorVM.pickAchievementImage(picker.ImageSource.camera),
            ),
            hintText: 'JPEG, PNG, PDF formats, up to 5 MB',
          ),
          addVertical(20),
          CustomBottomButton(
            onFirst: () {
              setState(() {
                showForm = false;
              });
            },
            onSecond: () {
              addDirectorVM.addAchievement();
              setState(() {
                showForm = false;
              });
            },
            firstLabel: "Close",
            secondLabel: "Add",
            firstBgColor: AppColors.timeBgColor,
            firstTextColor: AppColors.primaryColor,
            secondBgColor: AppColors.primaryColor,
            secondTextColor: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }

  void _imagePickerSelection(
    BuildContext context,
    VoidCallback? galleryOnTap,
    VoidCallback? cameraOnTap,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: galleryOnTap,
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: cameraOnTap,
            ),
          ],
        );
      },
    );
  }
}
