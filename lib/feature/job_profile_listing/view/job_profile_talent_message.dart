import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/core/app_mixin.dart';
import 'package:di360_flutter/feature/home/view_model/home_view_model.dart';
import 'package:di360_flutter/feature/job_profile_listing/view_model/job_profile_view_model.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_messages_res.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:di360_flutter/widgets/appbar_title_back_icon_widget.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class JobProfileTalentMessage extends StatefulWidget with BaseContextHelpers {
  final String? id;
  final String? dentalSupplierId;
  final String? dentalPracticeId;
  final String? dentalProfessionalId;
  final String? talentId;
  final String? profilePic;
  final String? userId;
  final String? talentEnquiryId;
  final String? type;

  const JobProfileTalentMessage({
    super.key,
    this.id,
    this.dentalSupplierId,
    this.dentalPracticeId,
    this.dentalProfessionalId,
    this.talentId,
    this.profilePic,
    this.userId,
    this.talentEnquiryId,
  this.type});

  @override
  State<JobProfileTalentMessage> createState() =>
      _JobProfileTalentMessageState();
}

class _JobProfileTalentMessageState extends State<JobProfileTalentMessage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<JobProfileListingViewModel>(context, listen: false);
    vm.fetchTalentMessages(widget.id ?? "", widget.talentEnquiryId ?? "");
  }

  String formatDateTime(String? time) {
    if (time == null) return "";
    final dateTime = DateTime.tryParse(time);
    if (dateTime == null) return "";
    // Convert UTC to local time
    final localDateTime = dateTime.toLocal();
    return DateFormat("dd MMM yyyy, hh:mm a").format(localDateTime);
  }

  Widget _buildAvatar(bool isMe) {
    if (isMe) {
      final homeViewModel = Provider.of<HomeViewModel>(context);
      final profileUrl = homeViewModel.profilePic ?? '';
      {
        return CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.whiteColor,
            child: ClipOval(
              child: CachedNetworkImageWidget(
                  imageUrl: profileUrl,
                  width: 44,
                  height: 44,
                  fit: BoxFit.contain,
                  errorWidget: Image.asset(ImageConst.prfImg)),
            ));
      }
    } else {
      return CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.geryColor,
        child: (widget.profilePic?.isNotEmpty == true)
            ? ClipOval(
                child: CachedNetworkImageWidget(
                  imageUrl: widget.profilePic ?? "",
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
    return Consumer<JobProfileListingViewModel>(
      builder: (context, vm, child) {
        final vm = Provider.of<JobProfileListingViewModel>(context);
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
                        itemCount: vm.messages?.length,
                        itemBuilder: (context, index) {
                          final TalentsMessage msg = vm.messages![index];
                          final bool isMe = msg.senderId == widget.userId;
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
                                      if (msg.deletedStatus == false)
                                        _MessegeMenu(
                                            context,
                                            vm,
                                            msg.id ?? "",
                                            widget.id ?? "",
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
                                        msg.deletedStatus == true
                                            ? "This message has been deleted"
                                            : msg.message ?? "",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    if (msg.deletedStatus == false)
                                      if (msg.updatedAt != msg.createdAt)
                                        const Padding(
                                          padding: EdgeInsets.only(top: 2),
                                          child: Text(
                                            "Edited",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
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
                        onPressed: () async {
                          final text = vm.messageController.text.trim();
                          if (text.isNotEmpty) {
                            if (vm.editMessage) {
                              await vm.updateApplicantMessage(
                                  context,
                                  widget.id ?? "",
                                  widget.talentEnquiryId ?? "");
                              vm.messageController.clear();
                            } else {
                              await vm.sendApplicantMessage(
                                  context,
                                  widget.talentId ?? "",
                                  widget.dentalSupplierId ??
                                      widget.dentalPracticeId ??
                                      widget.dentalProfessionalId ??
                                      "",
                                  widget.dentalSupplierId?.isNotEmpty == true
                                      ? UserRole.supplier.value
                                      : widget.dentalPracticeId?.isNotEmpty ==
                                              true
                                          ? UserRole.practice.value
                                          : UserRole.professional.value,
                                  widget.id ?? "",
                                  widget.talentEnquiryId ?? "",
                                  widget.type ?? "");
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

  Widget _MessegeMenu(
    BuildContext context,
    JobProfileListingViewModel vm,
    String messageId,
    String id,
    String message,
    String oldMessage,
  ) {
    return PopupMenuButton<String>(
      iconColor: Colors.grey,
      color: AppColors.whiteColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (value) {
        if (value == "Delete") {
          vm.deleteapplicantMessage(
              context, messageId, id, widget.talentEnquiryId ?? "");
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
}
