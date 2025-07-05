import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobLocationView extends StatelessWidget {
  const JobLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCreateVM = Provider.of<JobCreateViewModel>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Job Location"),
            const SizedBox(height: 16),
            InputTextField(
              controller: jobCreateVM.locationSearchController,
              hintText: "Location",
              title: "Search Location",
              isRequired: true,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter location' : null,
            ),
            const SizedBox(height: 10),
            _buildCountryList(jobCreateVM),
            const SizedBox(height: 10),
            InputTextField(
              controller: jobCreateVM.stateController,
              hintText: "Enter state",
              title: "State",
              isRequired: true,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter state' : null,
            ),
            const SizedBox(height: 10),
            InputTextField(
              controller: jobCreateVM.cityPostCodeController,
              hintText: "Enter city / Post code",
              title: "City / Post Code",
              isRequired: true,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter city or post code'
                  : null,
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
  Widget _buildCountryList(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
      isRequired: true,
      value: jobCreateVM.selectCountry,
      title: "Country",
      onChanged: (v) {
        jobCreateVM.setSelectedCountry(v as String);
      },
      items: jobCreateVM.countryList.map<DropdownMenuItem<Object>>((String value) {
        return DropdownMenuItem<Object>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hintText: "Select Country",
      validator: (value) =>
          value == null || value.toString().isEmpty ? 'Please select a country' : null,
    );
  }
}
