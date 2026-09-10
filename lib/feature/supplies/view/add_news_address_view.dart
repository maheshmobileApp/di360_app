import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewsAddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        final vm = context.watch<SuppliesViewModel>();


    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add New Address",
            style: TextStyles.medium2(),
          ),
        ),
        body: SingleChildScrollView(child: Column(
          children: [
            InputTextField(
              controller: vm.locationController,
              hintText: "Enter location",
              keyboardType: TextInputType.name,
              title: "Location",
              maxLength: 70,
              isRequired: true,
            ),
            InputTextField(
              controller: vm.nameController,
              hintText: "Enter name",
              keyboardType: TextInputType.name,
              title: "Name",
              maxLength: 70,
              isRequired: true,
            ),
            InputTextField(
              controller: vm.addressline1Controller,
              hintText: "Enter address line 1",
              keyboardType: TextInputType.name,
              title: "Address Line 1",
              maxLength: 70,
              isRequired: true,
            ),
            InputTextField(
              controller: vm.addressline2Controller,
              hintText: "Enter address line 2",
              keyboardType: TextInputType.name,
              title: "Address Line 2",
              maxLength: 70,
              isRequired: true,
            ),
            InputTextField(
              controller: vm.landmarkController,
              hintText: "Enter Landmark",
              keyboardType: TextInputType.name,
              title: "Landmark",
              maxLength: 70,
              isRequired: true,
            ),
            InputTextField(
              controller: vm.cityController,
              hintText: "Enter city",
              keyboardType: TextInputType.name,
              title: "City",
              maxLength: 70,
              isRequired: true,
            ),
            InputTextField(
              controller: vm.companyNameController,
              hintText: "Enter comapny",
              keyboardType: TextInputType.name,
              title: "Company",
              maxLength: 70,
              isRequired: true,
            ),
          ],
        )));
  }
}
