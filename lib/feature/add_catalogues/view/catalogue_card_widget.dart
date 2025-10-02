import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_catalogues/add_catalogue_view_model/add_catalogu_view_model.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/my_catalogue_res.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/widgets/jiffy_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogueCard extends StatelessWidget with BaseContextHelpers {
  final Catalogues? item;

  const CatalogueCard({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    final myCatalogVM = Provider.of<AddCatalogueViewModel>(context);
    Color statusColor;
    switch (item?.status) {
      case 'APPROVED':
        statusColor = Color(0xffE5F4ED);
        break;
      case 'Pending':
        statusColor = Color(0xffE6F1FC);
        break;
      case 'Rejected':
        statusColor = Color(0xffE6F1FC);
        break;
      default:
        statusColor = Color(0xffE6F1FC);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.geryColor),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(children: [
                    addVertical(8),
                    _buildCatalogueName('Catalogue Name', item?.title),
                    addVertical(10),
                    _buildCataloguRow('Category', item?.catalogueCategory?.name,
                        'Views', '${item?.views}', false),
                    addVertical(10),
                    _buildCataloguRow('Scheduler date', item?.schedulerDay,
                        'Expiry Date', item?.expiryDay, true)
                  ]))),
          Positioned(
            top: 1,
            right: 50,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 4),
              decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Text(
                item?.status ?? '',
                style: TextStyles.medium3(
                    color: item?.status == 'APPROVED'
                        ? AppColors.greenColor
                        : AppColors.primaryBlueColor,
                    fontSize: 10),
              ),
            ),
          ),
          Positioned(
              right: 2,
              top: 15,
              child: menuWidget(
                  myCatalogVM, context, item?.id, item?.expiryDay ?? ''))
        ],
      ),
    );
  }

  Widget _buildCatalogueName(String? title, String? titleVal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title ?? '',
              style: TextStyles.regular1(
                  color: AppColors.bottomNavUnSelectedColor)),
          addVertical(5),
          Text(titleVal ?? '',
              style: TextStyles.medium2(color: AppColors.black))
        ])
      ],
    );
  }

  Widget _buildCataloguRow(String? title, String? titleVal, String? subTitle,
      String? subTitleVal, bool isData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title ?? '',
              style: TextStyles.regular1(
                  color: AppColors.bottomNavUnSelectedColor)),
          addVertical(5),
          Text(
              isData
                  ? jiffyDataWidget(titleVal ?? '', format: 'MMM d, y')
                  : titleVal ?? '',
              style: TextStyles.medium2(color: AppColors.black))
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(subTitle ?? '',
              style: TextStyles.regular1(
                  color: AppColors.bottomNavUnSelectedColor)),
          addVertical(5),
          Text(
              isData
                  ? jiffyDataWidget(subTitleVal ?? '', format: 'MMM d, y')
                  : subTitleVal ?? '',
              style: TextStyles.medium2(color: AppColors.black))
        ]),
      ],
    );
  }

  Widget menuWidget(AddCatalogueViewModel vm, BuildContext context, String? id,
      String expDate) {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.all(0),
      onSelected: (value) {
        if (value == "View") {
          vm.getCatalogueView(context, id);
        } else if (value == "Edit") {
          vm.editCatalogueNavigator(context, id, expDate);
        } else if (value == "Inactive") {
          showAlertMessage(context, 'Do you really want to change status?',
              onBack: () {
            navigationService.goBack();
            vm.inActiveCatalogue(context, id);
          });
        } else if (value == "Delete") {
          showAlertMessage(
              context, 'Are you sure you want to delete this catalogue?',
              onBack: () {
            navigationService.goBack();
            vm.removeCatalogue(context, id);
          });
        } else if (value == "sendApproval") {
          showAlertMessage(context, 'Do you really want to change status?',
              onBack: () {
            navigationService.goBack();
            vm.sendApprovalCatalogue(context, id);
          });
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
            value: "View",
            child: _buildRow(
                Icons.remove_red_eye, AppColors.black, "View Catalogue")),
        if (vm.selectedStatus == 'Approved & Scheduled')
          PopupMenuItem(
              value: "Inactive",
              child: _buildRow(
                  Icons.local_activity, AppColors.primaryColor, "Inactive")),
        if (vm.selectedStatus == 'Draft')
          PopupMenuItem(
              value: "sendApproval",
              child: _buildRow(Icons.send_rounded, AppColors.primaryColor,
                  "Send for Approval")),
        if (vm.selectedStatus != 'Approved & Scheduled')
          PopupMenuItem(
              value: "Edit",
              child:
                  _buildRow(Icons.edit_outlined, AppColors.blueColor, "Edit")),
        PopupMenuItem(
            value: "Delete",
            child:
                _buildRow(Icons.delete_outline, AppColors.redColor, "Delete")),
      ],
    );
  }

  Widget _buildRow(IconData? icon, Color? color, String? title) {
    return Row(children: [
      Icon(icon, color: color),
      addHorizontal(8),
      Text(title ?? '', style: TextStyles.semiBold(fontSize: 14, color: color))
    ]);
  }
}
