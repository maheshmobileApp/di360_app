import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/course_details_response.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view/course_modules_view/test_result_dialog.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/view_model/market_place_learning_hub_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
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
          final questions = vm.courseDetails?.quizDetails ?? [];
          if (questions.isEmpty) {
            return const Center(child: Text("No questions available."));
          }

          final registeredUser =
              vm.courseDetails?.courseRegisteredUsers?.firstOrNull;
          final isCompleted =
              registeredUser?.quizStatus == 'COMPLETED' && !vm.retakeQuiz;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final quiz = questions[index];
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
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          quiz.type == 'single'
                                              ? 'MCQ'
                                              : quiz.type == 'multiple'
                                                  ? 'MULTI SELECT'
                                                  : 'T/F',
                                          style: TextStyles.medium1(
                                              color: AppColors.whiteColor))),
                                )
                              ],
                            ),
                            const Divider(color: Colors.grey),
                            const SizedBox(height: 8),
                            Text(
                              'Q${index + 1}.  ${quiz.question?.toUpperCase() ?? ''}',
                              style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            if (isCompleted)
                              _buildReviewOptions(
                                  quiz, registeredUser, vm.courseDetails)
                            else
                              _buildInteractiveOptions(
                                  context, vm, quiz, index),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (!isCompleted)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: AppButton(
                      text: "Submit Quiz",
                      onTap: () {
                        if (!vm.areAllSectionsCompleted()) {
                          scaffoldMessenger(
                              "Please complete all modules before taking the quiz.");
                          return;
                        }
                        // validate all answered + multiple min 2
                        for (int i = 0; i < questions.length; i++) {
                          final quiz = questions[i];
                          final answer = vm.quizAnswers[i];
                          if (answer == null ||
                              (answer is Set && answer.isEmpty)) {
                            scaffoldMessenger(
                                "Please answer question ${i + 1}.");
                            return;
                          }
                          if (quiz.type == 'multiple') {
                            final sel = answer as Set<int>;
                            if (sel.length < 2) {
                              scaffoldMessenger(
                                  "Question ${i + 1}: select at least 2 options.");
                              return;
                            }
                          }
                        }

                        // build & print payload
                        final payload = List.generate(questions.length, (i) {
                          final quiz = questions[i];
                          final answer = vm.quizAnswers[i];
                          List<String> selectedOptionIds;
                          if (quiz.type == 'single' || quiz.type == 'boolean') {
                            final optionIndex = answer as int;
                            selectedOptionIds = [
                              quiz.optionDetails![optionIndex].id ?? ''
                            ];
                          } else {
                            final indices = answer as Set<int>;
                            selectedOptionIds = indices
                                .map((idx) => quiz.optionDetails![idx].id ?? '')
                                .toList();
                          }
                          return {
                            'question_id': quiz.id ?? '',
                            'selected_option_ids': selectedOptionIds,
                          };
                        });
                        debugPrint(payload.toString());

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
                      height: 48),
                ),
              if (isCompleted)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Row(children: [
                    Expanded(
                        child: AppButton(
                            text: 'cancel',
                            onTap: () => navigationService.goBack(),
                            btnColor: Colors.grey,
                            height: 40,
                            radius: 8)),
                    SizedBox(width: 20),
                    Expanded(
                        child: AppButton(
                            text: 'Take Quiz Again',
                            onTap: () {
                              vm.resetQuiz();
                            },
                            height: 40,
                            radius: 8))
                  ]),
                )
            ],
          );
        },
      ),
    );
  }

  Widget _buildReviewOptions(QuizDetails quizDetails,
      CourseDetailRegisteredUsers? registeredUser, CoursesByPk? courseDetails) {
    /// USER ANSWERS
    final userAnswer = registeredUser?.quizAnswers?.firstWhere(
      (a) => a.questionId == quizDetails.id,
      orElse: () => QuizAnswers(),
    );

    final selectedIds = userAnswer?.selectedOptionIds ?? [];

    /// QUIZ DETAIL
    final quizDetail = courseDetails?.quizDetails?.firstWhere(
      (e) => e.quizId == quizDetails.quizId,
      orElse: () => QuizDetails(),
    );

    return Column(
      children: List.generate(quizDetails.optionDetails?.length ?? 0, (i) {
        final option = quizDetails.optionDetails![i];

        /// FIND MATCHED OPTION FROM quiz_details
        final matchedQuizOption = quizDetail?.optionDetails?.firstWhere(
          (e) => e.optionPosition == option.optionPosition,
          orElse: () => OptionDetails(),
        );

        /// CHECK USER SELECTED
        final isSelected = selectedIds.contains(matchedQuizOption?.id);

        /// CORRECT ANSWER
        final isCorrect = matchedQuizOption?.isCorrect == true;

        /// STATES
        final isUserCorrect = isSelected && isCorrect;

        final isUserWrong = isSelected && !isCorrect;

        final isMissedCorrect = !isSelected && isCorrect;

        Color bgColor;
        Color borderColor;
        IconData iconData;

        if (isUserCorrect) {
          bgColor = Colors.green.shade800;
          borderColor = Colors.green;
          iconData = Icons.check_circle;
        } else if (isUserWrong) {
          bgColor = Colors.red.shade900;
          borderColor = Colors.red;
          iconData = Icons.cancel;
        } else if (isMissedCorrect) {
          bgColor = Colors.green.shade900;
          borderColor = Colors.green;
          iconData = Icons.check_circle_outline;
        } else {
          bgColor = Colors.grey.shade900;
          borderColor = Colors.transparent;
          iconData = Icons.radio_button_unchecked;
        }

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
              width: 1.5,
            ),
          ),
          child: ListTile(
            dense: true,
            leading: Icon(
              iconData,
              color:
                  borderColor == Colors.transparent ? Colors.grey : borderColor,
              size: 22,
            ),
            title: Text(
              option.text ?? '',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        );
      }),
    );
  }

  /// Interactive mode for unanswered quiz
  Widget _buildInteractiveOptions(BuildContext context,
      MarketPlaceLearningHubViewModel vm, QuizDetails quiz, int index) {
    return Column(
      children: List.generate(quiz.optionDetails?.length ?? 0, (i) {
        final option = quiz.optionDetails![i];

        // boolean & single → RadioListTile (single selection)
        if (quiz.type == 'single' || quiz.type == 'boolean') {
          final selected = vm.quizAnswers[index];
          return RadioListTile<int>(
            value: i,
            groupValue: selected is int ? selected : null,
            onChanged: (val) {
              if (!vm.areAllSectionsCompleted()) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      "Please complete all modules before taking the quiz."),
                ));
                return;
              }
              vm.updateQuizAnswer(index, val!);
            },
            title: Text(option.text ?? '',
                style: const TextStyle(color: AppColors.whiteColor)),
            activeColor: AppColors.primaryColor,
          );
        } else {
          // multiple → CheckboxListTile (min 2, max 3)
          final selected = vm.quizAnswers[index] as Set<int>? ?? {};
          return CheckboxListTile(
              value: selected.contains(i),
              onChanged: (_) {
                if (!vm.areAllSectionsCompleted()) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Please complete all modules before taking the quiz."),
                  ));
                  return;
                }
                final current =
                    Set<int>.from(vm.quizAnswers[index] as Set<int>? ?? {});
                if (current.contains(i)) {
                  current.remove(i);
                } else {
                  if (current.length >= 3) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("You can select a maximum of 3 options."),
                    ));
                    return;
                  }
                  current.add(i);
                }
                vm.updateQuizAnswer(index, current);
              },
              title: Text(option.text ?? '',
                  style: const TextStyle(color: Colors.white)),
              activeColor: AppColors.primaryColor,
              checkColor: AppColors.black);
        }
      }),
    );
  }
}
