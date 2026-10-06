import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/supplies/model/get_supplies_res.dart';
import 'package:di360_flutter/feature/supplies/view_model/supplies_view_model.dart';
import 'package:di360_flutter/feature/supplies/widgets/quantity_stepper.dart';
import 'package:di360_flutter/widgets/input_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentModeCard extends StatelessWidget {
  const PaymentModeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SuppliesViewModel>();
    String selected = 'account';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
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
                  Text('Payment Mode',
                      style: TextStyles.clashSemiBold(fontSize: 18)),
                  SizedBox(height: 8),
                  _radioWidget(selected),
                  Row(
                    children: [
                      Expanded(
                        child: _accountPayCard(() {
                          vm.setAccountPayType("yes");
                        },
                            title:
                                "I already have an account with this supplier",
                            subtitle: "Enter your existing account number",
                            type: vm.accountPayType == "yes"),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _accountPayCard(() {
                          vm.setAccountPayType("no");
                        },
                            title: "I don't have an account with this supplier",
                            subtitle: "Provide your details to request one",
                            type: vm.accountPayType == "no"),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  if (vm.accountPayType == "yes") _typeYesFields(vm),
                  if (vm.accountPayType == "no") _typeNoFields(vm),
                ]),
          )),
    );
  }
}

_iconWithText(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, size: 16, color: Colors.grey.shade700),
      const SizedBox(width: 4),
      Text(text, style: TextStyles.medium2(color: Colors.grey.shade700)),
    ],
  );
}

_quantityCard(SuppliesViewModel vm, String supplyId) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("Quantity", style: TextStyles.medium2(color: Colors.grey.shade700)),
    const SizedBox(height: 4),
    QuantityStepper(
      width: 120,
      quantity: vm.getQuantity(supplyId),
      onIncrease: () {
        vm.increaseQuantity(supplyId);
      },
      onDecrease: () {
        vm.decreaseQuantity(supplyId);
      },
    ),
    const SizedBox(height: 4),
  ]);
}

_radioWidget(String selected) {
  return Row(
    children: [
      Radio<String>(
        value: 'account',
        groupValue: selected,
        activeColor: Colors.orange,
        onChanged: (value) {},
      ),
      const Text(
        'Account Pay',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      const SizedBox(width: 12),
      Radio<String>(
        value: 'online',
        groupValue: selected,
        activeColor: Colors.orange,
        onChanged: (value) {},
      ),
      const Text(
        'Online',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    ],
  );
}

Widget _typeYesFields(SuppliesViewModel vm) {
  return Column(children: [
    InputTextField(
      controller: vm.compNameController,
      hintText: "Enter Name",
      keyboardType: TextInputType.name,
      title: "Name",
      maxLength: 70,
      isRequired: true,
    ),
    SizedBox(height: 6),
    InputTextField(
      controller: vm.compCompanyNameController,
      hintText: "Enter company name",
      keyboardType: TextInputType.name,
      title: "Company Name",
      maxLength: 70,
      isRequired: true,
    ),
    SizedBox(height: 6),
    InputTextField(
      controller: vm.accountNumberController,
      hintText: "Enter account number",
      keyboardType: TextInputType.name,
      title: "Account number",
      maxLength: 70,
      isRequired: true,
    ),
    SizedBox(height: 6),
    InputTextField(
      controller: vm.emailController,
      hintText: "Enter email",
      keyboardType: TextInputType.name,
      title: "Email",
      maxLength: 70,
      isRequired: true,
    ),
  ]);
}

Widget _typeNoFields(SuppliesViewModel vm) {
  return Column(children: [
    InputTextField(
      controller: vm.contactPersonController,
      hintText: "Enter contact person",
      keyboardType: TextInputType.name,
      title: "Contact Person",
      maxLength: 70,
      isRequired: true,
    ),
    SizedBox(height: 6),
    InputTextField(
      controller: vm.emailController,
      hintText: "Enter Email",
      keyboardType: TextInputType.name,
      title: "Email",
      maxLength: 70,
      isRequired: true,
    ),
    SizedBox(height: 6),
    InputTextField(
      controller: vm.phoneController,
      hintText: "Enter phone",
      keyboardType: TextInputType.name,
      title: "Phone",
      maxLength: 70,
      isRequired: true,
    ),
    SizedBox(height: 6),
    InputTextField(
      controller: vm.abnController,
      hintText: "Enter ABN",
      keyboardType: TextInputType.name,
      title: "ABN",
      maxLength: 70,
    ),
    SizedBox(height: 6),
    InputTextField(
      controller: vm.billingAddressController,
      hintText: "Enter billing address",
      keyboardType: TextInputType.name,
      title: "Billing Address",
      maxLength: 70,
    ),
    SizedBox(height: 6),
    InputTextField(
      controller: vm.notesController,
      hintText: "Enter notes",
      keyboardType: TextInputType.name,
      title: "Notes",
      maxLength: 70,
    ),
  ]);
}

Widget _accountPayCard(VoidCallback onTap,
    {required String title, required String subtitle, required bool type}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 204,
      decoration: BoxDecoration(
          color:
              type ? AppColors.primaryColor.withOpacity(0.1) : AppColors.black,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: type ? AppColors.primaryColor : AppColors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          type
              ? Icon(
                  Icons.check_circle,
                  color: Colors.orange,
                  size: 26,
                )
              : Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF6F82A0),
                      width: 2,
                    ),
                  ),
                ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: type ? AppColors.black : AppColors.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: type ? AppColors.black : AppColors.whiteColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}

_priceInfoCard(Supplies? suppliesDetails) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price", style: TextStyles.medium2(color: Colors.grey.shade700)),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                "AUD ${suppliesDetails?.supplyVariants?.firstOrNull?.sellingPrice ?? 'N/A'}",
                style: TextStyles.semiBold(
                    fontSize: 20, color: AppColors.primaryColor),
              ),
              Text(" / Piece",
                  style: TextStyles.medium2(color: Colors.grey.shade700)),
            ],
          ),
        ],
      ),
      Container(
        decoration: BoxDecoration(
            color: AppColors.greenColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.greenColor, width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          child: Text("In Stock",
              style: TextStyles.semiBold(
                  color: AppColors.greenColor, fontSize: 12)),
        ),
      )
    ],
  );
}

_infoDetailColumn(String? supplier, String? itemsCount, String? subtotal,
    String? discount, String freightCharges, String estimatedTotal) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _infoRow("Supplier", supplier ?? ''),
      _infoRow("Total Selected Items", itemsCount ?? ''),
      Divider(),
      _infoRow("Subtotal", "AUD $subtotal"),
      _infoRow("Discount", "(-) AUD $discount"),
      _infoRow("Freight Charges", "AUD $freightCharges"),
      Divider(),
      _infoRow2("Estimated Total", "AUD $subtotal")
    ],
  );
}

_infoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyles.medium2(color: Colors.grey.shade700)),
        Text(value, style: TextStyles.bold2()),
      ],
    ),
  );
}

_infoRow2(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyles.bold2(color: Colors.grey.shade700)),
        Text(value, style: TextStyles.bold3(color: AppColors.primaryColor)),
      ],
    ),
  );
}
