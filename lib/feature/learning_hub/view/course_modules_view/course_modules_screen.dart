import 'package:di360_flutter/feature/learning_hub/view/course_modules_view/section_content_view.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseModulesScreen extends StatelessWidget {
  const CourseModulesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Course")),
      body: Consumer<CourseListingViewModel>(
        builder: (context, provider, _) {
          return Column(
            children: [
              /// 🔹 MODULE LIST
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: provider.courseDetails?.moduleSection?.length,
                  itemBuilder: (context, moduleIndex) {
                    final module =
                        provider.courseDetails?.moduleSection?[moduleIndex];

                    if (module == null) return SizedBox.shrink();

                    return ExpansionTile(
                      title: Text(
                        module.moduleName ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      initiallyExpanded:
                          moduleIndex == provider.currentModuleIndex,
                      children: module.sectionList?.asMap().entries.map((entry) {
                        int sectionIndex = entry.key;
                        final section = entry.value;

                        bool isActive =
                            moduleIndex == provider.currentModuleIndex &&
                                sectionIndex == provider.currentSectionIndex;

                        return ListTile(
                          title: Text(section.courseTopic ?? ''),
                          // leading: Icon(
                          //   section.isCompleted
                          //       ? Icons.check_circle
                          //       : Icons.radio_button_unchecked,
                          //   color: section.isCompleted
                          //       ? Colors.green
                          //       : Colors.grey,
                          // ),
                          selected: isActive,
                          selectedTileColor: Colors.blue.withOpacity(0.1),
                          onTap: () {
                            provider.setCurrent(moduleIndex, sectionIndex);
                          },
                        );
                      }).toList() ?? [],
                    );
                  },
                ),
              ),

              Divider(height: 1),

              /// 🔹 CONTENT VIEW
              Expanded(
                flex: 3,
                child: SectionContentView(),
              ),
            ],
          );
        },
      ),
    );
  }
}
