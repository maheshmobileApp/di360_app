import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/add_directory_card.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart' as picker;

class AddDirectorCertificate extends StatelessWidget with BaseContextHelpers {
  const AddDirectorCertificate({super.key});

  @override
  Widget build(BuildContext context) {
    final AddDirectorVM = Provider.of<AddDirectorViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('Certificates'),
            addVertical(6),
            InputTextField(
              hintText: "Enter Certificate Name",
              title: "Certificate Name",
              controller: AddDirectorVM.CertificateNameController,
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter certificate name'
                  : null,
            ),
            addVertical(16),
            ImagePickerInputField(
              title: 'Attachment',
              isRequired: true,
              imageFile: AddDirectorVM.certificateFile,
              onTap: () => _imagePickerSelection(
                context,
                () => AddDirectorVM.pickCertificateImage(picker.ImageSource.gallery),
                () => AddDirectorVM.pickCertificateImage(picker.ImageSource.camera),
              ),
              hintText: 'JPEG, PNG, PDF formats, up to 5 MB',
            ),
            addVertical(16),
            Divider(thickness: 4),
            addVertical(16),
            AddDirectoryCard(
              title: 'Certificate Name',
              subtitle: 'JPEG 300kb',
              imagePath: ImageConst.certificate,
              onDelete: () {
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
