import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSocialForm extends StatelessWidget with BaseContextHelpers {
  final String? id;
  AddSocialForm({super.key,this.id});
  
  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);
    final editVM = Provider.of<EditDeleteDirectorViewModel>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          socialUrlsWidget(addDirectorVM, context, editVM)
        ],
      ),
    );
  }

  Widget socialUrlsWidget(AddDirectorViewModel addDirectorVM,
      BuildContext context, EditDeleteDirectorViewModel editVM) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      sectionHeader("Add social links"),
      addVertical(12),
      CustomDropDown<String>(
        title: 'Account',
        hintText: 'Select Account',
        isRequired: true,
        value: addDirectorVM.selectedAccount,
        items: ConstantData.AccountList.map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            )).toList(),
        onChanged: (val) {
          addDirectorVM.selectedAccount = val;
        },
        validator: (value) =>
            value == null || value.isEmpty ? 'Please Select Account' : null,
      ),
      addVertical(16),
      InputTextField(
        title: "Social Accounts URL",
        hintText: "Paste/enter link",
        keyboardType: TextInputType.emailAddress,
        controller: addDirectorVM.socialAccountsurlCntr,
        validator: (value) =>
            value == null || value.isEmpty ? 'Please select urls' : null,
      ),
      addVertical(20),
      AppButton(
        text: editVM.isEditSocialMed ? 'Update' : 'Add',
        onTap: () {
          if (addDirectorVM.selectedAccount == null &&
              addDirectorVM.socialAccountsurlCntr.text.isEmpty) {
            showTopMessage(context, 'select socail account & account url');
          } else {
            editVM.isEditSocialMed ?
            editVM.updateTheSocialurl(context, id ?? '') :
            addDirectorVM.addSocialUrls(context);
            navigationService.goBack();
          }
        },
      )
    ]);
  }
}
