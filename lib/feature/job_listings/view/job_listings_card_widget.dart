import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class JobListingCard extends StatelessWidget with BaseContextHelpers {
  final JobsListingDetails? jobsListingData;
  final JobListingsViewModel vm;
  final int? index;
  const JobListingCard({
    super.key,
    required this.jobsListingData,
    required this.vm, this.index,
  });
  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(jobsListingData?.createdAt ?? '') ?? '';
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromRGBO(220, 224, 228, 1),
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(116, 130, 148, 0.2),
              blurRadius: 15,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _logoWithTitle(
                    context,
                    jobsListingData?.logo ?? '',
                    jobsListingData?.companyName ?? '',
                    jobsListingData?.jRole ?? '',
                    time,
                  ),
                ),
                  _jobTimeChip(time),
                menuWidget(vm, context,index!,jobsListingData?.id??"",jobsListingData?.status??""),
              ],
            ),
             addVertical(12),
            _chipWidget(jobsListingData?.typeofEmployment ?? []),
            addVertical(10),
            _descriptionWidget(jobsListingData?.description ?? ''),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Icon(Icons.arrow_back_ios,color: AppColors.buttonColor,size: 10,)
            ],)
          ],
        ),
      ),
    );
  }

  Widget menuWidget(
    JobListingsViewModel vm,
    BuildContext context,
     int index,
     String id,
      String status,
  ) {
    return PopupMenuButton<String>(
      iconColor: AppColors.bottomNavUnSelectedColor,
      color: AppColors.whiteColor,
      padding: EdgeInsets.all(0),
      onSelected: (value) {
        if (value == "Edit") {
          // vm.getCatalogueView(context, id);
        } else if (value == "Active") {
        } else if (value == "Preview") {
          navigationService.navigateToWithParams(
            RouteList.JobListingDetailsScreen,
             params: vm.myJobListingList[index],
          );
        } else if (value == "Inactive") {
          showAlertMessage(context, 'Do you really want to change status?',
              onBack: () {
            navigationService.goBack();
             vm.updateJobListingStatus(context, id,status);
          });
        } else if (value == "Delete") {
          showAlertMessage(
              context, 'Are you sure you want to delete this catalogue?',
              onBack: () {
            navigationService.goBack();
             vm.removeJobsListingData(context, id);
          });
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "Preview",
          child: _buildRow(Icons.remove_red_eye, AppColors.black, "Preview"),
        ),
        PopupMenuItem(
            value: "Edit",
            child: _buildRow(Icons.edit_outlined, AppColors.blueColor, "Edit")),
        PopupMenuItem(
            value: "Delete",
            child:
                _buildRow(Icons.delete_outline, AppColors.redColor, "Delete")),
        if (vm.selectedStatus == 'Draft' ||
            vm.selectedStatus == 'Pending Approval' ||
            vm.selectedStatus == "Active" ||
            vm.selectedStatus == "Expired" ||
            vm.selectedStatus == "All")
          PopupMenuItem(
              value: "Inactive",
              child: _buildRow(
                  Icons.local_activity, AppColors.primaryColor, "Inactive")),
        if (vm.selectedStatus == "InActive")
          PopupMenuItem(
              value: "Active",
              child: _buildRow(
                  Icons.local_activity, AppColors.primaryColor, "Active")),
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

Widget _logoWithTitle(BuildContext context, String logo, String company,
    String title, String time) {
  return Row(
    children: [
      Stack(children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          backgroundImage: logo.isNotEmpty ? NetworkImage(logo) : null,
          radius: 30,
          child: logo.isEmpty
              ? Icon(Icons.business, size: 20, color: Colors.grey)
              : null,
        ),
        Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Active',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
      ]),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(company,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13)),
                ),
              
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _descriptionWidget(String description) {
  return SizedBox(
    width: double.infinity,
    height: 36,
    child: Text(
      description,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1,
        color: Color.fromRGBO(116, 130, 148, 1),
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    ),
  );
}

Widget _chipWidget(List<dynamic> typeofEmployment) {
  return Wrap(
    direction: Axis.horizontal,
    spacing: 10,
    runSpacing: 10,
    children: typeofEmployment.map<Widget>((type) {
      return Container(
        height: 21,
        width: 71,
        padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
        decoration: BoxDecoration(
          color: Color.fromRGBO(4, 113, 222, 0.15),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            type.toString() == 'null' ? 'N/A' : type.toString(),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1,
              color: Color.fromRGBO(4, 113, 222, 1),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }).toList(),
  );
}

Widget _jobTimeChip(String time) {
  return Padding(
    padding:  EdgeInsets.only(top: 20),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      height: 19,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 236, 225, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        time,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1,
          color: Color.fromRGBO(255, 112, 0, 1),
        ),
      ),
    ),
  );
}

String? _getShortTime(String createdAt) {
  try {
    return Jiffy.parse(createdAt).fromNow();
  } catch (e) {
    return '';
  }
}
