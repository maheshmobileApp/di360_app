import 'dart:io';
import 'package:di360_flutter/common/constants/app_colors.dart';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/support/model/chat_message_model.dart';
import 'package:di360_flutter/feature/support/model/get_support_messages_res.dart';
import 'package:di360_flutter/feature/support/model/get_support_requests_res.dart';
import 'package:di360_flutter/feature/support/view_model/support_view_model.dart';
import 'package:di360_flutter/feature/support/widgets/attachment_picker.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/date_utils.dart';
import 'package:di360_flutter/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SupportMessengerView extends StatefulWidget {
  final SupportRequests? supportRequest;
  const SupportMessengerView({Key? key, this.supportRequest}) : super(key: key);

  @override
  State<SupportMessengerView> createState() => _TicketChatScreenState();
}

class _TicketChatScreenState extends State<SupportMessengerView> {
  final ScrollController _scrollController = ScrollController();

  String _formatTime(DateTime dt) => DateFormat('hh:mm a').format(dt);
  String _formatDate(DateTime dt) => DateFormat('dd MMM yyyy').format(dt);

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
              titleSpacing: 0, // removes default gap
              title: Row(
                children: [
                  // Avatar Circle
                  ClipOval(
                    child: CachedNetworkImageWidget(
                      imageUrl: (type == "SUPPLIER")
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
                        (type == "SUPPLIER")
                            ? widget.supportRequest?.dentalSupplier
                                    ?.businessName ??
                                ""
                            : widget.supportRequest?.dentalProfessional?.name ??
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
              child: Column(
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
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                              supportVM.selectedAttachments!.extension == 'pdf' ? Icons.picture_as_pdf : Icons.image,
                              color: Colors.orange,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                supportVM.selectedAttachments = null;
                                supportVM.notifyListeners();
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

                  // Bottom input area
                  Padding(
                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                      child: Row(
                        children: [
                          AttachmentPicker(
                            icon: ImageConst.attachment,
                            onPick: (file) {
                              supportVM.setSelectedAttachments(file);
                            },
                          ),
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: supportVM.messageController,
                                      decoration: const InputDecoration(
                                        hintText: 'Start typing...',
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 12),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (supportVM.messageController.text.trim().isNotEmpty || 
                                          supportVM.selectedAttachments != null) {
                                        supportVM.sendMessage(
                                            widget.supportRequest?.id ?? "");
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: SvgPicture.asset(
                                        ImageConst.send,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
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
                      (msg?.attachments != null &&
                              msg!.attachments!.isNotEmpty)
                          ?
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF6F0),
                          borderRadius: radius,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon((msg.attachments?.first.type!="image")?Icons.picture_as_pdf:Icons.image,
                                      color: Colors.orange, size: 30),
                                  Text(msg.attachments?.first.name ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 6),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final attachment = msg.attachments?.first;
                                if (attachment?.url != null && attachment?.name != null) {
                                  
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Download',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(width: 8),
                                    Icon(Icons.file_download,
                                        color: Colors.white, size: 18),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ): const SizedBox.shrink(),
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

  Widget _buildFileBubble(ChatMessage msg) {
    // File card style similar to reference image
    final alignment =
        msg.isMine ? MainAxisAlignment.end : MainAxisAlignment.start;
    final radius = msg.isMine
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
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          if (!msg.isMine) const SizedBox(width: 8),
          if (!msg.isMine)
            CircleAvatar(radius: 14, backgroundColor: Colors.grey.shade300),
          Flexible(
            child: Column(
              crossAxisAlignment: msg.isMine
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF6F0),
                    borderRadius: radius,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(msg.fileName ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 6),
                            Text(msg.fileSize ?? '',
                                style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 10),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(_formatTime(msg.timestamp),
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[700])),
                                  const SizedBox(width: 6),
                                  if (msg.isMine)
                                    const Icon(Icons.done_all,
                                        size: 16, color: Colors.orange),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO: implement download
                          // For preview, try opening local file path if exists
                          final path = msg.filePath;
                          if (path != null) {
                            final file = File(path);
                            if (file.existsSync()) {
                              // In a real app you'd launch or save file
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('File exists (preview)')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('File not found')));
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Download',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 8),
                              Icon(Icons.file_download,
                                  color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
