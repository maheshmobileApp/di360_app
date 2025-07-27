
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';


class JobListingCard extends StatelessWidget with BaseContextHelpers {
  final Jobs? jobsData;
  final JobListingsViewModel vm;
  const JobListingCard({
    super.key,
    required this.jobsData,
    required this.vm,
  });
  @override
  Widget build(BuildContext context) {
    final String time = _getShortTime(jobsData?.createdAt ?? '') ?? '';
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
                    jobsData?.logo ?? '',
                    jobsData?.companyName ?? '',
                    jobsData?.jRole ?? '',
                    time,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildStatusChip(vm.isJobActive(jobsData?.id)),
                    _menuWidget(context, jobsData?.id, vm.isJobActive(jobsData?.id)),
                  ],
                ),
              ],
            ),
           addVertical(10),
            _descriptionWidget(jobsData?.description ?? ''),
             addVertical(12),
            _chipWidget(jobsData?.typeofEmployment ?? []),
         
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4CAF50).withOpacity(0.1) : const Color(0xFF9C27B0).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          fontSize: 12,
          color: isActive ? const Color(0xFF4CAF50) : const Color(0xFF9C27B0),
        ),
      ),
    );
  }
  Widget _menuWidget(BuildContext context, String? jobId, bool isActive) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Color(0xFFB0B0B0)),
      color: Colors.white,
      offset: const Offset(-20, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onSelected: (value) {
        switch (value) {
          case "Preview":
            vm.previewJob(context, jobId);
            break;
          case "Edit":
            vm.editJob(context, jobId);
            break;
          case "Inactive":
            break;
          case "Active":
            break;
          case "Delete":
            break;
        }
      },
      itemBuilder: (context) => [
        _menuItem(Icons.remove_red_eye, Colors.black, "Preview", "Preview"),
        _menuItem(Icons.edit, Colors.blue, "Edit", "Edit"),
        if (isActive)
          _menuItem(Icons.access_time, Colors.orange, "Inactive", "Inactive")
        else
          _menuItem(Icons.check_circle_outline, Colors.green, "Active", "Active"),
        _menuItem(Icons.delete_outline, Colors.red, "Delete", "Delete"),
      ],
    );
  }
  PopupMenuItem<String> _menuItem(IconData icon, Color color, String text, String value) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  Widget _logoWithTitle(BuildContext context, String logo, String company, String title, String time) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          backgroundImage: logo.isNotEmpty ? NetworkImage(logo) : null,
          radius: 20,
          child: logo.isEmpty ? const Icon(Icons.business, size: 20, color: Colors.grey) : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(company, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                  ),
                  _jobTimeChip(time),
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
        style: const TextStyle(
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
    return Container(
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
    );
  }
  String? _getShortTime(String createdAt) {
    try {
      return Jiffy.parse(createdAt).fromNow();
    } catch (e) {
      return '';
    }
  }
}
