import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/add_directory_document_card.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart' as picker;




class AddDirectorDocument extends StatefulWidget {
  const AddDirectorDocument({super.key});

  @override
  State<AddDirectorDocument> createState() => _AddDirectorDocumentState();
}

class _AddDirectorDocumentState extends State<AddDirectorDocument>
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
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sectionHeader('Documents'),
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

            if (showForm) _buildDocumentForm(addDirectorVM),

            const Divider(thickness: 2),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: addDirectorVM.Documents.length,
              itemBuilder: (context, index) {
                final doc = addDirectorVM.Documents[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AddDirectoryDocumentCard(
                    title: doc.name,
                    imageFile: doc.imageFile,
                    document: doc,
                    index: index,
                    onDelete: () {
                      setState(() {
                        addDirectorVM.Documents.removeAt(index);
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

  Widget _buildDocumentForm(AddDirectorViewModel addDirectorVM) {
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
            hintText: "Enter Document Name",
            title: "Document Name",
            controller: addDirectorVM.DocumentNameController,
            isRequired: true,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter document name'
                : null,
          ),
          const SizedBox(height: 16),
          ImagePickerInputField(
            title: 'Attachment',
            isRequired: true,
            imageFile: addDirectorVM.documentFile,
            onTap: () => _imagePickerSelection(
              context,
              () =>
                  addDirectorVM. pickDocumentsImage(picker.ImageSource.gallery),
              () =>
                  addDirectorVM. pickDocumentsImage(picker.ImageSource.camera),
            ),
            hintText: 'JPEG, PNG, PDF formats, up to 5 MB',
          ),
          const SizedBox(height: 20),
          CustomBottomButton(
            onFirst: () {
              setState(() {
                showForm = false;
              });
            },
            onSecond: () {
              addDirectorVM.addDocument();
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
