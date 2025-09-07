import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/applied_job.dart/view/applied_job_card.dart';
import 'package:di360_flutter/feature/applied_job.dart/view_model.dart/applied_job_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AppliedJobScreen extends StatelessWidget {
  final String dentalProfessionalId;

  const AppliedJobScreen({
    super.key,
    required this.dentalProfessionalId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppliedJobViewModel>(
      create: (_) => AppliedJobViewModel()..fetchAppliedJobs(dentalProfessionalId: dentalProfessionalId),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          title: const Text(
            'Applied Jobs',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Consumer<AppliedJobViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.error != null) {
              return Center(
                child: Text(
                  vm.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (vm.appliedJobs.isEmpty) {
              return const Center(
                child: Text(
                  'No applied jobs found',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              itemCount: vm.appliedJobs.length,
              itemBuilder: (_, index) {
                final job = vm.appliedJobs[index];
                return AppliedJobCard(
                  appliedJob: job,
                  index: index,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
