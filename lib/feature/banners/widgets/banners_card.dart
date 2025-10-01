import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/banners/model/get_banners.dart';
import 'package:di360_flutter/feature/banners/view_model/banners_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/widgets/jiffy_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' as flutter;

class BannersCard extends StatelessWidget with BaseContextHelpers {
  final Banners? item;
  const BannersCard({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    final bannersVM = Provider.of<BannersViewModel>(context);
    Color statusColor;
    switch ("item") {
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
      padding: EdgeInsets.only(left: 14, right: 14, top: 14),
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.geryColor),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(children: [
                    addVertical(8),
                    _buildBannersName('Banner Name', item?.bannerName),
                    addVertical(10),
                    _buildBannersRow('Category', item?.categoryName, 'Views',
                        '${item?.views}', false),
                    addVertical(10),
                    _buildBannersRow('Scheduler date', item?.scheduleDate,
                        'Expiry Date', item?.expiryDate, true)
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
                bannersVM,
                context,
                item?.id,
                item?.expiryDate ?? '',
                item?.image?.isNotEmpty == true ? item?.image?.first.url : null,
              ))
        ],
      ),
    );
  }

  Widget _buildBannersName(String? title, String? titleVal) {
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

  Widget _buildBannersRow(String? title, String? titleVal, String? subTitle,
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
                  ? jiffyDataWidget(subTitleVal ?? '', format: 'MMM d, y')
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

  Widget menuWidget(BannersViewModel vm, BuildContext context, String? id,
      String expDate, String? url) {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: const EdgeInsets.all(0),
      onSelected: (value) {
        if (value == "View") {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Text("Preview"),
                  ],
                ),
                content: (url != null && url.isNotEmpty)
                    ? flutter.Image.network(
                        url,
                        fit: BoxFit.contain,
                      )
                    : Text("No image available"),
                actions: [
                  TextButton(
                    onPressed: () => navigationService.goBack(),
                    child: Text("Close"),
                  ),
                ],
              );
            },
          );
          //  vm.getCatalogueView(context, id);
        } else if (value == "Edit") {
           vm.editCatalogueNavigator(context, id);
        } else if (value == "Delete") {
          showAlertMessage(
              context, 'Are you sure you want to delete this catalogue?',
              onBack: () {
            navigationService.goBack();
            vm.removeBanner(context, id);
          });
        } 
      },
      itemBuilder: (context) => [
        PopupMenuItem(
            value: "View",
            child: _buildRow(
                Icons.remove_red_eye, AppColors.black, "View Banner")),
      
       
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
