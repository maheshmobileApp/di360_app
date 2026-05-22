import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view/course_modules_view/module_section_widget.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view/course_modules_view/quiz_screen.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseDetailsView extends StatefulWidget {
  const CourseDetailsView({super.key});

  @override
  State<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<CourseDetailsView> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.borderColor,
      appBar: AppBarWidget(
          searchWidget: false, logo: false, title: "Course Details"),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: AppColors.whiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<MarketPlaceLearningHubViewModel>(
                  builder: (_, vm, __) =>
                      _headerTitle(vm.courseDetails?.courseName ?? ''),
                ),
                ModuleSectionWidget(scrollController: _scrollController),
                Consumer<MarketPlaceLearningHubViewModel>(
                  builder: (context, vm, _) {
                    final hasQuestions =
                        (vm.courseDetails?.quizDetails ?? []).isNotEmpty;
                    if (!hasQuestions) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14)),
                          onPressed: () {
                            if (!vm.areAllSectionsCompleted()) {
                              scaffoldMessenger(
                                  "Please complete all modules before taking the quiz.");
                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const QuizScreen()),
                            );
                            vm.retakeQuiz = false;
                          },
                          child: const Text("Take Quiz",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                      ),
                    );
                  },
                ),
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
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text("A Comprehensive Guide",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
