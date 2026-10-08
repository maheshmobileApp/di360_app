import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/account_pay_requests/view_model/account_pay_requests_view_model.dart';
import 'package:di360_flutter/feature/account_pay_requests/widgets/account_pay_detail_card.dart';
import 'package:di360_flutter/feature/account_pay_requests/widgets/account_pay_requests_card.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPayRequestsView extends StatefulWidget {
  const AccountPayRequestsView({super.key});

  @override
  State<AccountPayRequestsView> createState() => _AccountPayRequestsViewState();
}

class _AccountPayRequestsViewState extends State<AccountPayRequestsView> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AccountPayRequestsViewModel>();
    return Scaffold(
      appBar: AppBarWidget(
        notification: false,
        logo: false,
        searchWidget: false,
        title:
            selectedTab == 0 ? "Account Pay Details" : "Account Pay Requests",
      ),
      body: Column(
        children: [
          // Top buttons
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton(
                    title: 'Account Pay Details',
                    index: 0,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTabButton(
                    title: 'Account Pay Request',
                    index: 1,
                  ),
                ),
              ],
            ),
          ),

          // Screen content
          Expanded(
            child: selectedTab == 0
                ? _accountPayDetailsContent(vm)
                : _accountPayRequestsContent(vm),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required int index,
  }) {
    final isSelected = selectedTab == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected ? AppColors.primaryColor : const Color(0xFFD0D5DD),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF344054),
          ),
        ),
      ),
    );
  }

  Widget _accountPayDetailsContent(AccountPayRequestsViewModel vm) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: vm.supplierAccountData?.supplierAccounts?.length, // Example count
      itemBuilder: (context, index) {
        final item = vm.supplierAccountData?.supplierAccounts?[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AccountPayDetailCard(
           name: item?.supplier?.businessName?? "",
           number: item?.accountNumber?? "",
          ),
        );
      },
    );
  }

  Widget _accountPayRequestsContent(AccountPayRequestsViewModel vm) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: vm.accountRequestsData?.supplierAccountRequests?.length, // Example count
      itemBuilder: (context, index) {
        final item = vm.accountRequestsData?.supplierAccountRequests?[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AccountPayRequestsCard(
            serialNo: index.toString(),
            supplierName: item?.supplier?.businessName ?? '',
            name: item?.name ?? '',
            email: item?.email ?? '',
            phoneNo: item?.phone ?? '',
            abnNumber: item?.abnNumber ?? '',
            billingAddress: item?.billingAddress ?? '',
            status: item?.status ?? '',
          ),
        );
      },
    );
  }
}
