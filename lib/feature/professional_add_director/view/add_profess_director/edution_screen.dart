import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/add_directors/view/add_director_view.dart';
import 'package:di360_flutter/feature/add_directors/view_model/add_director_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addDirectorVM = Provider.of<AddDirectorViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          sectionHeader('Education'),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: addDirectorVM.getBasicInfoData.first.education?.length,
            itemBuilder: (context, index) {
              final education =
                  addDirectorVM.getBasicInfoData.first.education?[index];
              return Text(education?.name ?? '', style: TextStyles.bold5());
            },
          ),
          SizedBox(height: 20),
          sectionHeader('Work Experience'),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: addDirectorVM.getBasicInfoData.first.workingAt?.length,
            itemBuilder: (context, index) {
              final work = addDirectorVM.getBasicInfoData.first.workingAt?[index];
              return Text(work?.name ?? '', style: TextStyles.bold5());
            },
          )
        ]),
      ),
    );
  }
}
