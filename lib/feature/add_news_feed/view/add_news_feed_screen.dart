import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_news_feed/add_news_feed_view_model/add_news_feed_view_model.dart';
import 'package:di360_flutter/feature/add_news_feed/model_class/get_categories.dart';
import 'package:di360_flutter/feature/add_news_feed/view/upload_file_preview.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewsFeedScreen extends StatelessWidget
    with BaseContextHelpers, ValidationMixins {
  AddNewsFeedScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AddNewsFeedViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              navigationService.goBack();
              viewModel.clearFeedNews();
            },
            child: Icon(Icons.arrow_back)),
        title: Text(viewModel.isEditNewsFeed == true ?
          'Edit NewsFeed' : 'Add NewsFeed',
          style: TextStyles.bold4(color: AppColors.whiteColor),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVertical(20),
                richText('Description'),
                addVertical(10),
                TextFormField(
                  controller: viewModel.desController,
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter your Description',
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.redAccent),
                  ),
                  validator: validateDesc,
                ),
                addVertical(20),
                richText('Select Category'),
                addVertical(10),
                DropdownButtonFormField<NewsfeedCategories>(
                  decoration: InputDecoration(
                    hintText: 'Select Category',
                    border: OutlineInputBorder(),
                  ),
                  value: viewModel.selectedCategory,
                  items: viewModel.newsfeedCategories?.map((v) {
                    return DropdownMenuItem<NewsfeedCategories>(
                      value: v,
                      child: Text(v.categoryName ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    viewModel.setSelectedCategory(value);
                  },
                  validator: (value) => validateCategory(value?.categoryName),
                ),
                addVertical(20),
                FileUploadWidget(),
                addVertical(20),
                Text('Enter Video Link',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                addVertical(8),
                TextFormField(
                  controller: viewModel.videoController,
                  decoration: InputDecoration(
                    hintText: 'Enter Video URL',
                    border: OutlineInputBorder(),
                  ),
                  validator: validateOptionalUrl,
                ),
                addVertical(20),
                Text('Enter Website Link',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                addVertical(8),
                TextFormField(
                  controller: viewModel.websiteController,
                  decoration: InputDecoration(
                    hintText: 'Enter Website URL',
                    border: OutlineInputBorder(),
                  ),
                  //  validator: validateOptionalUrl,
                ),
                addVertical(30),
                AppButton(
                    text: 'Add',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (viewModel.selectedCategory == null) {
                          scaffoldMessenger('Please select category');
                        } else {
                          viewModel.addNewsFeeds(context);
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
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
