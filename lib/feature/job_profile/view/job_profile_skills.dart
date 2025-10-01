import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_profile/view/add_documents_dialog.dart';
import 'package:di360_flutter/feature/job_profile/view/add_education_dialog.dart';
import 'package:di360_flutter/feature/job_profile/view/add_experience_dialog.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_multi_select_dropdown.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_create_view_model.dart';
import 'package:di360_flutter/feature/job_profile/widgets/add_section_button.dart';
import 'package:di360_flutter/feature/job_profile/widgets/chip_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobProfileSkills extends StatelessWidget with BaseContextHelpers {
  const JobProfileSkills({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProfileVM = Provider.of<JobProfileCreateViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Skills"),
           addVertical(16),
              Text("Languages Spoken",  
              style: TextStyles.regular3(color: AppColors.black),),
              addVertical( 8),
            ChipTextField(
              chips: jobProfileVM.languages,
              hintText: "Enter multiple languages",
              onChanged: (chips) {
              },
            ),
              addVertical(16),
              Text("Areas of Expertise",
               style: TextStyles.regular3(color: AppColors.black),
               ),
              addVertical(8),
            ChipTextField(
              chips: jobProfileVM.expertise,
              hintText: "Enter areas of expertise",
              onChanged: (chips) {
              },),

            addVertical(16),
            Text(
              "Skills",
              style: TextStyles.regular3(color: AppColors.black),
            ),
            addVertical(4),
            _buildSkills(jobProfileVM),
            addVertical(24),
            _buildSectionRow(
              title: "Experience",
              button: AddSectionButton(
                label: "Add Experience",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        AddExperienceDialog(jobProfileVM: jobProfileVM),
                  );
                },
              ),
            ),
            addVertical(16),
            Consumer<JobProfileCreateViewModel>(
              builder: (context, vm, _) => _uploadedExperience(vm, context),
            ),
            addVertical(24),
            _buildSectionRow(
              title: "Education",
              button: AddSectionButton(
                label: "Add Education",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        AddEducationDialog(jobProfileVM: jobProfileVM),
                  );
                },
              ),
            ),
            addVertical(16),
            Consumer<JobProfileCreateViewModel>(
              builder: (context, vm, _) => _uploadedEducation(vm, context),
            ),
            addVertical(24),
            _buildSectionRow(
              title: "Documents",
              button: AddSectionButton(
                label: "Add Documents",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        AddDocumentsDialog(jobProfileVM: jobProfileVM),
                  );
                },
              ),
            ),
            addVertical(16),
            Consumer<JobProfileCreateViewModel>(
              builder: (context, vm, _) => _uploadedDocuments(vm),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionRow({required String title, required Widget button}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _sectionHeader(title),
        ),
        button,
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
     style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }

  Widget _buildSkills(JobProfileCreateViewModel jobProfileVM) {
    return CustomMultiSelectDropDown<String>(
      items: jobProfileVM.skillsList,
      selectedItems: jobProfileVM.selectskills,
      itemLabel: (item) => item,
      hintText: "Select skills",
      onSelectionChanged: (selected) {
        jobProfileVM.setSelectedSkills(selected);
      },
    );
  }

  Widget _uploadedDocuments(JobProfileCreateViewModel vm) {
    if (vm.documents.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: vm.documents.entries.map((entry) {
        final title = entry.key;
        final file = entry.value;
        if (file == null) return const SizedBox.shrink();
        final fileName = file.path.split('/').last;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title:",
                style: TextStyles.bold2(color: AppColors.black),
              ),
              addVertical(6),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.geryColor),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf,
                        color: AppColors.buttonColor),
                    addHorizontal(8),
                    Expanded(
                      child: Text(fileName,
                          style: TextStyles.bold2(color: AppColors.black),
                          overflow: TextOverflow.ellipsis),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.black),
                      onPressed: () => vm.removeDocument(title),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _uploadedEducation(
      JobProfileCreateViewModel vm, BuildContext context) {
    if (vm.educations.isEmpty) return const SizedBox.shrink();
    return Column(
      children: vm.educations.asMap().entries.map((entry) {
        final index = entry.key;
        final edu = entry.value;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Row(
              children: [
                if (edu.qualification.isNotEmpty)
                  Text(edu.qualification,
                      style: TextStyles.bold5(color: AppColors.black)),
                if (edu.qualification.isNotEmpty && edu.institution.isNotEmpty)
                  Text(" at ", style: TextStyles.bold5(color: AppColors.black)),
                if (edu.institution.isNotEmpty)
                  Text(edu.institution,
                      style: TextStyles.bold5(color: AppColors.blueColor)),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (edu.selectedQualification == "Yes" &&
                    (edu.finishDate?.isNotEmpty ?? false))
                  Text("Finished Date: ${edu.finishDate}",
                      style:
                          TextStyles.regular2(color: AppColors.lightGeryColor)),
                if (edu.selectedQualification == "No" &&
                    (edu.expectedFinishDate?.isNotEmpty ?? false))
                  Text("Expected Finish Date: ${edu.expectedFinishDate}",
                      style:
                          TextStyles.regular2(color: AppColors.lightGeryColor)),
                if (edu.courseHighlights.isNotEmpty) ...[
                  addVertical(6),
                  Text(edu.courseHighlights,
                      style:
                          TextStyles.regular2(color: AppColors.lightGeryColor)),
                ],
              ],
            ),
            trailing: _buildPopupMenu(
              onEdit: () {
                showDialog(
                  context: context,
                  builder: (context) => AddEducationDialog(
                    jobProfileVM: vm,
                    education: edu,
                    index: index,
                  ),
                );
              },
              onDelete: () => vm.removeEducation(index),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _uploadedExperience(
      JobProfileCreateViewModel vm, BuildContext context) {
    if (vm.experiences.isEmpty) return const SizedBox.shrink();
    return Column(
      children: vm.experiences.asMap().entries.map((entry) {
        final index = entry.key;
        final exp = entry.value;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: exp.jobTitle.isNotEmpty
                ? Text(exp.jobTitle,
                    style: TextStyles.bold5(color: AppColors.black))
                : null,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" at ", style: TextStyles.bold5(color: AppColors.black)),
                if (exp.company.isNotEmpty)
                  Text(exp.company,
                      style: TextStyles.bold5(color: AppColors.blueColor)),
                if (exp.startMonth != null && exp.startYear != null)
                  RichText(
                    text: TextSpan(
                      style: TextStyles.regular2(color: AppColors.geryColor),
                      children: [
                        if (exp.isStillWorking) ...[
                          TextSpan(
                            text:
                                "Started: ${exp.startMonth} ${exp.startYear} • ",
                          ),
                          TextSpan(
                            text: "(Still Working)",
                            style: TextStyles.bold2(color: AppColors.greenColor),
                          ),
                        ] else if (exp.endMonth != null &&
                            exp.endYear != null) ...[
                          TextSpan(
                            text:
                                "From: ${exp.startMonth} ${exp.startYear} to ${exp.endMonth} ${exp.endYear}",
                          ),
                        ] else ...[
                          TextSpan(
                            text: "From: ${exp.startMonth} ${exp.startYear}",
                          ),
                        ],
                      ],
                    ),
                  ),
                if (exp.description.isNotEmpty) ...[
                  addVertical(6),
                  Text(exp.description,
                      style: TextStyles.regular2(color: AppColors.geryColor)),
                ],
              ],
            ),
            trailing: _buildPopupMenu(
              onEdit: () {
                showDialog(
                  context: context,
                  builder: (context) => AddExperienceDialog(
                    jobProfileVM: vm,
                    experience: exp,
                    index: index,
                  ),
                );
              },
              onDelete: () => vm.removeExperience(index),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPopupMenu({
    required Function() onEdit,
    required Function() onDelete,
  }) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'edit') {
          onEdit();
        } else if (value == 'delete') {
          onDelete();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
            value: 'edit',
            child: Text(
              'Edit',
              style: TextStyles.regular3(color: AppColors.black),
            )),
        PopupMenuItem(
            value: 'delete',
            child: Text(
              'Delete',
              style: TextStyles.regular3(color: AppColors.black),
            )),
      ],
    );
  }
}
