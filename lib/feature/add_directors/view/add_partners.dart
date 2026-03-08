import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/director_partner_multi_images_widget.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/feature/learning_hub/widgets/radio_button_group.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart' as picker;

// ignore: must_be_immutable
class AddPartners extends StatefulWidget {
  final String? hintText;
  dynamic fileName;
   AddPartners({super.key, this.hintText,this.fileName});

  @override
  State<AddPartners> createState() => _AddPartnersState();
}

class _AddPartnersState extends State<AddPartners> with BaseContextHelpers {
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
          onTap: () {
            imagePickerSelection(
            context,
            () => AddDirectorVM.pickPartnerImage(picker.ImageSource.gallery),
            () => AddDirectorVM.pickPartnerImage(picker.ImageSource.camera),
          );
          setState(() {
            widget.fileName = null;
          });
          },
          hintText: widget.hintText ?? 'Choose an image',
        ),
        if (AddDirectorVM.partnerImgFile != null) ...[
          addVertical(10),
          Align(
            alignment: Alignment.centerLeft,
            child: Stack(children: [
              Image.file(AddDirectorVM.partnerImgFile!, width: 90, height: 70),
              Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          AddDirectorVM.partnerImgFile = null;
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: Icon(Icons.close,
                              color: Colors.white, size: 16))))
            ]),
          )
        ],
        if (widget.fileName != null) ...[
          addVertical(10),
          Align(
            alignment: Alignment.centerLeft,
            child: Stack(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImageWidget(
                      imageUrl: widget.fileName['url'] ?? '',
                      width: 90,
                      height: 70)),
              Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.fileName = null;
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close,
                              color: Colors.white, size: 16))))
            ]),
          )
        ],
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
