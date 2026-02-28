import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/add_directors/view_model/edit_delete_director_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSocialForm extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  final String? id;
  AddSocialForm({super.key, this.id});
  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
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
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Please Select Account';
              try {
                final socialList = addDirectorVM
                    .getBasicInfoData.first.directoryLocations
                    ?.firstWhere((v) => v.mediaName == value.toLowerCase());
                return socialList != null
                    ? 'This media account is already assigned. Please\n choose another.'
                    : null;
              } catch (e) {
                return null;
              }
            },
          ),
          addVertical(16),
          InputTextField(
              title: "Social Accounts URL",
              isRequired: true,
              hintText: "Paste/enter link",
              keyboardType: TextInputType.emailAddress,
              controller: addDirectorVM.socialAccountsurlCntr,
              validator: validateOptionalUrl),
          addVertical(20),
          AppButton(
            text: editVM.isEditSocialMed ? 'Update' : 'Add',
            onTap: () async {
              if (addDirectorVM.selectedAccount == null) {
                showTopMessage(context, 'Please select account');
              } else if (addDirectorVM.socialAccountsurlCntr.text.isEmpty) {
                showTopMessage(context, 'Please enter URL');
              } else {
                final urlError = validateOptionalUrl(addDirectorVM.socialAccountsurlCntr.text);
                if (urlError != null) {
                  showTopMessage(context, urlError);
                } else {
                  try {
                    final socialList = addDirectorVM
                        .getBasicInfoData.first.directoryLocations
                        ?.firstWhere((v) => v.mediaName == addDirectorVM.selectedAccount!.toLowerCase());
                    if (socialList != null) {
                      showTopMessage(context, 'This media account is already assigned. Please choose another.');
                      return;
                    }
                  } catch (e) {}
                  editVM.isEditSocialMed
                      ? editVM.updateTheSocialurl(context, id ?? '')
                      : addDirectorVM.addSocialUrls(context);
                }
              }
            },
          )
        ],
      ),
    );
  }
}
