import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/constants/txt_styles.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/support/model/get_support_messages_res.dart';
import 'package:di360_flutter/feature/support/model/get_support_requests_res.dart'
    hide Attachments;
import 'package:di360_flutter/feature/support/view_model/support_view_model.dart';
import 'package:di360_flutter/feature/support/widgets/media_attachment_widget.dart';
import 'package:di360_flutter/feature/support/widgets/media_view_widget.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SupportMessengerView extends StatefulWidget {
  final SupportRequests? supportRequest;
  const SupportMessengerView({Key? key, this.supportRequest}) : super(key: key);

  @override
  State<SupportMessengerView> createState() => _TicketChatScreenState();
}

class _TicketChatScreenState extends State<SupportMessengerView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final supportVM = Provider.of<SupportViewModel>(context);
    return FutureBuilder<String>(
        future: LocalStorage.getStringVal(LocalStorageConst.type),
        builder: (context, snapshot) {
          final type = snapshot.data ?? '';
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      supportVM.setShowMore(!supportVM.showViewMore);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            supportVM.showViewMore ? "View Less" : "View More",
                            style:
                                TextStyles.medium1(color: AppColors.whiteColor),
                          ),
                        )),
                  ),
                )
              ],
              titleSpacing: 0, // removes default gap
              title: Row(
                children: [
                  // Avatar Circle
                  ClipOval(
                    child: CachedNetworkImageWidget(
                      imageUrl: (type == UserRole.supplier.value)
                          ? widget.supportRequest?.dentalSupplier?.logo?.url ??
                              ""
                          : widget.supportRequest?.dentalProfessional
                                  ?.profileImage?.url ??
                              "",
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
                      errorWidget: Container(
                        width: 42,
                        height: 42,
                        color: Colors.grey,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Name + Ticket no
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (type == UserRole.supplier.value)
                            ? widget.supportRequest?.dentalSupplier
                                    ?.businessName ??
                                ""
                            : (type == UserRole.practice.value)
                                ? widget.supportRequest?.dentalPractice
                                        ?.businessName ??
                                    ""
                                : widget.supportRequest?.dentalProfessional
                                        ?.name ??
                                    "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Ticket No : ${widget.supportRequest?.supportRequestNumber ?? ""}",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          itemCount: supportVM.supportMessagesData
                              ?.supportRequestsConversations?.length,
                          itemBuilder: (context, index) {
                            final msg = supportVM.supportMessagesData
                                ?.supportRequestsConversations?[index];
                            return _buildTextBubble(msg);
                            /*if (msg.type == ChatMessageType.text) {
                          return _buildTextBubble(msg);
                        } else {
                          return _buildFileBubble(msg);
                        }*/
                          },
                        ),
                      ),

                      // Show selected attachment above TextField
                      if (supportVM.selectedAttachments != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  supportVM.selectedAttachments!.extension ==
                                          'pdf'
                                      ? Icons.picture_as_pdf
                                      : Icons.image,
                                  color: Colors.orange,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        supportVM.selectedAttachments!.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '${(supportVM.selectedAttachments!.size / 1024).toStringAsFixed(1)} KB',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    supportVM.setSelectedAttachments(null);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade100,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red.shade700,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: supportVM.messageController,
                                  decoration: InputDecoration(
                                      hintText: "Enter your request...",
                                      border: InputBorder.none,
                                      hintStyle: TextStyles.regular1(
                                          color: AppColors.lightGeryColor)),
                                ),
                              ),
                              GestureDetector(
                                child: Icon(Icons.attachment,
                                    color: AppColors.lightGeryColor),
                                onTap: () {
                                  supportVM.pickFiles();
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  child: Image.asset(ImageConst.sendIcon,
                                      color: AppColors.black),
                                  onTap: () {
                                    if (supportVM.messageController.text
                                            .trim()
                                            .isNotEmpty ||
                                        supportVM.selectedAttachments != null) {
                                      supportVM.sendMessage(context,
                                          widget.supportRequest?.id ?? "");
                                    }
                                  }),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      ),

                      if (supportVM.selectedFiles.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(
                              supportVM.selectedFiles.length,
                              (index) => _buildFilePreview(
                                  supportVM.selectedFiles[index],
                                  index,
                                  supportVM),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (supportVM.showViewMore) _viewMoreOverlay(supportVM),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildFilePreview(
      dynamic file, int index, SupportViewModel supportVM) {
    final extension = file.extension?.toLowerCase();
    return Stack(
      children: [
        Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _getFileIcon(extension),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => supportVM.removeFile(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 14),
            ),
          ),
        )
      ],
    );
  }

  Widget _getFileIcon(String? extension) {
    if (['jpg', 'png', 'jpeg'].contains(extension)) {
      return Icon(Icons.image, size: 30, color: Colors.blue);
    } else if (extension == 'pdf') {
      return Icon(Icons.picture_as_pdf, size: 30, color: Colors.red);
    } else if (['mp4', 'mov', 'avi'].contains(extension)) {
      return Icon(Icons.videocam, size: 30, color: Colors.purple);
    } else {
      return Icon(Icons.insert_drive_file, size: 30, color: Colors.grey);
    }
  }

  Widget _viewMoreOverlay(SupportViewModel supportVM) {
    final req = widget.supportRequest;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Material(
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Support Request Details',
                      style: TextStyles.bold2(color: AppColors.primaryColor)),
                  GestureDetector(
                    onTap: () {
                      supportVM.setShowMore(false);
                    },
                    child: const Icon(Icons.close, size: 18),
                  ),
                ],
              ),
              const Divider(),
              _detailRow('Reason', req?.reason ?? '-'),
              _detailRow('Message', req?.message ?? '-'),
              _detailRow('Created',
                  DateFormatUtils.formatDateTime(req?.createdAt ?? '-')),
              Text('Attachments: ',
                  style: TextStyles.bold2(color: AppColors.primaryColor)),
              MediaAttachmentsWidget(
                mediaList: req?.attachments,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ',
              style: TextStyles.bold2(color: AppColors.primaryColor)),
          Expanded(
              child: Text(value,
                  style: TextStyles.medium2(color: AppColors.black))),
        ],
      ),
    );
  }

  Widget _buildTextBubble(SupportRequestsConversations? msg) {
    final isMine = msg?.senderType != "ADMIN";

    final alignment =
        isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = isMine ? const Color(0xFFFFF1E6) : Colors.grey.shade200;
    final radius = isMine
        ? const BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
            bottomLeft: Radius.circular(14),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
            bottomRight: Radius.circular(14),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMine) const SizedBox(width: 4),
          if (!isMine)
            CircleAvatar(
              backgroundColor: AppColors.whiteColor,
              radius: 20,
              child: SvgPicture.asset(
                ImageConst.logo,
                fit: BoxFit.cover,
              ),
            ),
          if (!isMine) const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: alignment,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: radius,
                  ),
                  child: Column(
                    crossAxisAlignment: alignment,
                    children: [
                      Text(
                        msg?.message ?? '',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      (msg?.attachments != null && msg!.attachments!.isNotEmpty)
                          ? MediaAttachmentsWidget(
                              width: 200,
                              mediaList: msg.attachments,
                              onTap: (list) {
                                navigationService.push(
                                  MediaViewWidget(postImage: list),
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              DateFormatUtils.formatToTime(
                                  msg?.createdAt ?? ""),
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //if (msg.isMine) const SizedBox(width: 8),
          //if (msg.isMine) const SizedBox(width: 4),
        ],
      ),
    );
  }
}
