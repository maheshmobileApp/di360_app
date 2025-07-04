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
               SizedBox(
                  height: 16,
                ),
                InputTextField(
                  hintText: "Location",
                  title: "Search Location",
                  isRequired: true,
                ),
                SizedBox(height: 10,),
                _buildCountryList(jobCreateVM),
                SizedBox(height: 10,),
                 InputTextField(
                  hintText: "Enter city / Post code",
                  title: "State",
                  isRequired: true,
                ),
                SizedBox(height: 10),
                 InputTextField(
                  hintText: "Enter city / Post code",
                  title: "City / Post Code",
                  isRequired: true,
                ),
                SizedBox(height: 8),
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
        items: jobCreateVM.countryList
            .map<DropdownMenuItem<Object>>((String value) {
          return DropdownMenuItem<Object>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hintText: "Select Country");
  }
}