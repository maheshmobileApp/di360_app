import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/banners/model/get_category_list.dart';
import 'package:di360_flutter/feature/banners/view_model/banners_view_model.dart';
import 'package:di360_flutter/feature/banners/widgets/banners_schedule_date.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/image_picker_field.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBannersScreen extends StatefulWidget {
  AddBannersScreen({super.key});

  @override
  State<AddBannersScreen> createState() => _AddBannersScreenState();
}

class _AddBannersScreenState extends State<AddBannersScreen>
    with BaseContextHelpers, ValidationMixins {
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
        title: Text(
            bannersVM.isRelistBanner
                ? 'Re-List Banner'
                : bannersVM.isEditBanner
                    ? 'Edit Banner'
                    : 'Add Banner',
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
                      serverImage: bannersVM.bannner_image,
                      selectedFile: bannersVM.selectedPresentedImg,
                      onFilePicked: (file) => bannersVM.setPresentedImg(file),
                      // selectedFiles: jobCreateVM.selectedGallery,
                      //  onFilesPicked: (file) => bannersVM.setPresentedImg(file),
                      // onFilePicked: (file) async {
                      //   final actualSize = await bannersVM.getImageSize(file!);
                      //   final requiredDim =
                      //       bannersVM.selectedCatagory?.dimensions;

                      //   final isValid =
                      //       bannersVM.checkDimensions(actualSize, requiredDim);

                      //   if (!isValid) {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(
                      //           content: Text(
                      //               "Invalid image size. Expected $requiredDim but got ${actualSize?.width.toInt()}x${actualSize?.height.toInt()}")),
                      //     );
                      //     return;
                      //   }

                      //   // valid → save in VM
                      //   bannersVM.setPresentedImg(file);
                      // },
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
                              if (formKey.currentState!.validate() &&
                                  validateURlAndData(bannersVM)) {
                                if (bannersVM.isEditBanner) {
                                  bannersVM.updateBannerData(context, false);
                                } else {
                                  bannersVM.addBannersData(context, false);
                                }
                              }
                            },
                          ),
                        ),
                        addHorizontal(20),
                        Expanded(
                          child: AppButton(
                              text: 'Send for Approval',
                              height: 42,
                              onTap: () async {
                                if (formKey.currentState!.validate() &&
                                    validateURlAndData(bannersVM)) {
                                  if (bannersVM.isEditBanner) {
                                    bannersVM.updateBannerData(context, false);
                                  } else {
                                    bannersVM.addBannersData(context, false);
                                  }
                                }
                                // if (formKey.currentState!.validate() &&
                                //     validateURlAndData(bannersVM)) {
                                //   bannersVM.isEditBanner
                                //       ? bannersVM.updateBannerData(
                                //           context, false)
                                //       : bannersVM.addBannersData(
                                //           context, false);
                                // }
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

  bool validateURlAndData(BannersViewModel bannerVm) {
    if (bannerVm.selectedPresentedImg != null || bannerVm.bannner_image == null) {
      scaffoldMessenger('Please select Banner image');
      return false;
    } else if (bannerVm.scheduleDate == null) {
      scaffoldMessenger('Please select schedule date');
      return false;
    } else if (bannerVm.expiryDate == null) {
      scaffoldMessenger('Please select expiry date');
      return false;
    }
    return true;
  }

  Widget _buildCategoryTypes(BannersViewModel bannersVM) {
    return CustomDropDown(
      isRequired: true,
      value: bannersVM.selectedCatagory,
      title: "Category",
      onChanged: (v) {
        bannersVM.updateSelectedCatagory(v as BannerCategories);
      },
      items: bannersVM.catagorysList
          .map<DropdownMenuItem<BannerCategories>>((BannerCategories value) {
        return DropdownMenuItem<BannerCategories>(
          value: value,
          child: Text(value.name ?? ''),
        );
      }).toList(),
      hintText: "Select Category",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select category'
          : null,
    );
  }
}
