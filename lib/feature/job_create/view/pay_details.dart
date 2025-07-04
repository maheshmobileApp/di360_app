import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';

class PayDetails extends StatelessWidget with BaseContextHelpers {
  const PayDetails({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<JobCreateViewModel>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Pay Details"),
            SizedBox(height: 16),
            _buildPayData(vm),
            addVertical(8),
            _buildRateDetails(vm),
            addVertical(8),
            InputTextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              title: "Minimum",
              hintText: "000000",
              isRequired: true,
            ),
            addVertical(8),
            InputTextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              title: "Maximum",
              hintText: "000000",
              isRequired: true,
            ),
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

  Widget _buildPayData(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
        isRequired: true,
        value: jobCreateVM.selectedPayRange,
        title: "Pay",
        onChanged: (v) {
          jobCreateVM.setSelectedPayRange(v as String);
        },
        items:
            jobCreateVM.payRanges.map<DropdownMenuItem<Object>>((String value) {
          return DropdownMenuItem<Object>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hintText: "Select role type");
  }

  Widget _buildRateDetails(JobCreateViewModel jobCreateVM) {
    return CustomDropDown(
        isRequired: true,
        value: jobCreateVM.selectRate,
        title: "Rate",
        onChanged: (v) {
          jobCreateVM.setSelectedRateRange(v as String);
        },
        items:
            jobCreateVM.rateTypes.map<DropdownMenuItem<Object>>((String value) {
          return DropdownMenuItem<Object>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hintText: "Select rate");
  }
}
