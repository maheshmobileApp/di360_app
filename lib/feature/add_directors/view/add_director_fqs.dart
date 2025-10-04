import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/close_add_button_widget.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/feature/directors/model_class/get_directories_details_res.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorFqs extends StatelessWidget with BaseContextHelpers {
  const AddDirectorFqs({super.key});

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
                sectionHeader("Add FAQ's"),
                CustomAddButton(
                    label: 'Add +',
                    onPressed: () {
                      showFAQSBottomSheet(context, addDirectorVM, editVM, '');
                    }),
              ],
            ),
            addVertical(16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  addDirectorVM.getBasicInfoData.first.directoryFaqs?.length,
              itemBuilder: (context, index) {
                final data =
                    addDirectorVM.getBasicInfoData.first.directoryFaqs?[index];
                return _faqItem(context, addDirectorVM, data, editVM);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _faqItem(BuildContext context, AddDirectoryViewModel addDirectorVM,
      DirectoryFaqs? data, EditDeleteDirectorViewModel editVM) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade100),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                    childrenPadding: const EdgeInsets.fromLTRB(20, 0, 16, 12),
                    title: Text(
                      data?.question ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("• ", style: TextStyle(fontSize: 16)),
                          Expanded(
                            child: Text(
                              data?.answer ?? '',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            menuWidget(context, addDirectorVM, data, editVM)
          ],
        ),
      ),
    );
  }

  void showFAQSBottomSheet(
      BuildContext context,
      AddDirectoryViewModel addDirectorVM,
      EditDeleteDirectorViewModel editVM,
      String? id) {
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
        // return DraggableScrollableSheet(
        //   initialChildSize: 0.50,
        //   maxChildSize: 0.50,
        //   minChildSize: 0.5,
        //   expand: false,
        //   builder: (context, scrollController) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24))),
                    child: SafeArea(
                      top: false,
                      child: Column(
                        children: [
                          addfaqsWidget(addDirectorVM),
                          CloseAddButtonWidget(
                            closeBtn: () {
                              navigationService.goBack();
                              editVM.updateIsEditFAQ(false);
                            },
                            addBtn: () {
                              if (_formKey.currentState!.validate()) {
                                editVM.isEditFAQ
                                    ? editVM.updateTheFAQ(context, id ?? '')
                                    : addDirectorVM.addFAQs(context);
                                navigationService.goBack();
                              }
                            },
                            btnText: editVM.isEditFAQ ? 'Update' : 'Add',
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
        //   },
        // );
      },
    );
  }

  Widget addfaqsWidget(AddDirectoryViewModel addDirectorVM) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      child: Column(
        children: [
          addVertical(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sectionHeader("Faq's"),
              InkWell(
                  onTap: () => navigationService.goBack(),
                  child: Icon(Icons.close, color: AppColors.black))
            ],
          ),
          addVertical(10),
          InputTextField(
              hintText: "Enter question",
              title: " Question ",
              controller: addDirectorVM.questionCntr,
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter  question'
                  : null),
          addVertical(20),
          InputTextField(
              hintText: "Enter answer",
              maxLength: 500,
              maxLines: 5,
              title: "Answer",
              controller: addDirectorVM.answerCntr,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter  answer' : null),
        ],
      ),
    );
  }

  Widget menuWidget(BuildContext context, AddDirectoryViewModel addDirectorVM,
      DirectoryFaqs? data, EditDeleteDirectorViewModel editVM) {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.all(0),
      onSelected: (value) {
        if (value == "Edit") {
          addDirectorVM.questionCntr.text = data?.question ?? '';
          addDirectorVM.answerCntr.text = data?.answer ?? '';
          editVM.updateIsEditFAQ(true);
          showFAQSBottomSheet(context, addDirectorVM, editVM, data?.id);
        } else if (value == "Delete") {
          editVM.deleteTheFAQ(context, data?.id ?? '');
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
            value: "Edit",
            child: _buildRow(Icons.edit_outlined, AppColors.blueColor, "Edit")),
        PopupMenuItem(
            value: "Delete",
            child:
                _buildRow(Icons.delete_outline, AppColors.redColor, "Delete")),
      ],
    );
  }

  Widget _buildRow(IconData? icon, Color? color, String? title) {
    return Row(children: [
      Icon(icon, color: color),
      addHorizontal(8),
      Text(title ?? '', style: TextStyles.semiBold(fontSize: 14, color: color))
    ]);
  }
}
