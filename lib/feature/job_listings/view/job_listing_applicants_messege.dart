import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/job_listings/model/job_listings_model.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class JobListingApplicantsMessege extends StatefulWidget with BaseContextHelpers {
  final  JobsListingDetails? jobsListingData;
  const JobListingApplicantsMessege({super.key, this.jobsListingData});

  @override
  State<JobListingApplicantsMessege> createState() =>
      _JobListingApplicantsMessegeState();
}

class _JobListingApplicantsMessegeState extends State<JobListingApplicantsMessege> {
  @override
  Widget build(BuildContext context) {
    final jobListingVM = Provider.of<JobListingsViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: _logoWithTitle(
          context,
          widget.jobsListingData?.logo ?? '',
          widget.jobsListingData?.companyName ?? '',
          widget.jobsListingData?.jRole ?? '',
        ),
      
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "8/20/2024",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: jobListingVM.messages.length,
              itemBuilder: (context, index) {
                final message = jobListingVM.messages[index];
                return _buildMessage(message);
              },
            ),
          ),

          _buildInput(jobListingVM),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    if (message.isMe) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE0B2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(message.text, style: TextStyles.regular2(color: Colors.black)),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message.time,
                      style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  const SizedBox(width: 4),
                  Icon(
                    message.status == "read" ? Icons.done_all : Icons.check,
                    size: 14,
                    color: message.status == "read" ? Colors.blue : Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: message.avatarUrl != null
                ? NetworkImage(message.avatarUrl!)
                : null,
            child: message.avatarUrl == null
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message.username ?? "User",
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                  const SizedBox(height: 2),
                  Text(message.text,
                      style: TextStyles.regular2(color: Colors.black)),
                  const SizedBox(height: 4),
                  Text(message.time,
                      style: const TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }

Widget _buildInput(JobListingsViewModel jobListingVM) {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: TextField(
                controller: jobListingVM.messageController,
                textInputAction: TextInputAction.send,
                decoration: const InputDecoration(
                  hintText: "Start typing...",
                  border: InputBorder.none,
                  isDense: true, 
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: () {
                final text = jobListingVM.messageController.text.trim();
                if (text.isNotEmpty) {
                  jobListingVM.messages.add(
                    ChatMessage(
                      text: text,
                      time: "Now",
                      isMe: true,
                      username: "Me",
                      status: "sent",
                    ),
                  );
                  jobListingVM.messageController.clear();
                  setState(() {}); 
                }
              },
            ),
          ),
        ],
      ),
    ),
  );
}
  Widget _logoWithTitle(
    BuildContext context,
    String logo,
    String company,
    String title,
   
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
          
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(company, style: TextStyles.medium2(color: AppColors.black)),
              Text(title, style: TextStyles.regular2(color: AppColors.black)),
            ],
          ),
        ),
      ],
    );
  }
}
