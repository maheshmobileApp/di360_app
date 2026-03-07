import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:di360_flutter/feature/professional_add_director/view_model/professional_add_director_vm.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EducationScreen extends StatelessWidget with BaseContextHelpers {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectoryViewModel>(context);
    final professDirectorVM = Provider.of<ProfessionalAddDirectorVm>(context);

    if (addDirectorVM.getBasicInfoData.isEmpty) {
      return Center(child: Text('No data available'));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          sectionHeader('Education'),
          InputTextField(
              title: '',
              hintText: 'Add Education',
              controller: professDirectorVM.educationCntr,
              onSubmitted: (val) {
                professDirectorVM.addEducation(val ?? '');
              }),
          if (professDirectorVM.getEducation.isNotEmpty) ...[
            addVertical(10),
            Consumer<AddDirectoryViewModel>(
                builder: (context, addDirectorV, child) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(professDirectorVM.getEducation.length,
                    (index) {
                  final educaion = professDirectorVM.getEducation[index];
                  return Chip(
                    label: Text(educaion.name ?? ''),
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () {
                      professDirectorVM.removeEducation(index);
                    },
                  );
                }),
              );
            }),
          ],
          addVertical(20),
          sectionHeader('Work Experience'),
          InputTextField(
              title: '',
              hintText: 'Add work experience',
              controller: professDirectorVM.workAtCntr,
              onSubmitted: (val) {
                professDirectorVM.addWorkAt(val ?? '');
              }),
          if (professDirectorVM.getWorkingAt.isNotEmpty) ...[
            addVertical(10),
            Consumer<AddDirectoryViewModel>(
                builder: (context, addDirectorV, child) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(professDirectorVM.getWorkingAt.length,
                    (index) {
                  final work = professDirectorVM.getWorkingAt[index];
                  return Chip(
                      label: Text(work),
                      deleteIcon: Icon(Icons.close),
                      onDeleted: () {
                        professDirectorVM.removeWorkAt(index);
                      });
                }),
              );
            }),
          ]
        ]),
      ),
    );
  }
}
