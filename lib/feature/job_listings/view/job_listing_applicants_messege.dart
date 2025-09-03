
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class JobListingApplicantsMessege extends StatefulWidget {
  final String jobId;
  final String applicantId;
  final String userId;

  const JobListingApplicantsMessege({
    super.key,
    required this.jobId,
    required this.applicantId,
    required this.userId,
  });

  @override
  State<JobListingApplicantsMessege> createState() =>
      _JobListingApplicantsMessegeState();
}

class _JobListingApplicantsMessegeState
    extends State<JobListingApplicantsMessege> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<JobListingsViewModel>(context, listen: false);
    vm.fetchApplicantMessages(widget.applicantId);
  

  }



  String formatTime(String? time) {
    if (time == null) return "";
    final dateTime = DateTime.tryParse(time);
    if (dateTime == null) return "";
    return DateFormat("hh:mm a").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<JobListingsViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: vm.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(12),
                        itemCount: vm.messages.length,
                        itemBuilder: (context, index) {

                          final msg = vm.messages[index];
                          final isMe = msg.messageFrom == widget.userId;
                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? Colors.orange[100]
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    msg.message ?? "",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatTime(msg.createdAt),
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              SafeArea(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey.shade300)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: vm.messageController,
                          decoration: const InputDecoration(
                            hintText: "Start typing...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          vm.sendApplicantMessage(
                              context,
                              widget.applicantId,
                              vm.messageController.text.trim());
                          Future.delayed(const Duration(milliseconds: 100), () {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
