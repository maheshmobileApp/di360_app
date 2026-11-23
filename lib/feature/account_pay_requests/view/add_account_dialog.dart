import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/account_pay_requests/view_model/account_pay_requests_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAccountPayDialog extends StatefulWidget {
  const AddAccountPayDialog({
    super.key,
  });

  @override
  State<AddAccountPayDialog> createState() => _AddAccountPayDialogState();
}

class _AddAccountPayDialogState extends State<AddAccountPayDialog> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AccountPayRequestsViewModel>();
    final suppliers = vm.dentalSuppliersData?.dentalSuppliers
            ?.map((e) => e.businessName)
            .toList() ??
        [];

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 650,
        ),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Add Account Pay",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black87,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(
                  height: 1,
                  color: Color(0xFFE9E9E9),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 35, 25, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Supplier
                      const Text(
                        "Select Supplier",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 12),

                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.primaryColor,
                        ),
                        hint: const Text(
                          "Select supplier",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDDDDDD),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDDDDDD),
                            ),
                          ),
                        ),
                        items: suppliers.map((supplier) {
                          return DropdownMenuItem<String>(
                            value: supplier,
                            child: Text(
                              supplier ?? "",
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          vm.setSupplier(value);
                        },
                      ),

                      const SizedBox(height: 22),

                      // Account Number
                      const Text(
                        "Account Number",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: vm.accountNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter account number",
                          hintStyle: const TextStyle(
                            color: Color(0xFFBBBBBB),
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDDDDDD),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 65),

                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              
                              navigationService.goBack();
                              vm.clearAddAccountForm();
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: Color(0xFF444444),
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () async {
                              if (vm.fieldsCheck()) {
                                await vm.addSupplierAccount(context);
                              } else {
                                showTopMessage(
                                    context, "Please enter valid details");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Save Account",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
