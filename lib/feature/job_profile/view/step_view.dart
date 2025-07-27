import 'package:flutter/material.dart';
import 'package:di360_flutter/common/constants/app_colors.dart';

class StepsView extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepTitles;

  const StepsView({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(totalSteps * 2 - 1, (index) {
              if (index.isEven) {
                int stepIndex = index ~/ 2;
                bool isCompleted = stepIndex < currentStep;
                bool isCurrent = stepIndex == currentStep;

                return Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted
                            ? AppColors.primaryColor
                            : Colors.white,
                        border: Border.all(
                          color: isCompleted || isCurrent
                              ? AppColors.primaryColor
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: isCompleted
                            ? Icon(Icons.check, color: Colors.white, size: 14)
                            : isCurrent
                                ? Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : SizedBox.shrink(),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      stepTitles[stepIndex],
                      style: TextStyle(
                        fontSize: 12,
                        color: isCurrent || isCompleted
                            ? AppColors.black
                            : Colors.grey,
                      ),
                    ),
                  ],
                );
              } else {
                int stepIndex = (index - 1) ~/ 2;
                bool isCompleted = stepIndex < currentStep;
                return Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.only(top: 11),
                    color: isCompleted
                        ? AppColors.primaryColor
                        : Colors.grey.shade300,
                  ),
                );
              }
            }),
          ),
        ),
        const Divider(
          thickness: 1.5,
          color: Color(0xFFE0E0E0),
          height: 0,
        ),
      ],
    );
  }
}
