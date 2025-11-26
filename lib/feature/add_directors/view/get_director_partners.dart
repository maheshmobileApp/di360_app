import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view/add_partners.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/menu_widget.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetDirectorPartners extends StatelessWidget with BaseContextHelpers {
  const GetDirectorPartners({super.key});

  @override
  Widget build(BuildContext context) {
    final editVM = Provider.of<EditDeleteDirectorViewModel>(context);
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sectionHeader('Add Partners'),
              CustomAddButton(
                label: 'Add +',
                onPressed: () {
                  editVM.selectedFiles.clear();
                  editVM.existingImages.clear();
                  showNewPartnerBottomSheet(context, editVM);
                },
              ),
            ],
          ),
          _getPartnersCard(context, editVM, addDirectorVM)
        ]),
      ),
    );
  }

  Widget _getPartnersCard(BuildContext context,
      EditDeleteDirectorViewModel editVM, AddDirectoryViewModel addDirectorVM) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: editVM.partnersList?.length,
      itemBuilder: (context, index) {
        final partnerData = editVM.partnersList?[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
              color: AppColors.cardcolor,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Stack(children: [
                CachedNetworkImageWidget(
                    imageUrl: partnerData?.image?.url ?? ''),
                Positioned(
                    right: 2,
                    top: 2,
                    child: CircleAvatar(
                      backgroundColor: AppColors.whiteColor,
                      child: MenuWidget(onSelected: (val) {
                        if (val == 'Edit') {
                          addDirectorVM.partnerNameCntr.text =
                              partnerData?.name ?? '';
                          addDirectorVM.descriptionCntr.text =
                              partnerData?.description ?? '';
                          editVM.selectedFiles.clear();
                          editVM.existingImages.clear();
                          editVM.existingImages =
                              partnerData?.attachments ?? [];
                          showNewPartnerBottomSheet(context, editVM,
                              hintText: partnerData?.image?.name,
                              id: partnerData?.id,
                              imag: partnerData?.image?.toJson());
                          editVM.updateIsEditPartner(true);
                        } else if (val == 'Delete') {
                          editVM.deletePartner(context, partnerData?.id ?? '');
                        }
                      }),
                    ))
              ]),
              addVertical(10),
              Text(
                partnerData?.name ?? '',
                style: TextStyles.bold4(color: AppColors.primaryColor),
              )
            ],
          ),
        );
      },
    );
  }

  void showNewPartnerBottomSheet(
      BuildContext context, EditDeleteDirectorViewModel editVM,
      {String? hintText, String? id, dynamic imag}) {
    final addDirectorVM =
        Provider.of<AddDirectoryViewModel>(context, listen: false);
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      showDragHandle: false,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SizedBox(
          height: getSize(context).height * 0.74,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.buttomBarColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24))),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        AddPartners(hintText: hintText),
                        CustomBottomButton(
                          onFirst: () {
                            editVM.updateIsEditPartner(false);
                            navigationService.goBack();
                          },
                          onSecond: () {
                            if (_formKey.currentState!.validate()) {
                              if (addDirectorVM.partnerImgFile?.path.isEmpty ??
                                  false || imag == null) {
                                showTopMessage(context, 'Select image');
                              } else {
                                editVM.isEditPartner
                                    ? editVM.updatePartner(
                                        context, id ?? '', imag)
                                    : editVM.addPartners(context);
                                navigationService.goBack();
                              }
                            }
                          },
                          firstLabel: "Close",
                          secondLabel: editVM.isEditPartner ? 'Update' : "Add",
                          firstBgColor: AppColors.timeBgColor,
                          firstTextColor: AppColors.primaryColor,
                          secondBgColor: AppColors.primaryColor,
                          secondTextColor: AppColors.whiteColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
