import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/director_partner_multi_images_widget.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/radio_button_group.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart' as picker;

class AddPartners extends StatelessWidget with BaseContextHelpers {
  final String? hintText;
  const AddPartners({super.key, this.hintText});

  @override
  Widget build(BuildContext context) {
    final AddDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final editVM = Provider.of<EditDeleteDirectorViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sectionHeader(
                editVM.isEditPartner ? 'Update Partner' : "Add Partner"),
            InkWell(
                onTap: () => navigationService.goBack(),
                child: Icon(Icons.close, color: AppColors.black))
          ],
        ),
        addVertical(6),
        InputTextField(
          hintText: "Enter partner name",
          title: "Partner Name",
          controller: AddDirectorVM.partnerNameCntr,
          isRequired: true,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter partner name'
              : null,
        ),
        addVertical(12),
        ImagePickerInputField(
          title: 'Image ',
          isRequired: true,
          imageFile: AddDirectorVM.partnerImgFile,
          onTap: () => imagePickerSelection(
            context,
            () => AddDirectorVM.pickPartnerImage(picker.ImageSource.gallery),
            () => AddDirectorVM.pickPartnerImage(picker.ImageSource.camera),
          ),
          hintText: hintText ?? 'Choose an image or drag',
        ),
        addVertical(12),
        InputTextField(
          hintText: "Enter  Description",
          title: "Description",
          controller: AddDirectorVM.descriptionCntr,
          isRequired: true,
          maxLines: 5,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter your Description'
              : null,
        ),
        addVertical(12),
        DirectorPartnerMultiImagesWidget(
          key: ValueKey(
              'partner_images_${editVM.isEditPartner}_${editVM.existingImages.length}'),
        ),
        addVertical(12),
        (editVM.communityStatus && editVM.selectedFiles.length != 0)
            ? CustomRadioGroup<String>(
                title: "Show Promotions Deal to",
                isRequired: true,
                options: const ["Members Only", "All Users"],
                selectedValue: AddDirectorVM.selectedShowPromotion,
                labelBuilder: (value) => value,
                direction: Axis.vertical, // try Axis.vertical also
                onChanged: (value) {
                  AddDirectorVM.setSelectedShowPromotion(value);
                },
              )
            : SizedBox.shrink(),
      ]),
    );
  }
}
