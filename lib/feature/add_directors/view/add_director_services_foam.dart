import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart' as picker;

class AddDirectorServicesFoam extends StatelessWidget with BaseContextHelpers {
  @override
  Widget build(
    BuildContext context,
  ) {
    final AddDirectorVM = Provider.of<AddDirectorViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        _sectionHeader("New Service"),
        addVertical(6),
        InputTextField(
          hintText: "Enter Service Name",
          title: "Service Name",
          controller: AddDirectorVM.ServiceNameController,
          isRequired: true,
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter service name'
              : null,
         ),
        addVertical(16),
        Text("Service show in appointments", style: TextStyles.regular2()),
        addVertical(6),
        Row(
          children: [
            _radioButton("Yes", true, AddDirectorVM.Service,
                (_) => AddDirectorVM.toggleService(true)),
            _radioButton("No", false, AddDirectorVM.Service,
                (_) => AddDirectorVM.toggleService(false)),
          ],
        ),
        if (AddDirectorVM.Service) ...[
        addVertical(12),
        ImagePickerInputField(
          title: 'Service Image/Icon',
          isRequired: true,
          imageFile: AddDirectorVM.serviefile,
          onTap: () => _imagePickerSelection(
            context,
            () => AddDirectorVM. pickServicerImage(picker.ImageSource.gallery),
            () => AddDirectorVM. pickServicerImage(picker.ImageSource.camera),
          ),
          hintText: 'JPEG, PNG, PDF formats, up to 5 MB',
        ),
        ],
         addVertical(20),
           InputTextField(
          hintText: "Enter your text here",
           controller: AddDirectorVM.ServiceDescriptionController,
           maxLength: 500,
           maxLines: 5,
          title: "Short Description",
        ), 
      ]),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _radioButton(
  String label,
  bool value,
  bool groupValue,
  ValueChanged<bool?> onChanged,
) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Radio<bool>(
        visualDensity: VisualDensity.compact,
        value: value,
        groupValue: groupValue,
        activeColor: AppColors.buttonColor, 
        onChanged: onChanged,
      ),
      Text(label, style: TextStyles.regular2()),
      SizedBox(width: 20),
    ],
  );
}

  void _imagePickerSelection(
    BuildContext context,
    VoidCallback? galleryOnTap,
    VoidCallback? cameraOnTap,
  ) {
    showModalBottomSheet(
      context: context,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading:  Icon(Icons.photo_library),
              title:Text('Gallery'),
              onTap: galleryOnTap,
            ),
            ListTile(
              leading:  Icon(Icons.camera_alt),
              title:  Text('Camera'),
              onTap: cameraOnTap,
            ),
          ],
        );
      },
    );
  }
}