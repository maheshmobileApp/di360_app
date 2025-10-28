import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_catalogues/add_catalogue_view_model/add_catalogu_view_model.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/catagorys_res.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/get_catalogue_type_res.dart';
import 'package:di360_flutter/feature/add_catalogues/view/botted_border_widget.dart';
import 'package:di360_flutter/feature/add_catalogues/view/schedule_expiry_data_widget.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCatalogueScreen extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  AddCatalogueScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final addCataloguVM = Provider.of<AddCatalogueViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarTitleBackIconWidget(title: 'Add Catalogue'),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  children: [
                    CustomDropDown(
                      isRequired: true,
                      value: addCataloguVM.selectedCatalogueType,
                      title: "Type",
                      onChanged: (v) {
                        addCataloguVM
                            .updateSelectedCatalogueType(v as CatalogueTypes?);
                      },
                      items: addCataloguVM.catalogueTypesList
                              ?.map<DropdownMenuItem<CatalogueTypes>>(
                                  (CatalogueTypes value) {
                            return DropdownMenuItem<CatalogueTypes>(
                                value: value, child: Text(value.name ?? ''));
                          }).toList() ??
                          [],
                      hintText: "Select type",
                      validator: (value) =>
                          value == null || value.toString().isEmpty
                              ? 'Please select type'
                              : null,
                    ),
                    addVertical(15),
                    CustomDropDown(
                      isRequired: true,
                      value: addCataloguVM.selectedCatagory,
                      title: "Category",
                      onChanged: (v) {
                        addCataloguVM.updateSelectedCatagory(
                            v as CatalogueSubCategories?);
                      },
                      items: addCataloguVM.catagorysList
                              ?.map<DropdownMenuItem<CatalogueSubCategories>>(
                                  (CatalogueSubCategories value) {
                            return DropdownMenuItem<CatalogueSubCategories>(
                                value: value, child: Text(value.name ?? ''));
                          }).toList() ??
                          [],
                      hintText: "Select category",
                      validator: (value) =>
                          value == null || value.toString().isEmpty
                              ? 'Please select category'
                              : null,
                    ),
                    addVertical(15),
                    InputTextField(
                      title: 'Catalogue Name',
                      isRequired: true,
                      hintText: 'Enter Catalogue Name',
                      controller: addCataloguVM.catalogueNameController,
                      validator: validateCatagoryName,
                    ),
                    addVertical(15),
                    UploadSection(
                      sectionTitle: 'Thumbnail Image',
                      isRequired: true,
                      titleInsideBox: 'Click here to Choose a file.',
                      subTitleInsideBox:
                          '500 x 500 JPEG, PNG formats, up to 5 MB',
                      boxHeight: 160,
                      onTap: () {
                        addCataloguVM.thumbnailImage();
                      },
                    ),
                    addVertical(15),
                    UploadSection(
                      sectionTitle: 'Upload PDF ( Catalogue )',
                      isRequired: true,
                      titleInsideBox: 'PDF File, up to 50 MB',
                      subTitleInsideBox: '',
                      showTrailingIcon: true,
                      boxHeight: 40,
                      onTap: () {
                        addCataloguVM.uploadPdf();
                      },
                    ),
                    addVertical(15),
                    ScheduleExpiryPage(),
                    addVertical(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButton(
                            text: 'Save as Draft',
                            height: 43,
                            width: 150,
                            onTap: () {
                              if (formKey.currentState!.validate() &&
                                  validateURlAndData(addCataloguVM)) {
                                addCataloguVM.isEditCatalogue
                                    ? addCataloguVM.editCatalogueData(
                                        context, true)
                                    : addCataloguVM.addCatalogueData(
                                        context, true);
                              }
                            }),
                        AppButton(
                            text: 'Send for Approval',
                            height: 43,
                            width: 170,
                            onTap: () {
                              if (formKey.currentState!.validate() &&
                                  validateURlAndData(addCataloguVM)) {
                                addCataloguVM.isEditCatalogue
                                    ? addCataloguVM.editCatalogueData(
                                        context, false)
                                    : addCataloguVM.addCatalogueData(
                                        context, false);
                              }
                            })
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateURlAndData(AddCatalogueViewModel addCataloguVM) {
    if (addCataloguVM.thumbnailImagePath == null &&
        addCataloguVM.thumbnailServerPath == null) {
      scaffoldMessenger('Please select thumbnail image');
      return false;
    } else if (addCataloguVM.pdfPath == null) {
      scaffoldMessenger('Please select PDF');
      return false;
    } else if (addCataloguVM.scheduleDate == null) {
      scaffoldMessenger('Please select schedule date');
      return false;
    } else if (addCataloguVM.expiryDate == null) {
      scaffoldMessenger('Please select expiry date');
      return false;
    }
    return true;
  }
}
