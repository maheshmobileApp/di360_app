import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/learning_hub/view/course_modules_view/test_result_dialog.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/course_listing_view_model.dart';
import 'package:di360_flutter/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizSectionWidget extends StatelessWidget with BaseContextHelpers {
  const QuizSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseListingViewModel>(
      builder: (context, vm, _) {
        final questions = vm.courseDetails?.questionSection ?? [];
        if (questions.isEmpty) return const SizedBox.shrink();

        final q = questions[vm.currentQuizIndex];
        final total = questions.length;
        final current = vm.currentQuizIndex;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        width: 4, height: 30, color: AppColors.primaryColor),
                    addHorizontal(10),
                    Text(
                      "Quiz Question ${current + 1} of $total",
                      style: const TextStyle(color: AppColors.whiteColor),
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),

                addVertical(8),
                Text(
                  'Q${current + 1}.  ${q.question?.toUpperCase() ?? ''}',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),

                // Options
                ...List.generate(q.options?.length ?? 0, (i) {
                  final option = q.options![i];
                  if (q.type == 'single') {
                    return RadioListTile<int>(
                        value: i,
                        groupValue: vm.selectedSingleAnswer,
                        onChanged: (val) => vm.selectSingleAnswer(val!),
                        title: Text(option.text ?? '',
                            style:
                                const TextStyle(color: AppColors.whiteColor)),
                        activeColor: AppColors.primaryColor);
                  } else {
                    return CheckboxListTile(
                        value: vm.selectedMultipleAnswers.contains(i),
                        onChanged: (_) => vm.toggleMultipleAnswer(i),
                        title: Text(option.text ?? '',
                            style: const TextStyle(color: Colors.white)),
                        activeColor: AppColors.primaryColor,
                        checkColor: AppColors.black);
                  }
                }),

                addVertical(24),

                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      side: const BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: current < total - 1 ? vm.nextQuiz : null,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("NEXT QUESTION",
                            style: TextStyle(color: AppColors.whiteColor)),
                        addVertical(10),
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(Icons.arrow_forward,
                              size: 14, color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                ),

                addVertical(10),

                // Back button
                Center(
                  child: TextButton.icon(
                    onPressed: current > 0 ? vm.previousQuiz : null,
                    icon: Icon(Icons.arrow_back,
                        color:
                            current > 0 ? AppColors.whiteColor : Colors.grey),
                    label: Text("GO BACK",
                        style: TextStyle(
                            color: current > 0
                                ? AppColors.whiteColor
                                : Colors.grey)),
                  ),
                ),
                addVertical(20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: AppButton(
                      text: "Submit Quiz",
                      onTap: () {
                        final result = vm.submitQuiz();
                        if (result == null) return;
                        final passPercentage = double.tryParse(
                                vm.courseDetails?.passPercentage?.toString() ??
                                    '0') ??
                            0;
                        showTestResultDialog(
                            context, result.$1, result.$2, passPercentage);
                      },
                      width: 120,
                      radius: 10,
                      height: 40),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
