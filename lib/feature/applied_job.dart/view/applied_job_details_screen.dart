import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/applied_job.dart/model/applied_job_respo.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

class AppliedJobDetailsScreen extends StatelessWidget with BaseContextHelpers {
  final AppliedJob appliedJob;
  const AppliedJobDetailsScreen({
    super.key,
    required this.appliedJob,
  });

  @override
  Widget build(BuildContext context) {
    final Job? job = appliedJob.job;

    final String time = _getShortTime(job?.createdAt ?? '') ?? '';
    final String logoUrl = (job?.clinicLogo != null &&
            job!.clinicLogo!.isNotEmpty &&
            job.clinicLogo!.first.url != null)
        ? job.clinicLogo!.first.url!
        : '';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240.0,
            pinned: true,
            backgroundColor: AppColors.whiteColor,
            iconTheme: const IconThemeData(color: AppColors.black),
            elevation: 0,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final top = constraints.biggest.height;
                final isCollapsed =
                    top <= kToolbarHeight + MediaQuery.of(context).padding.top;
                return FlexibleSpaceBar(
                  centerTitle: false,
                  title: isCollapsed
                      ? Text(
                          "job title",
                          style: TextStyles.medium2(color: AppColors.black),
                        )
                      : null,
                  background: CachedNetworkImageWidget(
                    imageUrl: logoUrl,
                    width: double.infinity,
                  ),
                );
              },
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.whiteColor,
              padding: const EdgeInsets.all(16),
              child: _buildBodyContent(context, job, time, logoUrl),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildBodyContent(BuildContext context, Job? job, String time, String logoUrl) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.geryColor,
            backgroundImage: logoUrl.isNotEmpty ? NetworkImage(logoUrl) : null,
          ),
          addHorizontal(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job?.companyName ?? "", style: TextStyles.medium3(color: AppColors.black)),
                addVertical(4),
                Text( "Job title", style: TextStyles.regular2(color: AppColors.bottomNavUnSelectedColor)),
                addVertical(4),
                Text( "Role", style: TextStyles.regular2(color: AppColors.bottomNavUnSelectedColor)),
                addVertical(6),
                Text(Jiffy.parse(job?.createdAt ?? "").fromNow(), style: TextStyles.medium1(color: AppColors.primaryColor, fontSize: 12)),
              ],
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Enquiry"),
              ),
              addVertical(6),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Apply"),
              ),
            ],
          )
        ],
      ),

      addVertical(16),
      _infoCard(job),

      const Divider(height: 30),
      _sectionHeader("Job Description"),
      _sectionText(job?.description ?? "N/A"),

      const Divider(height: 30),
      _sectionHeader("Key Responsibilities"),
      _sectionText( "N/A"),

      const Divider(height: 30),
      _sectionHeader("About Company"),
      _sectionText(job?.companyName ?? "N/A"),

      const Divider(height: 30),
      _sectionHeader("Job Location"),
      Text(job?.country ?? "N/A", style: TextStyles.regular2(color: AppColors.secondaryColor)),
      locationView(context, job),
    ],
  );
}

Widget _infoCard(Job? job) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.geryColor.withOpacity(0.5)),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      children: [
        _infoRow("Looking for hire", "N/A"),
        _infoRow("Education Level",  "N/A"),
        _infoRow("No. Positions",  "N/A"),
        _infoRow("Rate",  "N/A"),
        _infoRow("Experience", job?.experience ?? ""),
        _infoRow("Salary", job?.salary ?? ""),
        _infoRow("Status", job?.status ?? ""),
      ],
    ),
  );
}

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyles.medium2(
                  color: AppColors.bottomNavUnSelectedColor)),
          Text(value, style: TextStyles.medium2(color: AppColors.black)),
        ],
      ),
    );
  }

  Widget locationView(BuildContext context, Job? job) {
    return GestureDetector(
      onTap: () => _openLocationInMaps(context, job),
      child: Container(
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            ImageConst.mapsPng,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  Future<void> _openLocationInMaps(BuildContext context, Job? job) async {
    if (job?.country == null || job!.country!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location not available',
              style: TextStyles.regular1(color: AppColors.whiteColor)),
          backgroundColor: AppColors.redColor,
        ),
      );
      return;
    }

    final String location = Uri.encodeComponent(job.country!);
    final String googleMapsWeb =
        'https://www.google.com/maps/search/?api=1&query=$location';

    try {
      final Uri webUri = Uri.parse(googleMapsWeb);
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open maps application',
              style: TextStyles.regular1(color: AppColors.whiteColor)),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Text(title, style: TextStyles.medium3(color: AppColors.black)),
    );
  }

  Widget _sectionText(String text) {
    return Text(text,
        style: TextStyles.regular2(color: AppColors.lightGeryColor));
  }
    String? _getShortTime(String createdAt) {
    try {
      if (createdAt.isEmpty) return null;
      return Jiffy.parse(createdAt).fromNow();
    } catch (_) {
      return null;
    }
  }
}
