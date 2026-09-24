
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_date_picker.dart';
import 'package:di360_flutter/feature/job_create/widgets/custom_dropdown.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/address_card.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryAndNotesCard extends StatelessWidget {
  const DeliveryAndNotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesViewModel>();

    final address = vm.selectedAddress;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 10.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery & Notes',
                style: TextStyles.clashSemiBold(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 10),

              _deliveryAddress(vm),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      vm.clearAddressFields();
                      vm.addressType = null;

                      navigationService.navigateTo(
                        RouteList.addNewsAddressView,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Text(
                          "+ Add New Address",
                          style: TextStyles.medium2(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              if (address != null)
                AddressCard(
                  title: address.shortName,
                  line1: address.line1,
                  line2: address.line2,
                  city: address.city,
                  state: address.state,
                  postalCode: address.postalCode,
                  country: address.country,
                ),

              const SizedBox(height: 12),

               InputTextField(
                controller: vm.addressline1Controller,
                hintText: "Add notes for the supplier...",
                keyboardType: TextInputType.name,
                title: "Order Notes (Optional)",
                maxLength: 70,
              ),

              CustomDatePicker(
                  isRequired: true,
                  title: "Delivery Date",
                  controller: vm.deliveryDateController,
                  text: null,
                  hintText: "Date",
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      vm.deliveryDateController.text =
                          DateFormatUtils.formatMMDDYYYY(picked.toIso8601String());
                    }
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please Select Date'
                      : null,
                ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _deliveryAddress(
    SuppliesViewModel viewModel,
  ) {
    final addresses =
        viewModel.dentalProfessionalAddress?.dentalProfessionalAddresses ??
            [];

    if (addresses.isEmpty) {
      return const SizedBox.shrink();
    }

    return CustomDropDown(
      value: addresses.any(
        (address) => address.id == viewModel.selectedAddressId,
      )
          ? viewModel.selectedAddressId
          : null,

      title: "Delivery Address",

      onChanged: (value) {
        if (value != null) {
          viewModel.setSelectedAddress(
            value.toString(),
          );
        }
      },

      items: addresses.map<DropdownMenuItem<Object>>(
        (address) {
          return DropdownMenuItem<Object>(
            value: address.id,
            child: Text(
              '${address.type ?? 'Other'}'
              '${address.shortName?.isNotEmpty == true ? ' - ${address.shortName}' : ''}',
            ),
          );
        },
      ).toList(),

      hintText: "Select Address",

      validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return 'Please select address';
        }

        return null;
      },
    );
  }
}

