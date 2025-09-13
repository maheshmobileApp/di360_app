import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/close_add_button_widget.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/add_directors/widgets/image_picker_widget.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'package:provider/provider.dart';

class AddDirectorTestmonal extends StatelessWidget with BaseContextHelpers {
  const AddDirectorTestmonal({super.key});
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
                sectionHeader('Add New Testimonials'),
                CustomAddButton(
                  label: 'Add +',
                  onPressed: () {
                    showTestimonialBottomSheet(context, addDirectorVM);
                  },
                ),
              ],
            ),
            addVertical(16),
            _SocialLinkCard(),
          ],
        ),
      ),
    );
  }

  Widget _SocialLinkCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Facebook',
                  style: TextStyles.semiBold(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'facebook.com/dentalinterface360',
                  style: TextStyles.regular1(
                    fontSize: 12,
                    color: AppColors.bottomBarSelectIconColor,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.more_vert,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  void showTestimonialBottomSheet(
      BuildContext context, AddDirectorViewModel addDirectorVM) {
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.95,
          maxChildSize: 0.95,
          minChildSize: 0.6,
          expand: false,
          builder: (context, scrollController) {
            return Form(
              key: _formKey,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: testimonialsWidget(addDirectorVM, context),
                        ),
                      ),
                      CloseAddButtonWidget(
                        addBtn: () {
                          if (_formKey.currentState!.validate() &&
                              validationImageAndPicture(
                                  addDirectorVM, context)) {
                            addDirectorVM.addTestimonials(context);
                            navigationService.goBack();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget testimonialsWidget(
      AddDirectorViewModel addDirectorVM, BuildContext context) {
    return Column(
      children: [
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
          isRequired: true,
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter  role' : null,
        ),
        addVertical(20),
        ImagePickerInputField(
          title: 'Image ',
          isRequired: true,
          imageFile: addDirectorVM.testimonialsFile,
          onTap: () => imagePickerSelection(
              context,
              () => addDirectorVM
                  .pickTestimonialImage(picker.ImageSource.gallery),
              () => addDirectorVM
                  .pickTestimonialImage(picker.ImageSource.camera)),
          hintText: 'JPEG, PNG, PDF formats, up to 5 MB',
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
          hintText: 'JPEG, PNG, PDF formats, up to 5 MB',
        ),
      ],
    );
  }

  bool validationImageAndPicture(
      AddDirectorViewModel addDirectorVM, BuildContext context) {
    if (addDirectorVM.testimonialsFile == null) {
      showTopMessage(context, 'Select image');
      return false;
    }
    if (addDirectorVM.testimonialsPicFile != null &&
        addDirectorVM.messageCntr.text.isNotEmpty) {
      showTopMessage(
          context, 'Please add either a message or a picture, not both');

      return false;
    }
    if (addDirectorVM.testimonialsPicFile == null &&
        addDirectorVM.messageCntr.text.isEmpty) {
      showTopMessage(
          context, 'Please add either a message or a picture, only one');
      return false;
    }
    return true;
  }
}
