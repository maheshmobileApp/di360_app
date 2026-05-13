import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view/course_modules_view/test_result_dialog.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.borderColor,
      appBar: AppBarWidget(searchWidget: false, logo: false, title: "Quiz"),
      body: Consumer<MarketPlaceLearningHubViewModel>(
        builder: (context, vm, _) {
          final questions = vm.courseDetails?.questionSection ?? [];
          if (questions.isEmpty) {
            return const Center(child: Text("No questions available."));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final q = questions[index];
                    return Card(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 4,
                                    height: 30,
                                    color: AppColors.primaryColor),
                                const SizedBox(width: 10),
                                Text(
                                  "Question ${index + 1} of ${questions.length}",
                                  style: const TextStyle(
                                      color: AppColors.whiteColor),
                                ),
                              ],
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(height: 8),
                            Text(
                              'Q${index + 1}.  ${q.question?.toUpperCase() ?? ''}',
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            ...List.generate(q.options?.length ?? 0, (i) {
                              final option = q.options![i];
                              if (q.questionType == 'single') {
                                final selected = vm.quizAnswers[index];
                                return RadioListTile<int>(
                                  value: i,
                                  groupValue:
                                      selected is int ? selected : null,
                                  onChanged: (val) {
                                    if (!vm.areAllSectionsCompleted()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Please complete all modules before taking the quiz."),
                                      ));
                                      return;
                                    }
                                    vm.updateQuizAnswer(index, val!);
                                  },
                                  title: Text(option.text ?? '',
                                      style: const TextStyle(
                                          color: AppColors.whiteColor)),
                                  activeColor: AppColors.primaryColor,
                                );
                              } else {
                                final selected =
                                    vm.quizAnswers[index] as Set<int>? ?? {};
                                return CheckboxListTile(
                                  value: selected.contains(i),
                                  onChanged: (_) {
                                    if (!vm.areAllSectionsCompleted()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Please complete all modules before taking the quiz."),
                                      ));
                                      return;
                                    }
                                    final current = Set<int>.from(
                                        vm.quizAnswers[index] as Set<int>? ??
                                            {});
                                    current.contains(i)
                                        ? current.remove(i)
                                        : current.add(i);
                                    vm.updateQuizAnswer(index, current);
                                  },
                                  title: Text(option.text ?? '',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  activeColor: AppColors.primaryColor,
                                  checkColor: AppColors.black,
                                );
                              }
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: AppButton(
                  text: "Submit Quiz",
                  onTap: () {
                    if (!vm.areAllSectionsCompleted()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Please complete all modules before taking the quiz."),
                      ));
                      return;
                    }
                    final result = vm.submitQuiz();
                    if (result == null) return;
                    final passPercentage = double.tryParse(
                            vm.courseDetails?.passPercentage?.toString() ??
                                '0') ??
                        0;
                    showTestResultDialog(
                        context, result.$1, result.$2, passPercentage);
                  },
                  radius: 10,
                  height: 48,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
