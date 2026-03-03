import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:di360_flutter/widgets/image_picker_field.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';

class PresentersWidget extends StatelessWidget with BaseContextHelpers {
  final NewCourseViewModel viewModel;

  const PresentersWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...viewModel.presenters.asMap().entries.map((entry) {
          final index = entry.key;
          final presenter = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index > 0) Divider(thickness: 1),
              if (index > 0) SizedBox(height: 8),
              InputTextField(
                controller: presenter.presenterNameController,
                hintText: "Enter Presenter Name",
                title: "Presented By (Name)",
                maxLength: 75,
                isRequired: true,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Presenter name'
                    : null,
              ),
              SizedBox(height: 8),
              ImagePickerField(
                title: "Presented By (Image)",
                isRequired: true,
                serverImage: presenter.serverPresenterImage,
                serverImageType: "image",
                onServerFileRemoved: (value) {
                  viewModel.setPresenterImage(index, null);
                },
                showPreview: true,
                selectedFile: presenter.presenterImage,
                onFilePicked: (file) =>
                    viewModel.setPresenterImage(index, file),
              ),
              SizedBox(height: 8),
              if (index > 0)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => viewModel.removePresenter(index),
                    child: Text("Remove Presenter",
                        style: TextStyle(color: Colors.red)),
                  ),
                ),
            ],
          );
        }).toList(),
        Align(
          alignment: Alignment.centerRight,
          child: IntrinsicWidth(
            stepWidth: 40,
            child: AppButton(
              onTap: () {
                final lastPresenter = viewModel.presenters.last;
                if (lastPresenter.presenterNameController.text.isEmpty ||
                    (lastPresenter.presenterImage == null &&
                        lastPresenter.serverPresenterImage == null)) {
                  scaffoldMessenger(
                      "Please fill current presenter details before adding another.");
                  return;
                }
                viewModel.addPresenter();
              },
              text: "Add Another Presenter",
              height: 40.0,
              radius: 2,
            ),
          ),
        ),
      ],
    );
  }
}
