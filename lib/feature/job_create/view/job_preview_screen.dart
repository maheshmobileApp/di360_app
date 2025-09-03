import 'package:di360_flutter/feature/job_create/view_model.dart/job_create_view_model.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';


class JobPreviewScreen extends StatelessWidget {
  final JobCreateViewModel jobCreateVM;
  const JobPreviewScreen({super.key, required this.jobCreateVM});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Job Preview")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: jobCreateVM.banner_image != null
                      ? FileImage(jobCreateVM.banner_image!)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(jobCreateVM.jobTitleController.text,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const SizedBox(height: 4),
                      Text(jobCreateVM.companyNameController.text,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54)),
                      const SizedBox(height: 4),
                      Text(jobCreateVM.selectedRole ?? '',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueGrey)),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    Jiffy.now().fromNow(),
                    style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --- Job Info Chips ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoChip(Icons.work_outline,
                    '${jobCreateVM.selectExperience ?? "-"}'),
                _infoChip(Icons.school_outlined,
                    jobCreateVM.selectEducation ?? 'NA'),
                _infoChip(Icons.people_outline,
                    jobCreateVM.selectPositions ?? '-'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoChip(Icons.attach_money,
                    '${jobCreateVM.minSalaryController.text} - ${jobCreateVM.maxSalaryController.text}'),
                _infoChip(Icons.access_time, jobCreateVM.selectHire ?? 'NA'),
                _infoChip(Icons.assignment, jobCreateVM.selectRate ?? 'NA'),
              ],
            ),

            const Divider(height: 30),

            // --- Job Description ---
            _sectionHeader('Job Description'),
            _sectionText(jobCreateVM.jobDescController.text),

            const SizedBox(height: 16),

            // --- Responsibilities ---
            _sectionHeader('Key Responsibilities'),
            _sectionText("NA"),

            const SizedBox(height: 16),

            // --- About Company ---
            _sectionHeader('About Company'),
            _sectionText(jobCreateVM.companyNameController.text),
            if (jobCreateVM.websiteController.text.isNotEmpty)
              InkWell(
                onTap: () {},
                child: Text(jobCreateVM.websiteController.text,
                    style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline)),
              ),

            const SizedBox(height: 16),

            // --- Location Section ---
            _sectionHeader('Job Location'),
            Text(
                "${jobCreateVM.locationSearchController.text}, ${jobCreateVM.cityPostCodeController.text}, ${jobCreateVM.stateController.text}, ${jobCreateVM.selectCountry ?? ''}"),

            const SizedBox(height: 16),

            // --- Gallery ---
            _sectionHeader('Gallery'),
            if (jobCreateVM.ClinicPhotofile != null)
              Image.file(jobCreateVM.ClinicPhotofile!,
                  height: 150, width: double.infinity, fit: BoxFit.cover),

            const SizedBox(height: 16),

            // --- Social Media ---
            _sectionHeader('Social Media Handles'),
            Row(
              children: [
                if (jobCreateVM.facebookController.text.isNotEmpty)
                  IconButton(
                      icon: const Icon(Icons.facebook, color: Colors.blue),
                      onPressed: () {}),
                if (jobCreateVM.instgramController.text.isNotEmpty)
                  IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.pink),
                      onPressed: () {}),
                if (jobCreateVM.linkedInController.text.isNotEmpty)
                  IconButton(
                      icon: const Icon(Icons.work, color: Colors.blueAccent),
                      onPressed: () {}),
              ],
            ),

            const SizedBox(height: 20),

            // --- Back Button ---
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Back to Edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Info Chip
  Widget _infoChip(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: Colors.blueGrey),
            const SizedBox(width: 6),
            Flexible(
              child: Text(text,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Header
  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  /// Section Text
  Widget _sectionText(String text) {
    return Text(text.isNotEmpty ? text : "NA",
        style: const TextStyle(fontSize: 14, color: Colors.black87));
  }
}
