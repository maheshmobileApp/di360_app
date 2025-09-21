import 'package:di360_flutter/common/constants/app_colors.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          sectionHeader('Education'),
          addVertical(20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: addDirectorVM.getBasicInfoData.first.education?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InputTextField(
                          hintText: "Enter education",
                          title: "Education",
                          controller: professDirectorVM.educationCntr[index],
                          onChange: (value) =>
                              professDirectorVM.updateEducation(context, index, value)),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: AppColors.redColor),
                      onPressed: () =>
                          professDirectorVM.removeEducation(context, index),
                    )
                  ],
                ),
              );
            },
          ),
          addVertical(10),
          ElevatedButton.icon(
            onPressed: () => professDirectorVM.addEducation(context),
            icon: const Icon(Icons.add),
            label: const Text("Add Education"),
          ),
          addVertical(20),
          sectionHeader('Work Experience'),
          addVertical(20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: addDirectorVM.getBasicInfoData.first.workingAt?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InputTextField(
                          hintText: "Enter work",
                          title: "Work At",
                          controller: professDirectorVM.workAtCntr[index],
                          onChange: (value) =>
                              professDirectorVM.updateWorkAt(context, index, value)),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: AppColors.redColor),
                      onPressed: () =>
                          professDirectorVM.removeWorkAt(context, index),
                    )
                  ],
                ),
              );
            },
          ),
          addVertical(10),
          ElevatedButton.icon(
            onPressed: () => professDirectorVM.addWorkAt(context),
            icon: const Icon(Icons.add),
            label: const Text("Add Work"),
          ),
        ]),
      ),
    );
  }
}
