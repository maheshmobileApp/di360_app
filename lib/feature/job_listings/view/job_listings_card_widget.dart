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
import 'package:provider/provider.dart';

class JobListingCard extends StatelessWidget with BaseContextHelpers {
  final JobsListingDetails? jobsListingData;
  final JobListingsViewModel vm;
  final dynamic parmas;
  final int? index;

  const JobListingCard({
    super.key,
    required this.jobsListingData,
    required this.vm,
    this.index,
    this.parmas,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JobListingsViewModel>(context);
    final String time = _getShortTime(jobsListingData?.createdAt ?? '') ?? '';
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              border: Border(
                left: BorderSide(
                    color: Color.fromRGBO(220, 224, 228, 1), width: 1),
                right: BorderSide(
                    color: Color.fromRGBO(220, 224, 228, 1), width: 1),
                top: BorderSide(
                    color: Color.fromRGBO(220, 224, 228, 1), width: 1),
              ),
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
                        jobsListingData?.title ?? '',
                        jobsListingData?.companyName ?? '',
                        jobsListingData?.status ?? '',

                      ),
                    ),
                    Row(
                      children: [
                        _jobTimeChip(time),
                        addHorizontal(4),
                        menuWidget(
                          vm,
                          context,
                          index!,
                          jobsListingData?.id ?? '',
                          jobsListingData?.status ?? '',
                        ),
                      ],
                    ),
                  ],
                ),
                addVertical(12),
                _chipWidget(jobsListingData?.typeofEmployment ?? []),
                addVertical(10),
                _descriptionWidget(jobsListingData?.description ?? ''),
                const Divider(),

              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(116, 130, 148, 0.15),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: () async {
                viewModel.jobId = jobsListingData?.id ?? '';
                await viewModel.getMyJobApplicantsgData(
                    context, jobsListingData?.id ?? '');
                navigationService.navigateToWithParams(
                  RouteList.JobListingApplicantscreen,
                  params: jobsListingData
                );
              },
              child: Center(
                child: Text(
                  "${jobsListingData?.jobApplicantsAggregate?.aggregate?.count ?? 0} Applicants applied for this role",
                  style: TextStyles.medium1(color: AppColors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoWithTitle(
    BuildContext context,
    String logo,
    String company,
    String title,
    String status,

  ) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.geryColor,
              backgroundImage: logo.isNotEmpty ? NetworkImage(logo) : null,
              radius: 30,
              child: logo.isEmpty
                  ? const Icon(Icons.business,
                      size: 20, color: AppColors.lightGeryColor)
                  : null,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(229, 244, 237, 1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.whiteColor, width: 1),
                ),
                child: Text(
                   status,
                  style: TextStyles.medium1(
                    color: AppColors.greenColor,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        addHorizontal(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(company, style: TextStyles.medium2(color: AppColors.black)),
              addVertical(2),
              Text(title, style: TextStyles.regular2(color: AppColors.black)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _descriptionWidget(String description) {
    return SizedBox(
      // height: 36,
      width: double.infinity,
      child: Text(
        description,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.regular1(color: AppColors.bottomNavUnSelectedColor),
      ),
    );
  }

  Widget _chipWidget(List<dynamic> types) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: types.map((type) {
        final label = type?.toString() == 'null' ? 'N/A' : type.toString();
        return Container(
          height: 21,
          width: 71,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.secondaryBlueColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyles.regular1(
                color: AppColors.primaryBlueColor,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _jobTimeChip(String time) {
    return Container(
      height: 19,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(255, 241, 229, 0),
            Color.fromRGBO(255, 241, 229, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.centerRight,
      child: Text(
        time,
        textAlign: TextAlign.right,
        style: TextStyles.semiBold(
            fontSize: 10, color: Color.fromRGBO(255, 112, 0, 1)),
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
        showAlertMessage(context, 'Do you really want to activate this job?',
            onBack: () {
          navigationService.goBack();
            vm.updateJobListingStatus(context, id, "INACTIVE");
        });
      } else if (value == "Preview") {
        navigationService.navigateToWithParams(
          RouteList.JobListingDetailsScreen,
          params: vm.myJobListingList[index],
        );
      } else if (value == "Inactive") {
        showAlertMessage(context, 'Do you really want to deactivate this job?',
            onBack: () {
          navigationService.goBack();
          vm.updateJobListingStatus(context, id, "REJECTED");
        });
      } else if (value == "Delete") {
        showAlertMessage(context, 'Are you sure you want to delete this job?',
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
        child: _buildRow(Icons.edit_outlined, AppColors.blueColor, "Edit"),
      ),
      PopupMenuItem(
        value: "Delete",
        child: _buildRow(Icons.delete_outline, AppColors.redColor, "Delete"),
      ),

      if (status == "APPROVE" )
        PopupMenuItem(
          value: "Inactive",
          child: _buildRow(Icons.nightlight_outlined, AppColors.primaryColor, "Inactive"),
        ),
      if (status == "REJECT")
        PopupMenuItem(
          value: "Active",
          child: _buildRow(Icons.nightlight_outlined, AppColors.primaryColor, "Active"),
        ),
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

  PopupMenuItem<String> _popupItem(String label, IconData icon, Color color) {
    return PopupMenuItem(
      value: label,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          addHorizontal(8),
          Text(label, style: TextStyles.semiBold(color: color, fontSize: 14)),
        ],
      ),
    );
  }

  String? _getShortTime(String createdAt) {
    try {
      return Jiffy.parse(createdAt).fromNow();
    } catch (_) {
      return '';
    }
  }
}
