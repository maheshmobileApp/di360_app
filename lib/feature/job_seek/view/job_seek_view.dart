import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_seek/view/job_seek_card.dart';
import 'package:di360_flutter/feature/job_seek/view/tab_switch.dart';
import 'package:di360_flutter/feature/job_seek/view_model/job_seek_view_model.dart';
import 'package:di360_flutter/feature/talents/views/talents_view.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobSeekView extends StatelessWidget with BaseContextHelpers {
  const JobSeekView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<JobSeekViewModel>(
      builder: (context, jobSeekViewModel, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Jobseek"),
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: getSize(context).height * 0.25,
                child: Image.asset(
                  ImageConst.jobHeaderPng,
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(color: AppColors.geryColor),
              ),
              Expanded(
                  child: jobSeekViewModel.selectedTabIndex == 0
                      ? _buildJobsList(jobSeekViewModel)
                      : TalentsView()),
            ],
          ),
          floatingActionButton: TabSwitch(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildJobsList(JobSeekViewModel vm) {
    return ListView.builder(
      itemCount: vm.jobs.length,
      itemBuilder: (context, index) => InkWell(
          onTap: () {
            navigationService.navigateToWithParams(RouteList.jobdetailsScreen,
                params: vm.jobs[index]);
          },
          child: JobSeekCard(jobsData: vm.jobs[index])),
    );
  }

  Widget _buildTalentsList(JobSeekViewModel vm) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) => JobSeekCard(jobsData: vm.jobs[index]),
    );
  }
}
