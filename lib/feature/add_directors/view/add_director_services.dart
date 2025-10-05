import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_bottom_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/menu_widget.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_details_res.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorService extends StatelessWidget with BaseContextHelpers {
  const AddDirectorService({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final editDeleteVM = Provider.of<EditDeleteDirectorViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sectionHeader('Add Service'),
                CustomAddButton(
                  label: 'Add +',
                  onPressed: () {
                    showNewServiceBottomSheet(context, '');
                  },
                ),
              ],
            ),
            addVertical(16),
            ...addDirectorVM.getBasicInfoData.first.directoryServices
                    ?.asMap()
                    .entries
                    .map((entry) {
                  final service = entry.value;
                  return _ServiceCard(
                      context, service, addDirectorVM, editDeleteVM);
                }).toList() ??
                [],
          ],
        ),
      ),
    );
  }

  Widget _ServiceCard(BuildContext context, DirectoryServices service,
      AddDirectoryViewModel addDirectorVM, EditDeleteDirectorViewModel vm) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardcolor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.buttomBarColor,
              child:
                  CachedNetworkImageWidget(imageUrl: service.image?.url ?? '')),
          addHorizontal(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name ?? '',
                  style: TextStyles.bold3(color: AppColors.black),
                ),
                addVertical(8),
                Text(
                  service.description ?? '',
                  style: TextStyles.medium2(color: Colors.grey.shade800),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          MenuWidget(
            onSelected: (val) {
              if (val == 'Edit') {
                addDirectorVM.serviceNameController.text = service.name ?? '';
                addDirectorVM
                    .toggleService(service.showInAppointments ?? false);
                addDirectorVM.updateIsEditService(true);
                addDirectorVM.serviceDescController.text =
                    service.description ?? '';
                showNewServiceBottomSheet(context, service.id ?? '');
              } else if (val == 'Delete') {
                vm.deleteTheServices(context, service.id ?? '');
              }
            },
          )
        ],
      ),
    );
  }

  void showNewServiceBottomSheet(BuildContext context, String editId) {
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
        // return DraggableScrollableSheet(
        //   initialChildSize: 0.59,
        //   maxChildSize: 0.59,
        //   minChildSize: 0.5,
        //   expand: false,
        //   builder: (context, scrollController) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AddDirectorServicesFoam(editId: editId),
                    ],
                  ),
                ),
              ),
            );
        //   },
        // );
      },
    );
  }
}

class AddDirectorServicesFoam extends StatelessWidget with BaseContextHelpers {
  final String editId;
  AddDirectorServicesFoam({super.key, required this.editId});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final vm = Provider.of<EditDeleteDirectorViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        addVertical(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sectionHeader(
                addDirectorVM.isEditService ? 'Update Service' : "New Service"),
            InkWell(
                onTap: () => navigationService.goBack(),
                child: Icon(Icons.close, color: AppColors.black))
          ],
        ),
        addVertical(20),
        InputTextField(
          hintText: "Enter Service Name",
          title: "Service Name",
          controller: addDirectorVM.serviceNameController,
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
            _radioButton("Yes", true, addDirectorVM.serviceShowApmt,
                (_) => addDirectorVM.toggleService(true)),
            _radioButton("No", false, addDirectorVM.serviceShowApmt,
                (_) => addDirectorVM.toggleService(false)),
          ],
        ),
        addVertical(20),
        InputTextField(
          hintText: "Enter your text here",
          controller: addDirectorVM.serviceDescController,
          maxLength: 500,
          maxLines: 5,
          title: "Short Description",
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter description'
              : null,
        ),
        CustomBottomButton(
            onFirst: () {
              addDirectorVM.serviceNameController.clear();
              addDirectorVM.toggleService(false);
              addDirectorVM.serviceDescController.clear();
              navigationService.goBack();
            },
            onSecond: () {
              if (addDirectorVM.serviceNameController.text.isNotEmpty) {
                addDirectorVM.isEditService
                    ? vm.updateTheServices(context, editId)
                    : addDirectorVM.addService(context);
                navigationService.goBack();
              } else {
                showTopMessage(context, 'Please enter service name');
              }
            },
            firstLabel: "Close",
            secondLabel: addDirectorVM.isEditService ? 'Update' : "Add",
            firstBgColor: AppColors.timeBgColor,
            firstTextColor: AppColors.primaryColor,
            secondBgColor: AppColors.primaryColor,
            secondTextColor: AppColors.whiteColor)
      ]),
    );
  }

  Widget _radioButton(String label, bool value, bool groupValue,
      ValueChanged<bool?> onChanged) {
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
}
