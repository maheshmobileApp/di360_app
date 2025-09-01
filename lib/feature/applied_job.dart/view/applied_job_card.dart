import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/applied_job.dart/model/applied_job_respo.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class AppliedJobCard extends StatelessWidget with BaseContextHelpers {
  final AppliedJob appliedJob;
  final int? index;

  const AppliedJobCard({
    super.key,
    required this.appliedJob,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(appliedJob.createdAt ?? '') ?? '';
    final String logoUrl = appliedJob.logo?.isNotEmpty == true
        ? appliedJob.logo!
        : (appliedJob.clinicLogo != null &&
                appliedJob.clinicLogo!.isNotEmpty &&
                appliedJob.clinicLogo!.first is Map<String, dynamic>)
            ? (appliedJob.clinicLogo!.first['url'] ?? '')
            : '';

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color.fromRGBO(220, 224, 228, 1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Top row: logo + title + status
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _logoWithTitle(
                    context,
                    logoUrl,
                    appliedJob.title ?? 'Job Title',
                    appliedJob.companyName ?? 'Company Name',
                  ),
                ),
                _statusChip(appliedJob.status ?? 'Applied'),
              ],
            ),
            addVertical(8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _chipWidget(appliedJob.typeOfEmployment ?? []),
                ),
                const SizedBox(width: 8),
                _appliedJobTimeChip(time),
              ],
            ),
            addVertical(10),
            _descriptionWidget(appliedJob.description ?? ''),
            const Divider(),
            Row(
              children: [
                _roundedButton('Message'),
                const Spacer(),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoWithTitle(
      BuildContext context, String logo, String title, String company) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.geryColor,
          backgroundImage: logo.isNotEmpty ? NetworkImage(logo) : null,
          radius: 22,
          child: logo.isEmpty
              ? const Icon(Icons.business,
                  size: 20, color: AppColors.lightGeryColor)
              : null,
        ),
        addHorizontal(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyles.medium2(color: AppColors.black)),
              addVertical(2),
              Text(company,
                  style: TextStyles.regular2(
                      color: AppColors.bottomNavUnSelectedColor)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _descriptionWidget(String description) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        description.isNotEmpty ? description : "No description provided",
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyles.regular1(
          color: AppColors.bottomNavUnSelectedColor,
        ),
      ),
    );
  }

  Widget _appliedJobTimeChip(String time) {
    return Container(
      height: 19,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(116, 130, 148, 0.0),
            Color.fromRGBO(116, 130, 148, 0.2)
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        time.isNotEmpty ? time : "N/A",
        style: TextStyles.semiBold(fontSize: 10, color: const Color(0xFF1E1E1E)),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color bgColor;
    Color textColor;
    switch (status.toLowerCase()) {
      case "applied":
        bgColor = const Color.fromRGBO(4, 113, 222, 0.1);
        textColor = const Color.fromRGBO(4, 113, 222, 1);
        break;
      case "shortlisted":
        bgColor = const Color.fromRGBO(225, 146, 0, 0.1);
        textColor = const Color.fromRGBO(225, 146, 0, 1);
        break;
      case "accepted":
        bgColor = const Color.fromRGBO(0, 147, 79, 0.1);
        textColor = const Color.fromRGBO(0, 147, 79, 1);
        break;
      case "declined":
        bgColor = const Color.fromRGBO(215, 19, 19, 0.1);
        textColor = const Color.fromRGBO(215, 19, 19, 1);
        break;
      default:
        bgColor = const Color.fromRGBO(253, 245, 229, 1);
        textColor = const Color.fromRGBO(225, 146, 0, 1);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(30)),
      child: Text(status,
          style: TextStyles.semiBold(fontSize: 12, color: textColor)),
    );
  }

  Widget _chipWidget(List<String> types) {
    if (types.isEmpty) return const SizedBox();
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: types.map((type) {
        final label = type.trim().isEmpty ? 'N/A' : type;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.secondaryBlueColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(label,
              style: TextStyles.regular1(
                  fontSize: 12, color: AppColors.primaryBlueColor)),
        );
      }).toList(),
    );
  }

  Widget _roundedButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1E5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(label == "Message" ? Icons.chat : Icons.live_help_outlined,
              size: 18, color: AppColors.primaryColor),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyles.medium1(
                  fontSize: 13, color: AppColors.primaryColor)),
        ],
      ),
    );
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
