import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/banners/model/get_category_list.dart';
import 'package:di360_flutter/feature/banners/view_model/banners_view_model.dart';
import 'package:di360_flutter/feature/banners/widgets/banners_schedule_date.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/image_picker_field.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBannersScreen extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  AddBannersScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bannersVM = Provider.of<BannersViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () => navigationService.goBack(),
            child: const Icon(Icons.arrow_back_ios, color: AppColors.black)),
        title: Text('Add Banners',
            style: TextStyles.medium2(color: AppColors.black)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                     _buildCategoryTypes(bannersVM),
                    // InputTextField(
                    //   title: 'Banner Name',
                    //   isRequired: true,
                    //   hintText: 'Enter Banner Name',
                    //   controller: bannersVM.bannerNameController,
                    //   validator: validateBannerName,
                    // ),
                    addVertical(15),
                    InputTextField(
                      title: 'Banner Name',
                      isRequired: true,
                      hintText: 'Enter Banner Name',
                      controller: bannersVM.bannerNameController,
                      validator: validateBannerName,
                    ),
                    addVertical(15),
                    ImagePickerField(
                      title: "Banner Image",
                      isRequired: true,
                      showPreview: true,
                      selectedFile: bannersVM.selectedPresentedImg,
                      onFilePicked: (file) => bannersVM.setPresentedImg(file),
                    ),
                    addVertical(15),
                    InputTextField(
                      title: 'URL',
                      isRequired: true,
                      hintText: 'Enter URL',
                      controller: bannersVM.urlController,
                      validator: validateUrl,
                    ),
                    addVertical(15),
                    BannersScheduleExpiryPage(),
                    addVertical(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppButton(
                            text: 'Save as Draft',
                            height: 42,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState?.save();
                              }
                            },
                          ),
                        ),
                        addHorizontal(20),
                        Expanded(
                          child: AppButton(
                              text: 'Send for Approval',
                              height: 42,
                              onTap: () {
                                if (formKey.currentState!.validate()) {}
                              }),
                        )
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

  // CustomDropDown(
  //                     isRequired: true,
  //                     value: addCataloguVM.selectedCatagory,
  //                     title: "Category",
  //                     onChanged: (v) {
  //                       addCataloguVM
  //                           .updateSelectedCatagory(v as CatalogueCategories?);
  //                     },
  //                     items: addCataloguVM.catagorysList
  //                             ?.map<DropdownMenuItem<CatalogueCategories>>(
  //                                 (CatalogueCategories value) {
  //                           return DropdownMenuItem<CatalogueCategories>(
  //                             value: value,
  //                             child: Text(value.name ?? ''),
  //                           );
  //                         }).toList() ??
  //                         [],
  //                     hintText: "Select category",
  //                     validator: (value) =>
  //                         value == null || value.toString().isEmpty
  //                             ? 'Please select category'
  //                             : null,
  //                   ),
  Widget _buildCategoryTypes(BannersViewModel bannersVM) {
    return CustomDropDown(
      isRequired: true,
      value: bannersVM.selectedCatagory,
      title: "Category",
      onChanged: (v) {
        bannersVM.updateSelectedCatagory(v as BannerCategories);
      },
      items: bannersVM.catagorysList?.map<DropdownMenuItem<BannerCategories>>(
              (BannerCategories value) {
            return DropdownMenuItem<BannerCategories>(
              value: value,
              child: Text(value.name ?? ''),
            );
          }).toList() ??
          [],
      hintText: "Select Category",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select category'
          : null,
    );
  }
}
