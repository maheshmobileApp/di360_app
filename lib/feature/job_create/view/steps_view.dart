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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(totalSteps * 2 - 1, (index) {
          if (index.isEven) {
            int stepIndex = index ~/ 2;
            bool isActive = stepIndex == currentStep;
            bool isCompleted = stepIndex < currentStep;

            return Expanded(
              flex: 2,
              child: Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted
                          ? AppColors.primaryColor
                          : isActive
                              ? AppColors.primaryColor
                              : Colors.grey.shade300,
                      border: Border.all(
                        color: isCompleted || isActive
                            ? AppColors.primaryColor
                            : Colors.grey.shade400,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(Icons.check, color: Colors.white, size: 16)
                          : Text(
                              "${stepIndex + 1}",
                              style: TextStyle(
                                fontSize: 12,
                                color: isActive || isCompleted
                                    ? Colors.white
                                    : Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 60,
                    child: Text(
                      stepTitles[stepIndex],
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive ? Colors.black : Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          } else {
            bool isCompleted = (index ~/ 2) < currentStep;

            return Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 14),
                height: 2,
                color: isCompleted
                    ? AppColors.primaryColor
                    : Colors.grey.shade300,
              ),
            );
          }
        }),
      ),
    );
  }
}
