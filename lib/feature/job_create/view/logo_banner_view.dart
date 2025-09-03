import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/logo_container.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class LogoAndBannerView extends StatelessWidget with BaseContextHelpers {
  const LogoAndBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<JobCreateViewModel>(context);
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader("Logo & Banner"),
          addVertical(20),
          Text(
            "Logo",
            style: TextStyles.regular3(color: AppColors.black),
          ),
          addVertical(10),
          DottedBorder(
              color: Colors.grey,
              strokeWidth: 2,
              dashPattern: [6, 4],
              borderType: BorderType.RRect,
              radius: Radius.circular(8),
              child: Container(
                width: double.infinity,
                height: getSize(context).height * 0.2,
                child: CachedNetworkImageWidget(
                    imageUrl: homeViewModel.profilePic ?? '',
                    fit: BoxFit.contain,
                    errorWidget: Image.asset(ImageConst.prfImg)),
              )),
          // LogoContainer(
          //   title: "Logo",
          //   imageFile: jobCreateVM.logoFile,
          //   onTap: () => _imagePickerSelection(
          //     context,
          //     () => jobCreateVM.pickLogoImage(ImageSource.gallery),
          //     () => jobCreateVM.pickLogoImage(ImageSource.camera),
          //   ),
          // ),
          addVertical(8),
          LogoContainer(
            title: "Banner",
            imageFile: jobCreateVM.bannerFile,
            onTap: () => _imagePickerSelection(
              context,
              () => jobCreateVM.pickBannerImage(ImageSource.gallery),
              () => jobCreateVM.pickBannerImage(ImageSource.camera),
            ),
          ),
        addVertical(8),
         ImagePickerInputField(
          title: 'Clinic Photo',
          imageFile:jobCreateVM.ClinicPhotofile,
          onTap: () => _imagePickerSelection(
            context,
            () =>jobCreateVM. pickClinicPhoto(ImageSource.gallery),
            () => jobCreateVM. pickClinicPhoto(ImageSource.camera),
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
