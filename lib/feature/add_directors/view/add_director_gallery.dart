import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/add_directory_gallery_card.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddDirectorGallery extends StatefulWidget {
  const AddDirectorGallery({super.key});

  @override
  State<AddDirectorGallery> createState() => _AddDirectorGalleryState();
}

class _AddDirectorGalleryState extends State<AddDirectorGallery>
    with BaseContextHelpers {
  bool showForm = false;

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _sectionHeader('Gallery'),
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

          if (showForm) _buildGalleryForm(addDirectorVM),
          const Divider(thickness: 2),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: addDirectorVM.Gallerys.length,
            itemBuilder: (context, index) {
              final galleryItem = addDirectorVM.Gallerys[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AddDirectoryGalleryCard(
                  gallery: galleryItem,
                  imageFile: galleryItem.imageFile,
                  index: index,
                  onDelete: () {
                    setState(() {
                      addDirectorVM.Gallerys.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _buildGalleryForm(AddDirectorViewModel addDirectorVM) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          LogoContainer(
            title: "Logo",
            imageFile: addDirectorVM.logoFile,
            onTap: () => _imagePickerSelection(
              context,
              () => addDirectorVM.pickLogoImage(ImageSource.gallery),
              () => addDirectorVM.pickLogoImage(ImageSource.camera),
            ),
          ),
          addVertical(20),
          CustomBottomButton(
            onFirst: () {
              setState(() {
                showForm = false;
              });
            },
            onSecond: () {
              addDirectorVM.addGallery();
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
