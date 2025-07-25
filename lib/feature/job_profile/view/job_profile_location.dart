import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/job_profile/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobProfileLocation extends StatelessWidget {
  const JobProfileLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final jobProfileVM = Provider.of<JobProfileViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Location"),
            const SizedBox(height: 16),
            InputTextField(
              hintText: "Location",
              title: "Search Location",
            ),
            const SizedBox(height: 10),
            _buildCountryList(jobProfileVM),
            const SizedBox(height: 10),
            InputTextField(
              hintText: "Enter state",
              title: "State",
            ),
            const SizedBox(height: 10),
            InputTextField(
              hintText: "Enter city / Post code",
              title: "City / Post Code",
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyles.clashMedium(color: AppColors.buttonColor),
    );
  }
  Widget _buildCountryList(JobProfileViewModel jobProfileVM) {
    return CustomDropDown(
      value: jobProfileVM.selectCountry,
      title: "Country",
      onChanged: (v) {
        jobProfileVM.setSelectedCountry(v as String);
      },
      items: jobProfileVM.countryList.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Country",
    );
  }
}
