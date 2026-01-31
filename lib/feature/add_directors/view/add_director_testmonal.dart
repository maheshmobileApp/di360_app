import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/close_add_button_widget.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/feature/add_directors/widgets/menu_widget.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_details_res.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'package:provider/provider.dart';

class AddDirectorTestmonal extends StatelessWidget with BaseContextHelpers {
  const AddDirectorTestmonal({super.key});
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
                sectionHeader('Add New Testimonials'),
                CustomAddButton(
                  label: 'Add +',
                  onPressed: () {
                    addDirectorVM.testiNameCntr.clear();
                    addDirectorVM.roleCntr.clear();
                    addDirectorVM.messageCntr.clear();
                    showTestimonialBottomSheet(context, addDirectorVM, editVM);
                  },
                ),
              ],
            ),
            addVertical(16),
            _testimonialCard(addDirectorVM, context, editVM),
          ],
        ),
      ),
    );
  }

  Widget _testimonialCard(AddDirectoryViewModel addDirectorVM,
      BuildContext context, EditDeleteDirectorViewModel editVM) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
            children: addDirectorVM.getBasicInfoData.first.directoryTestimonials
                    ?.map((data) => Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      (data.message == '' ||
                                              data.message == null)
                                          ? CachedNetworkImageWidget(
                                              imageUrl: data.msgPic?.url ?? '',
                                              height: 100,
                                              width: 150,
                                              fit: BoxFit.fill)
                                          : Expanded(
                                              child: Text(
                                                data.message ?? '',
                                                textAlign: TextAlign.center,
                                                style: TextStyles.medium3(
                                                    color: Colors.white),
                                              ),
                                            ),
                                      Spacer(),
                                      MenuWidget(onSelected: (val) {
                                        if (val == 'Edit') {
                                          addDirectorVM.testiNameCntr.text =
                                              data.name ?? '';
                                          addDirectorVM.roleCntr.text =
                                              data.role ?? '';
                                          addDirectorVM.messageCntr.text =
                                              data.message ?? '';
                                          editVM.updateIsEditTestimonials(true);
                                          showTestimonialBottomSheet(
                                              context, addDirectorVM, editVM,
                                              data: data);
                                        } else if (val == 'Delete') {
                                          editVM.deleteTheTestimonial(
                                              context, data.id ?? '');
                                        }
                                      })
                                    ],
                                  ),
                                  addVertical(16),
                                  Row(children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.orange,
                                      radius: 23,
                                      child: CircleAvatar(
                                        radius: 22,
                                        child: ClipOval(
                                          child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: CachedNetworkImageWidget(
                                                imageUrl:
                                                    data.profileImage?.url ??
                                                        '',
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      ),
                                    ),
                                    addHorizontal(8),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.name ?? '',
                                            style: TextStyles.bold1(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          addVertical(8),
                                          Text(
                                            data.role ?? '',
                                            style: TextStyles.bold1(
                                                color: Colors.white,
                                                fontSize: 12),
                                          )
                                        ])
                                  ])
                                ]))))
                    .toList() ??
                []));
  }

  void showTestimonialBottomSheet(BuildContext context,
      AddDirectoryViewModel addDirectorVM, EditDeleteDirectorViewModel editVM,
      {DirectoryTestimonials? data}) {
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Form(
          key: _formKey,
          child: SizedBox(
            height: getSize(context).height * 0.8,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: testimonialsWidget(addDirectorVM, context,
                              imgUrl: data?.profileImage?.url,
                              picUrl: data?.msgPic?.url),
                        ),
                        CloseAddButtonWidget(
                          closeBtn: () {
                            editVM.updateIsEditTestimonials(false);
                            navigationService.goBack();
                          },
                          addBtn: () {
                            if (_formKey.currentState!.validate() &&
                                validationImageAndPicture(addDirectorVM, context,
                                    data?.profileImage?.url, data?.msgPic?.url)) {
                              editVM.isEditTestimonal
                                  ? editVM.updateTheTestimonial(
                                      context,
                                      data?.id ?? '',
                                      data?.profileImage?.toJson(),
                                      data?.msgPic?.toJson())
                                  : addDirectorVM.addTestimonials(context);
                              navigationService.goBack();
                            }
                          },
                          btnText: editVM.isEditTestimonal ? 'Update' : 'Add',
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

  Widget testimonialsWidget(
      AddDirectoryViewModel addDirectorVM, BuildContext context,
      {String? imgUrl, String? picUrl}) {
    return Column(
      children: [
        addVertical(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sectionHeader('Testimonials'),
            InkWell(
                onTap: () => navigationService.goBack(),
                child: Icon(Icons.close, color: AppColors.black))
          ],
        ),
        addVertical(10),
        InputTextField(
          hintText: "Enter name",
          title: " Name ",
          controller: addDirectorVM.testiNameCntr,
          isRequired: true,
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter  name' : null,
        ),
        addVertical(20),
        InputTextField(
          hintText: "Enter role",
          title: " Role ",
          controller: addDirectorVM.roleCntr,
          //isRequired: true,
          /*validator: (value) =>
              value == null || value.isEmpty ? 'Please enter  role' : null,*/
        ),
        addVertical(20),
        ImagePickerInputField(
          title: 'Image ',
          //isRequired: true,
          imageFile: addDirectorVM.testimonialsFile,
          onTap: () => imagePickerSelection(
              context,
              () => addDirectorVM
                  .pickTestimonialImage(picker.ImageSource.gallery),
              () => addDirectorVM
                  .pickTestimonialImage(picker.ImageSource.camera)),
          hintText: imgUrl ?? 'JPEG, PNG up to 5 MB',
        ),
        addVertical(20),
        InputTextField(
            hintText: "Enter message",
            maxLength: 500,
            maxLines: 5,
            title: "Message",
            controller: addDirectorVM.messageCntr),
        addVertical(10),
        Center(
            child: Text('OR',
                style: TextStyles.clashBold(), textAlign: TextAlign.center)),
        addVertical(20),
        ImagePickerInputField(
          title: 'Picture ',
          imageFile: addDirectorVM.testimonialsPicFile,
          onTap: () => imagePickerSelection(
              context,
              () => addDirectorVM
                  .pickTestimonialPicture(picker.ImageSource.gallery),
              () => addDirectorVM
                  .pickTestimonialPicture(picker.ImageSource.camera)),
          hintText: picUrl ?? 'JPEG, PNG up to 5 MB',
        ),
      ],
    );
  }

  bool validationImageAndPicture(AddDirectoryViewModel addDirectorVM,
      BuildContext context, dynamic img, dynamic msgPic) {
    // Check if name is provided
    if (addDirectorVM.testiNameCntr.text.isEmpty) {
      showTopMessage(context, 'Please enter name');
      return false;
    }
    
    // Check if either message or picture is provided
    bool hasMessage = addDirectorVM.messageCntr.text.isNotEmpty;
    bool hasPicture = (addDirectorVM.testimonialsPicFile != null && 
                      addDirectorVM.testimonialsPicFile!.path.isNotEmpty) || 
                     msgPic != null;
    
    if (!hasMessage && !hasPicture) {
      showTopMessage(context, 'Please add either a message or a picture');
      return false;
    }
    
    return true;
  }
}
