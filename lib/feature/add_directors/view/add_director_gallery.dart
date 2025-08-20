import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddDirectorGallery extends StatelessWidget with BaseContextHelpers {
  const AddDirectorGallery({super.key});

  @override
  Widget build(BuildContext context) {
     final AddDirectorVM = Provider.of<AddDirectorViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader("Gallery"),
          addVertical(8),
          LogoContainer(
            title: "Images",
            imageFile:  AddDirectorVM.galleryFile,
            onTap: () => _imagePickerSelection(
              context,
              () =>  AddDirectorVM.pickBannerImage(ImageSource.gallery),
              () =>  AddDirectorVM.pickBannerImage(ImageSource.camera),
            ),
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
