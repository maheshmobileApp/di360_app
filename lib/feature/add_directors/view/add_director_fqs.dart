import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/widgets/close_add_button_widget.dart';
import 'package:di360_flutter/feature/add_directors/widgets/custom_add_button.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDirectorFqs extends StatelessWidget with BaseContextHelpers {
  const AddDirectorFqs({super.key});

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
                sectionHeader("Add FAQ's"),
                CustomAddButton(
                  label: 'Add +',
                  onPressed: () {
                    showFAQSBottomSheet(context, addDirectorVM);
                  },
                ),
              ],
            ),
            addVertical(16),
            ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: addDirectorVM.faqsList.length,
                          itemBuilder: (context, index) {
            final data = addDirectorVM.faqsList[index];
            return _faqItem(data.question, data.answer);
                          },
                        )
          ],
        ),
      ),
    );
  }

  Widget _faqItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100,
        ),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 12),
            childrenPadding: const EdgeInsets.fromLTRB(20, 0, 16, 12),
            title: Text(
              question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text(
                      answer,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showFAQSBottomSheet(
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
          initialChildSize: 0.55,
          maxChildSize: 0.55,
          minChildSize: 0.4,
          expand: false,
          builder: (context, scrollController) {
            return Form(
              key: _formKey,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24))),
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: addfaqsWidget(addDirectorVM),
                        ),
                      ),
                      CloseAddButtonWidget(
                        addBtn: () {
                          if (_formKey.currentState!.validate()) {
                            addDirectorVM.addFAQs(context);
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

  Widget addfaqsWidget(AddDirectorViewModel addDirectorVM) {
    return Column(
      children: [
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
    );
  }
}
