import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/feature/clients/clients_provider/clients_provider.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientMenuWidget extends StatelessWidget {
  final String? status;
  final String? clientId;
  final String? clientName;
  const ClientMenuWidget(
      {super.key, this.status, this.clientId, this.clientName});

  @override
  Widget build(BuildContext context) {
    final clientsProvider =
        Provider.of<ClientsProvider>(context, listen: false);
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.all(0),
      menuPadding: EdgeInsets.all(0),
      splashRadius: 5,
      onSelected: (value) {
        if (value == 'Approve') {
          clientsProvider.adminApproveUser(context, clientId ?? '');
        } else if (value == 'Delete') {
          showAlertMessage(
              context, "Do you really want to delete this $clientName?",
              onBack: () {
            clientsProvider.deleteUserData(context, clientId ?? '');
          });
        } else if (value == 'Resend') {
          clientsProvider.reSendVerifyMail(context, clientId ?? '');
        } else if (value == 'Inactive') {
          showAlertMessage(context, "Do you really want to change status ?",
              onBack: () {
            clientsProvider.inactiveClient(context, clientId ?? '');
          });
        }
      },
      itemBuilder: (context) => [
        if (status == 'VERIFIED')
          PopupMenuItem(
              value: "Approve",
              child: buildRow(Icons.check, AppColors.greenColor, "Approve")),
        PopupMenuItem(
            value: "Delete",
            child:
                buildRow(Icons.delete_outline, AppColors.redColor, "Delete")),
        if (status == 'VERIFICATION_PENDING')
          PopupMenuItem(
              value: "Resend",
              child: buildRow(
                  Icons.mail, AppColors.blueColor, "Resend Verification")),
        if (status == 'ADMIN_APPROVED' || status == 'ACTIVE')
          PopupMenuItem(
              value: "Inactive",
              child:
                  buildRow(Icons.close, AppColors.pendingsendary, "Inactive")),
      ],
    );
  }
}

Widget buildRow(IconData? icon, Color? color, String? title) {
  return Row(children: [
    Icon(icon, color: color),
    SizedBox(width: 8),
    Text(title ?? '', style: TextStyles.semiBold(fontSize: 14, color: color))
  ]);
}
