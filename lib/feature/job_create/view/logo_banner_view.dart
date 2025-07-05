import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class LogoAndBannerView extends StatelessWidget with BaseContextHelpers {
  const LogoAndBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<JobCreateViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader("Logo & Banner"),
          addVertical(20),
          LogoContainer(
            title: "Logo",
            isRequired: true,
            imageFile: jobCreateVM.logoFile,
            onTap: () => _imagePickerSelection(
              context,
              () => jobCreateVM.pickLogoImage(ImageSource.gallery),
              () => jobCreateVM.pickLogoImage(ImageSource.camera),
            ),
          ),
          if (jobCreateVM.logoFile == null)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text('Please upload a logo',
                  style: TextStyle(color: Colors.red)),
            ),

          addVertical(8),
          LogoContainer(
            title: "Banner",
            isRequired: true,
            imageFile: jobCreateVM.bannerFile,
            onTap: () => _imagePickerSelection(
              context,
              () => jobCreateVM.pickBannerImage(ImageSource.gallery),
              () => jobCreateVM.pickBannerImage(ImageSource.camera),
            ),
          ),
          if (jobCreateVM.bannerFile == null)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text('Please upload a banner',
                  style: TextStyle(color: Colors.red)),
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
