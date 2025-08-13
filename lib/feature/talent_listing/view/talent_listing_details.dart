import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_profile_response.dart';
import 'package:flutter/material.dart';


class TalentListingDetails extends StatelessWidget with BaseContextHelpers {
  final TalentProfile profile;
  const TalentListingDetails({
    super.key,
    required this.profile,
  });
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Talent Details"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top profile info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: profile.profileImage.isNotEmpty
                      ? NetworkImage(profile.profileImage.first.url)
                      : null,
                  child: profile.profileImage.isEmpty
                      ? const Icon(Icons.person, size: 35)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(profile.fullName,
                          style: TextStyles.bold4(fontSize: 18)),
                      Text(profile.jobDesignation,
                          style: TextStyles.medium3(fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(
                        "Experience: ${profile.yearOfExperience} Years",
                        style: TextStyles.regular1(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    _roundedButton("View CV"),
                    const SizedBox(height: 6),
                    _roundedButton("Enquiry"),
                    const SizedBox(height: 6),
                    _roundedButton("Requested"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            _sectionTitle("Skills"),
            Wrap(
              spacing: 8,
              children: profile.skills?.map((skill) {
                return Chip(
                  label: Text(skill,
                      style: TextStyles.medium1(
                          color: AppColors.primaryColor)),
                  backgroundColor: AppColors.blueColor,
                );
              }).toList() ?? [],
            ),

            const SizedBox(height: 20),
            _sectionTitle("About me / Profile Summary"),
            Text(
              profile.aboutYourself ?? "Not provided",
              style: TextStyles.regular2(color: Colors.black),
            ),

            const SizedBox(height: 20),
            _sectionTitle("Education"),
            ...profile.educations.map((edu) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${edu.qualification} - ${edu.institution}",
                        style: TextStyles.medium3(fontSize: 16)),
                    Text("Graduated: ${edu.finishDate}",
                        style: TextStyles.regular2(color: Colors.grey)),
                  ],
                ),
              );
            }),

            const SizedBox(height: 20),
            _sectionTitle("Work Experience"),
            ...profile.jobExperiences.map((exp) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${exp.jobTitle} at ${exp.companyName}",
                        style: TextStyles.medium3(fontSize: 16)),
                    Text(
                      "${exp.startMonth} ${exp.startYear} - ${exp.stillInRole ? 'Present' : '${exp.endMonth} ${exp.endYear}'}",
                      style: TextStyles.regular2(color: Colors.grey),
                    ),
                    Text(exp.ejobdesp,
                        style: TextStyles.regular2(color: Colors.black)),
                  ],
                ),
              );
            }),

            const SizedBox(height: 20),
            _sectionTitle("Job Location"),
            Text(
              "${profile.location}, ${profile.city}, ${profile.state}, ${profile.country}",
              style: TextStyles.regular2(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(title,
          style: TextStyles.bold4(fontSize: 16, color: Colors.black)),
    );
  }

  Widget _roundedButton(String label) {
    IconData icon = Icons.help_outline;
    if (label == "View CV") icon = Icons.description_outlined;
    if (label == "Enquiry") icon = Icons.message_outlined;
    if (label == "Requested") icon = Icons.check_circle_outline;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1E5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primaryColor),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyles.medium1(color: AppColors.primaryColor)),
        ],
      ),
    );
  }
}
