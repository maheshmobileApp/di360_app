import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/learning_hub/view_model/new_course_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLearningHubFilterScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onApply;
  final Function onClear;

  const MyLearningHubFilterScreen({Key? key,
   required this.onApply, 
   required this.onClear})
      : super(key: key);

  @override
  _MyLearningHubFilterScreenState createState() => _MyLearningHubFilterScreenState();
}

class _MyLearningHubFilterScreenState extends State<MyLearningHubFilterScreen> {
  Map<String, dynamic> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
     final newCourseVM = Provider.of<NewCourseViewModel>(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter",
                  style: TextStyle(fontSize: 20, color: AppColors.black),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    navigationService.goBack();
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  _filterSection(
                    title: 'Filter by Type',
                    options: newCourseVM.courseTypeNames,
                    onToggle: (index, value) {
                      setState(() {
                        selectedOptions["Filter by Type"] = value;
                      });
                    },
                  ),
                  _filterSection(
                    title: 'Filter by Category',
                    options: newCourseVM.courseCategory,
                    onToggle: (index, value) {
                      setState(() {
                        selectedOptions["Filter by Category"] = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomRoundedButton(
                    text: 'Clear',
                    fontSize: 16,
                    height: 42,
                    onPressed: () {
                      widget.onClear();
                    },
                    backgroundColor: AppColors.timeBgColor,
                    textColor: Colors.black,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomRoundedButton(
                    text: 'Apply',
                    fontSize: 16,
                    height: 42,
                    onPressed: () {
                      widget.onApply(selectedOptions);
                    },
                    backgroundColor: AppColors.primaryColor,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterSection({
    required String title,
    required List<String> options,
    required Function(int, String) onToggle,
  }) {
    return ExpansionTile(
      title: Text(title, style: TextStyles.regular3(color: AppColors.black)),
      initiallyExpanded: true,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
      children: List.generate(options.length, (index) {
        return CheckboxListTile(
          title: Text(options[index],
              style: TextStyles.regular3(color: AppColors.lightGeryColor)),
          value: selectedOptions[title] == options[index],
          onChanged: (value) {
            onToggle(index, options[index]);
          },
          activeColor: AppColors.primaryColor,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        );
      }),
    );
  }
}
