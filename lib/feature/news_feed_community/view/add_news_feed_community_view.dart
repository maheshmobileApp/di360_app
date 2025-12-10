import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';

import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/news_feed_community/view_model/news_feed_community_view_model.dart';
import 'package:di360_flutter/feature/news_feed_community/widgets/upload_file_widget.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewsFeedCommunityView extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  AddNewsFeedCommunityView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsFeedCommunityViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppbarTitleBackIconWidget(
          title: viewModel.isEditNewsFeed == true
              ? 'Edit NewsFeed'
              : 'Add NewsFeed',
          backAction: () {
            navigationService.goBack();
            //viewModel.clearFeedNews();
          }),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVertical(16),
                InputTextField(
                  controller: viewModel.descriptionController,
                  hintText: "Enter your Description",
                  title: "Description",
                  maxLength: 1000,
                  maxLines: 4,
                  isRequired: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Description'
                      : null,
                ),
                addVertical(16),
                _buildCategoryTypes(viewModel),
                addVertical(16),
                UploadFileWidget(),
                addVertical(16),
                InputTextField(
                  controller: viewModel.videoLinkController,
                  hintText: "Enter Video URL",
                  title: "Video URL",
                  maxLength: 100,
                  validator: validateOptionalUrl,
                ),
                addVertical(16),
                InputTextField(
                  controller: viewModel.websiteLinkController,
                  hintText: "Enter Website URL",
                  title: "Website URL",
                  maxLength: 100,
                  validator: validateOptionalUrl,
                ),
                addVertical(30),
                AppButton(
                    height: 50,
                    text: viewModel.isEditNewsFeed == true ? 'Update' : 'Add',
                    onTap: () {
                      (viewModel.isEditNewsFeed == true)
                          ? viewModel.updateNewsFeedCommunity(context)
                          : viewModel.addNewsFeed(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTypes(NewsFeedCommunityViewModel jobCreateVM) {
    return CustomDropDown(
      isRequired: true,
      value: jobCreateVM.selectedCategory,
      title: "Category",
      onChanged: (v) {
        if (jobCreateVM.newsFeedCategory.isEmpty) {
          scaffoldMessenger('Create category');
          return;
        }
        jobCreateVM.setSelectedNewsFeedCategory(v as String);
      },
      items: jobCreateVM.newsFeedCategory
          .map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Category",
      validator: (value) => value == null || value.toString().isEmpty
          ? 'Please select category'
          : null,
    );
  }

  Widget richText(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyles.medium4(color: AppColors.black),
        children: [
          TextSpan(
            text: ' *',
            style: TextStyle(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
