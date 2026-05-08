import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/learning_hub/view/course_modules_view/Quiz_section_widget.dart';
import 'package:di360_flutter/feature/learning_hub/view/course_modules_view/module_section_widget.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.borderColor,
      appBar: AppBarWidget(
        searchWidget: false,
        logo: false,
        title: "Course Details",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: AppColors.whiteColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<CourseListingViewModel>(
                  builder: (_, vm, __) => _headerTitle(vm.courseDetails?.courseName ?? ''),
                ),
                const ModuleSectionWidget(),
                const QuizSectionWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerTitle(String title) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Container(width: 4, height: 40, color: AppColors.primaryColor),
              const SizedBox(width: 12),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const Text("A Comprehensive Guide",
                      style: TextStyle(color: Colors.grey)),
                ],
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
