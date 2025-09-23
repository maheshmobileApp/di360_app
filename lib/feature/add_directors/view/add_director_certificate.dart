import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/feature/add_directors/widgets/menu_widget.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart' as picker;

class AddDirectorCertificate extends StatefulWidget {
  const AddDirectorCertificate({super.key});

  @override
  State<AddDirectorCertificate> createState() => _AddDirectorCertificateState();
}

class _AddDirectorCertificateState extends State<AddDirectorCertificate>
    with BaseContextHelpers {
  bool showForm = false;
  String? fileName = '';
  String? editId = '';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sectionHeader('Certificates'),
                CustomAddButton(
                  label: 'Add +',
                  onPressed: () {
                    editVM.updateShowCertifiForm(false);
                    setState(() {
                      showForm = true;
                      addDirectorVM.certificateNameController.clear();
                      fileName = null;
                    });
                  },
                ),
              ],
            ),
            if (showForm) _buildCertificateForm(addDirectorVM, editVM),
            const Divider(thickness: 2),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: addDirectorVM
                  .getBasicInfoData.first.directoryCertifications?.length,
              itemBuilder: (context, index) {
                final cert = addDirectorVM
                    .getBasicInfoData.first.directoryCertifications?[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AddDirectoryCertificateCard(
                      title: cert?.title ?? '',
                      imageFile: cert?.attachments?.url,
                      onSelected: (val) {
                        if (val == 'Edit') {
                          addDirectorVM.certificateNameController.text =
                              cert?.title ?? '';
                          setState(() {
                            fileName = cert?.attachments?.name ?? '';
                            editId = cert?.id;
                            img = cert?.attachments?.toJson();
                            editVM.updateShowCertifiForm(true);
                            showForm = true;
                          });
                        } else if (val == 'Delete') {
                          editVM.deleteTheCertifi(context, cert?.id ?? '');
                        }
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificateForm(
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
            hintText: "Enter Certificate Name",
            title: "Certificate Name",
            controller: addDirectorVM.certificateNameController,
            isRequired: true,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter certificate name'
                : null,
          ),
          addVertical(16),
          ImagePickerInputField(
            title: 'Attachment',
            isRequired: true,
            imageFile: addDirectorVM.certificateFile,
            onTap: () => imagePickerSelection(
              context,
              () => addDirectorVM
                  .pickCertificateImage(picker.ImageSource.gallery),
              () =>
                  addDirectorVM.pickCertificateImage(picker.ImageSource.camera),
            ),
            hintText: fileName ?? 'JPEG, PNG, PDF formats, up to 5 MB',
          ),
          addVertical(20),
          CustomBottomButton(
            onFirst: () {
              editVM.updateShowCertifiForm(false);
              setState(() {
                showForm = false;
              });
            },
            onSecond: () {
              if (addDirectorVM.certificateNameController.text.isEmpty) {
                scaffoldMessenger('Enter certificate name');
              } else if (addDirectorVM.certificateFile?.path.isEmpty ??
                  false || img == null) {
                scaffoldMessenger('Enter attachement');
              } else {
                editVM.showCertifiForm
                    ? editVM.updateTheCertifi(context, editId ?? '', img)
                    : addDirectorVM.addCertificates(context);
                editVM.updateShowCertifiForm(false);
                setState(() {
                  showForm = false;
                });
              }
            },
            firstLabel: "Close",
            secondLabel: editVM.showCertifiForm ? 'Update' : "Add",
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

class AddDirectoryCertificateCard extends StatelessWidget {
  final String title;
  final String? imageFile;
  final Function(String)? onSelected;

  const AddDirectoryCertificateCard(
      {super.key, required this.title, this.imageFile, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardcolor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          if (imageFile != null) ...[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImageWidget(
                    imageUrl: imageFile ?? '', width: 50, height: 50)),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 10),
          MenuWidget(onSelected: onSelected)
        ],
      ),
    );
  }
}
