import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/add_directory_certificate_card.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);
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
                  label: showForm ? 'Cancel' : 'Add +',
                  onPressed: () {
                    setState(() {
                      showForm = !showForm;
                    });
                  },
                ),
              ],
            ),
            if (showForm) _buildCertificateForm(addDirectorVM),
            const Divider(thickness: 2),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: addDirectorVM.certificateList.length,
              itemBuilder: (context, index) {
                final cert = addDirectorVM.certificateList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AddDirectoryCertificateCard(
                    title: cert.name,
                    imageFile: cert.imageFile,
                    certificate: cert,
                    index: index,
                    onDelete: () {
                      setState(() {
                        addDirectorVM.certificateList.removeAt(index);
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

  Widget _buildCertificateForm(AddDirectorViewModel addDirectorVM) {
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
            hintText: 'JPEG, PNG, PDF formats, up to 5 MB',
          ),
          addVertical(20),
          CustomBottomButton(
            onFirst: () {
              setState(() {
                showForm = false;
              });
            },
            onSecond: () {
              addDirectorVM.addCertificates(context);
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
}
