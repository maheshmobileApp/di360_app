import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/job_listings/model/job_applicants_respo.dart';
import 'package:di360_flutter/feature/job_listings/model/job_listing_applicants_messge_respo.dart';
import 'package:di360_flutter/feature/job_listings/view_model/job_listings_view_model.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EnquiryMessagesView extends StatefulWidget
    with BaseContextHelpers {
  final String jobId;
  final String applicantId;
  final String userId;
  final String profilePic;
  final JobApplicants? applicant;
  final String? typeName;

  const EnquiryMessagesView({
    super.key,
    required this.jobId,
    required this.applicantId,
    required this.userId,
    required this.profilePic,
    this.applicant,
    required this.typeName,
  });

  @override
  State<EnquiryMessagesView> createState() =>
      _JobListingApplicantsMessegeState();
}

class _JobListingApplicantsMessegeState
    extends State<EnquiryMessagesView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<JobListingsViewModel>(context, listen: false);
    vm.fetchApplicantMessages(widget.applicantId);
  }

  String formatDateTime(String? time) {
    if (time == null) return "";
    final dateTime = DateTime.tryParse(time);
    if (dateTime == null) return "";
    return DateFormat("dd MMM yyyy, hh:mm a").format(dateTime);
  }

  Widget _buildAvatar(bool isMe) {
    if (isMe) {
      final homeViewModel = Provider.of<HomeViewModel>(context);
      final profileUrl = homeViewModel.profilePic ?? '';
      {
        return CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.geryColor,
          backgroundImage:
              (profileUrl.isNotEmpty) ? NetworkImage(profileUrl) : null,
          child: (profileUrl.isEmpty)
              ? const Icon(Icons.person, color: AppColors.whiteColor)
              : null,
        );
      }
    } else {
      final professional = widget.applicant?.dentalProfessional;
      final profileUrl = professional?.profileImage?.url;
      return CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.geryColor,
        backgroundImage: (profileUrl != null && profileUrl.isNotEmpty)
            ? NetworkImage(profileUrl)
            : null,
        child: (profileUrl == null || profileUrl.isEmpty)
            ? const Icon(Icons.person, color: AppColors.whiteColor)
            : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobListingsViewModel>(
      builder: (context, vm, child) {
        final vm = Provider.of<JobListingsViewModel>(context);
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppbarTitleBackIconWidget(title: 'Messages'),
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
                          final JobApplicantMessage msg = vm.messages[index];
                          final bool isMe = msg.messageFrom == widget.userId;
                          final avatarWidget = _buildAvatar(isMe);

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: isMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: isMe
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (!isMe) avatarWidget,
                                    if (!isMe) const SizedBox(width: 6),
                                    Text(
                                      formatDateTime(msg.createdAt),
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    if (isMe) const SizedBox(width: 6),
                                    if (isMe) avatarWidget,
                                    if (isMe)
                                      _MessegeMenu(
                                          context,
                                          vm,
                                          msg.id ?? "",
                                          widget.applicantId,
                                          vm.messageController.text,
                                          msg.message ?? ""),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: isMe ? 40 : 0,
                                        right: isMe ? 0 : 40,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: isMe
                                            ? Colors.orange[100]
                                            : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        msg.message ?? "",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    if (msg.updatedAt != msg.createdAt)
                                      const Padding(
                                        padding: EdgeInsets.only(top: 2),
                                        child: Text(
                                          "Edited",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
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
                            hintText: "Type a message...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          final text = vm.messageController.text.trim();
                          if (text.isNotEmpty) {
                            if (vm.editMessage) {
                              vm.updateApplicantMessage(
                                  context, widget.applicantId);
                              vm.messageController.clear();
                            } else {
                              vm.sendApplicantMessage(
                                  context, widget.applicantId, text,  widget.typeName != null ? widget.typeName : "");
                              vm.messageController.clear();
                              Future.delayed(const Duration(milliseconds: 200),
                                  () {
                                if (scrollController.hasClients) {
                                  scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                }
                              });
                            }
                          }
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

  Widget _MessegeMenu(BuildContext context, JobListingsViewModel vm, String id,
      String applicantId, String message, String oldMessage) {
    return PopupMenuButton<String>(
      iconColor: Colors.grey,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (value) {
        if (value == "Delete") {
          vm.deleteapplicantMessage(context, id, applicantId, true);
        } else if (value == "Edit") {
          vm.setEditMessage(true);
          vm.setEditMessageDetails(id, vm.messageController.text);
          vm.messageController.text = oldMessage;
          //vm.updateApplicantMessage(context, id, applicantId, message);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "Delete",
          child: _buildRow(Icons.delete, AppColors.redColor, "Delete"),
        ),
        PopupMenuItem(
          value: "Edit",
          child: _buildRow(Icons.edit, AppColors.black, "Edit"),
        ),
      ],
    );
  }

  Widget _buildRow(IconData icon, Color color, String title) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            title,
            style: TextStyles.semiBold(fontSize: 14, color: color),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
