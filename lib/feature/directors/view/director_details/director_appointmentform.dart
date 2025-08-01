import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/directors/view_model/director_view_model.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DirectorAppointmentform extends StatelessWidget with BaseContextHelpers  {
  const DirectorAppointmentform({super.key});

  @override
  Widget build(BuildContext context) {
    final directionalVM = Provider.of<DirectorViewModel>(context);
    return Form(
      key: directionalVM.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            InputTextField(
              title: 'First Name',
              isRequired: true,
              hintText: 'Enter First Name',
              controller: directionalVM.firstNameController,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please Enter First Name'
                  : null,
            ),
            InputTextField(
              title: 'Last Name',
              isRequired: true,
              hintText: 'Enter Last Name',
            ),
            InputTextField(
              title: 'Phone Number',
              isRequired: true,
              hintText: 'Enter Phone Number',
              controller: directionalVM.phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) => value == null || value.isEmpty
                  ? 'Please Enter Phone Number'
                  : null,
            ),
            InputTextField(
              title: 'Email',
              isRequired: true,
              hintText: 'Enter Email',
              controller: directionalVM.emailController,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please Enter Email' : null,
            ),
           addVertical(16),
            InputTextField(
              title: 'Appointment Date',
              isRequired: true,
              hintText: 'Select Date',
              controller: directionalVM.appointmentDateController,
              readOnly: true,
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Select Appointment Date',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            addVertical(16),
                            CalendarDatePicker(
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              onDateChanged: (pickedDate) {
                                directionalVM.appointmentDateController.text =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                Navigator.pop(context); 
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please select appointment date'
                  : null,
            ),
            addVertical(12),
            CustomDropDown<String>(
              title: 'Team Member',
              hintText: 'Select Team Member',
              isRequired: true,
              value: directionalVM.selectedTeamMember,
              items: directionalVM.teamMemberList
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (val) {
                directionalVM.selectedTeamMember = val;
              },
              validator: (value) => value == null || value.isEmpty
                  ? 'Please Select Team Member'
                  : null,
            ),
            addVertical(12),
            CustomDropDown<String>(
              title: 'Service Required',
              hintText: 'Select Service',
              isRequired: true,
              value: directionalVM.selectedService,
              items: directionalVM.serviceList
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (val) {
                directionalVM.selectedService = val;
              },
              validator: (value) => value == null || value.isEmpty
                  ? 'Please Select Service'
                  : null,
            ),
            addVertical(10),
            _buildUploadField(context, directionalVM),
            addVertical(5),
            ElevatedButton(
  onPressed: () {
    if (directionalVM.validateForm()) {
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    minimumSize: const Size(297, 50), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25), 
    ),
    elevation: 0, 
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'SUBMIT DETAILS',
        style: TextStyle(
          letterSpacing: 2,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
      Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.orange,
        ),
        child: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 20,
        ),
      ),
    ],
  ),
),

          ],
        ),
      ),
    );
  }

  static Widget _buildUploadField(
      BuildContext context, DirectorViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upload supporting images', style: TextStyles.medium2()),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: viewModel.pickFiles,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              children: [
                Icon(Icons.upload),
                SizedBox(width: 8),
                Text('Select File(s)'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(viewModel.selectedFiles.length, (index) {
            final file = viewModel.selectedFiles[index];
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    file,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: -8,
                  right: -8,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => viewModel.removeFile(index),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
