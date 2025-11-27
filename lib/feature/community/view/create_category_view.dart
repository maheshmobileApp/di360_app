import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/community/view_model/community_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCategoryView extends StatefulWidget {
  @override
  _CreateCategoryViewState createState() => _CreateCategoryViewState();
}

class _CreateCategoryViewState extends State<CreateCategoryView>
    with ValidationMixins {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommunityViewModel>(context);
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBarWidget(
          title: "Partnership Registration",
          searchWidget: false,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Category',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                InputTextField(
                  controller: viewModel.categoryController,
                  hintText: "Enter Category Name",
                  title: "Category",
                  maxLength: 100,
                  isRequired: true,
                  validator: validateCategoryName,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: AppButton(
                        height: 42,
                        text: (viewModel.editMode) ? "Update" : "Add",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                           (viewModel.editMode) ?await viewModel.updateCategory(viewModel.editCategoryId): await viewModel.addCategory();
                            navigationService.goBack();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                        child: CustomRoundedButton(
                      fontSize: 16,
                      backgroundColor: AppColors.timeBgColor,
                      textColor: AppColors.primaryColor,
                      text: 'Cancel',
                      height: 42,
                      width: 160,
                      onPressed: () {
                        viewModel.categoryController.text = "";
                        navigationService.goBack();
                      },
                    )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
