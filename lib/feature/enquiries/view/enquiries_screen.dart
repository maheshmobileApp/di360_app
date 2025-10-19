import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/feature/applied_job.dart/view_model.dart/applied_job_view_model.dart';
import 'package:di360_flutter/feature/enquiries/view/enquiries_card.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnquiriesScreen extends StatelessWidget {
  const EnquiriesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppliedJobViewModel>(
      create: (_) => AppliedJobViewModel()..fetchAppliedJobs(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppbarTitleBackIconWidget(title: 'Enquiries'),
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
                  'No Enquiries found',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              itemCount: vm.appliedJobs.length,
              itemBuilder: (_, index) {
                final job = vm.appliedJobs[index];
                return EnquiriesCard(
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
