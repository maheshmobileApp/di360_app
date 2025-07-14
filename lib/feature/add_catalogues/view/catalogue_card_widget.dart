import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/add_catalogues/model_class/my_catalogue_res.dart';
import 'package:di360_flutter/widgets/jiffy_widget.dart';
import 'package:flutter/material.dart';

class CatalogueCard extends StatelessWidget with BaseContextHelpers {
  final Catalogues? item;

  const CatalogueCard({super.key, this.item});

  @override
  Widget build(BuildContext context) {
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
          Positioned(right: 2, top: 15, child: menuWidget())
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
        ]),
        //  menuWidget()
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

  Widget menuWidget() {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      padding: const EdgeInsets.all(0),
      onSelected: (value) {
        if (value == "View") {
        } else if (value == "Edit") {
        } else if (value == "Inactive") {
        } else if (value == "Delete") {}
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: "View", child: Text("View")),
        const PopupMenuItem(value: "Edit", child: Text("Edit")),
        const PopupMenuItem(value: "Inactive", child: Text("Inactive")),
        const PopupMenuItem(
          value: "Delete",
          child: Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
