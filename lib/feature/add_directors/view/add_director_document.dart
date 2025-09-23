import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/add_directory_document_card.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AddDirectorDocument extends StatefulWidget {
  const AddDirectorDocument({super.key});

  @override
  State<AddDirectorDocument> createState() => _AddDirectorDocumentState();
}

class _AddDirectorDocumentState extends State<AddDirectorDocument>
    with BaseContextHelpers {
  bool showForm = false;
  String? docName = '';
  String docEditId = '';
  dynamic img;
  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final editVM = Provider.of<EditDeleteDirectorViewModel>(context);
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
                sectionHeader('Documents'),
                CustomAddButton(
                  label: showForm ? 'Cancel' : 'Add +',
                  onPressed: () {
                    setState(() {
                      addDirectorVM.documentNameController.clear();
                      docName = null;
                      showForm = !showForm;
                    });
                  },
                ),
              ],
            ),
            if (showForm) _buildDocumentForm(addDirectorVM, editVM),
            Divider(thickness: 2),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: addDirectorVM
                  .getBasicInfoData.first.directoryDocuments?.length,
              itemBuilder: (context, index) {
                final doc = addDirectorVM
                    .getBasicInfoData.first.directoryDocuments?[index];
                return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AddDirectoryDocumentCard(
                        title: doc?.name ?? '',
                        imageFile: doc?.attachment?.url,
                        onSelected: (val) async {
                          if (val == 'Edit') {
                            addDirectorVM.documentNameController.text =
                                doc?.name ?? '';
                            setState(() {
                              showForm = true;
                              docEditId = doc?.id ?? '';
                              docName = doc?.attachment?.name;
                              img = doc?.attachment?.toJson();
                            });
                            editVM.updateIsEditDocu(true);
                          } else if (val == 'Delete') {
                            editVM.deleteTheDocument(context, doc?.id ?? '');
                          } else if (val == 'Download') {
                            if (await canLaunchUrl(
                                Uri.parse(doc?.attachment?.url ?? ''))) {
                              await launchUrl(
                                  Uri.parse(doc?.attachment?.url ?? ''),
                                  mode: LaunchMode.externalApplication);
                            }
                          }
                        }));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentForm(
      AddDirectoryViewModel addDirectorVM, EditDeleteDirectorViewModel editVM) {
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
            controller: addDirectorVM.documentNameController,
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
            onTap: () => imagePickerSelection(
                context,
                () => addDirectorVM.pickDocumentsImage(),
                () => addDirectorVM.pickDocumentsImage()),
            hintText: docName ?? 'JPEG, PNG, PDF formats, up to 5 MB',
          ),
          const SizedBox(height: 20),
          CustomBottomButton(
            onFirst: () {
              editVM.updateIsEditDocu(false);
              setState(() {
                showForm = false;
              });
            },
            onSecond: () {
              if (addDirectorVM.documentNameController.text.isEmpty) {
                scaffoldMessenger('Enter document name');
              } else if (addDirectorVM.documentFile?.path.isEmpty ??
                  false || img == null) {
                scaffoldMessenger('Enter attachement');
              } else {
                editVM.isEditDocu
                    ? editVM.updateTheDocu(context, docEditId, img)
                    : addDirectorVM.addDocument(context);
                setState(() {
                  showForm = false;
                });
              }
            },
            firstLabel: "Close",
            secondLabel: editVM.isEditDocu ? 'Update' : "Add",
            firstBgColor: AppColors.timeBgColor,
            firstTextColor: AppColors.primaryColor,
            secondBgColor: AppColors.primaryColor,
            secondTextColor: AppColors.whiteColor,
          ),
        ],
      ),
    );
  }
}
