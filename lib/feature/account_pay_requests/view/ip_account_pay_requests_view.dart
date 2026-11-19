import 'package:di360_flutter/feature/account_pay_requests/view_model/account_pay_requests_view_model.dart';
import 'package:di360_flutter/feature/account_pay_requests/widgets/account_pay_requests_card.dart';
import 'package:di360_flutter/feature/account_pay_requests/widgets/ip_account_pay_requests_card.dart';
import 'package:di360_flutter/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IpAccountPayRequestsView extends StatefulWidget {
  const IpAccountPayRequestsView({super.key});

  @override
  State<IpAccountPayRequestsView> createState() =>
      _IpAccountPayRequestsViewState();
}

class _IpAccountPayRequestsViewState extends State<IpAccountPayRequestsView> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AccountPayRequestsViewModel>();
    return Scaffold(
        appBar: AppBarWidget(
          notification: false,
          logo: false,
          searchWidget: false,
          title: "Account Pay Requests",
        ),
        body: _accountPayRequestsContent(vm),
        );
  }

  Widget _accountPayRequestsContent(AccountPayRequestsViewModel vm) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: vm.ipAccountRequestsData?.supplierAccountRequests?.length,
      itemBuilder: (context, index) {
        final item = vm.ipAccountRequestsData?.supplierAccountRequests?[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: IpAccountPayRequestsCard(
            
            name: item?.name ?? '',
            email: item?.email ?? '',
            role: item?.dentalPracticeId != null ? "Practice": item?.dentalProfessionalId != null ? "Professional" : "Supplier",
            phone: item?.phone ?? '',
            abnNumber: item?.abnNumber ?? '',
            billingAddress: item?.billingAddress ?? '',
            status: item?.status ?? '', businessName: item?.practiceName?? "",
          ),
        );
      },
    );
  }
}
