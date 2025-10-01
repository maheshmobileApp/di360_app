import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/my_appointments/model_class/appoinment_res.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget with BaseContextHelpers {
  final DirectoryAppointmentsList? item;

  const AppointmentCard({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    //  final myCatalogVM = Provider.of<AppointmentViewModel>(context);
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
                    _buildCataloguRow(
                        'Name', item?.name, 'Doctor', item?.timeslot?.doctor),
                    addVertical(10),
                    _buildCataloguRow(
                        'Email', item?.email, 'Service', item?.serviceName),
                    addVertical(10),
                    _buildCataloguRow('Phone', item?.phone, 'Date & Time',
                        item?.timeslot?.timeSlotStart),
                    // addVertical(20),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: AppButton(text: 'View', height: 35, width: 80),
                    // )
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
          )
        ],
      ),
    );
  }

  Widget _buildCataloguRow(
      String? title, String? titleVal, String? subTitle, String? subTitleVal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title ?? '',
                style: TextStyles.regular1(
                    color: AppColors.bottomNavUnSelectedColor)),
            addVertical(5),
            Text(titleVal ?? '',
                style: TextStyles.medium2(color: AppColors.black))
          ]),
        ),
        Flexible(
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(subTitle ?? '',
                style: TextStyles.regular1(
                    color: AppColors.bottomNavUnSelectedColor)),
            addVertical(5),
            Text(subTitleVal ?? '',
                textAlign: TextAlign.right,
                style: TextStyles.medium2(color: AppColors.black))
          ]),
        ),
      ],
    );
  }
}
