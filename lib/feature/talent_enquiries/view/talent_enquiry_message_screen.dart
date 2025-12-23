/*import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/job_listings/model/job_applicants_respo.dart';
import 'package:di360_flutter/feature/talent_enquiries/view_model/talent_enquiry_view_model.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_messages_res.dart';
import 'package:di360_flutter/feature/talent_listing/view_model/talent_listing_view_model.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TalentEnquiryMessageScreen extends StatefulWidget
    with BaseContextHelpers {
  final String jobId;
  final String applicantId;
  final String userId;
  final String profilePic;
  final JobApplicants? applicant;
  final String? typeName;

  const TalentEnquiryMessageScreen({
    super.key,
    required this.jobId,
    required this.applicantId,
    required this.userId,
    required this.profilePic,
    this.applicant,
    required this.typeName,
  });

  @override
  State<TalentEnquiryMessageScreen> createState() =>
      _TalentListingMessageScreenState();
}

class _TalentListingMessageScreenState
    extends State<TalentEnquiryMessageScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<TalentEnquiryViewModel>(context, listen: false);
    vm.fetchTalentEnqMessages(widget.applicantId);
  }

  Widget _buildAvatar(bool isMe) {
    if (isMe) {
      final homeViewModel = Provider.of<HomeViewModel>(context);
      final profileUrl = homeViewModel.profilePic ?? '';
      {
        return CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.geryColor,
          child: (profileUrl.isNotEmpty)
              ? ClipOval(
                  child: CachedNetworkImageWidget(
                    imageUrl: profileUrl,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(Icons.person, color: AppColors.whiteColor),
        );
      }
    } else {
      final professional = widget.applicant?.dentalProfessional;
      final profileUrl = professional?.profileImage?.url;
      return CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.geryColor,
        child: (profileUrl != null && profileUrl.isNotEmpty)
            ? ClipOval(
                child: CachedNetworkImageWidget(
                  imageUrl: profileUrl,
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              )
            : const Icon(Icons.person, color: AppColors.whiteColor),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TalentListingViewModel>(
      builder: (context, vm, child) {
        final vm = Provider.of<TalentEnquiryViewModel>(context);
        final messages = vm.talentMessages?.talentsMessage;
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
                        itemCount: messages?.length ?? 0,
                        itemBuilder: (context, index) {
                          final TalentsMessage? msg = messages?[index];
                          final bool isMe = msg?.messageFrom == widget.userId;
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
                                      DateFormatUtils.formatDateTime(msg?.createdAt??""),
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
                                          msg?.id ?? "",
                                          widget.applicantId,
                                          vm.messageController.text,
                                          msg?.message ?? ""),
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
                                        msg?.message ?? "",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    /*if (msg?.updatedAt != msg?.createdAt)
                                      const Padding(
                                        padding: EdgeInsets.only(top: 2),
                                        child: Text(
                                          "Edited",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ),*/
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
                          print("send icon clicking********************");
                          final text = vm.messageController.text.trim();
                          if (text.isEmpty) {
                            scaffoldMessenger("Message cannot be empty");
                            return;
                          }
                          if (vm.editMessage) {
                            vm.updateTalentMessage(context, widget.applicantId);
                            vm.messageController.clear();
                          } else {
                            vm.sendTalentMessage(
                                context,
                                widget.jobId,
                                widget.applicantId,
                                text,
                                widget.typeName != null ? widget.typeName : "");
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

  Widget _MessegeMenu(BuildContext context, TalentListingViewModel vm,
      String messageId, String applicantId, String message, String oldMessage) {
    return PopupMenuButton<String>(
      iconColor: Colors.grey,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (value) {
        if (value == "Delete") {
          vm.deleteTalentMessage(context, messageId, applicantId);
        } else if (value == "Edit") {
          vm.setEditMessage(true);
          vm.setEditMessageDetails(messageId, vm.messageController.text);
          vm.messageController.text = oldMessage;
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
}*/
