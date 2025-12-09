import 'dart:io';
import 'package:di360_flutter/common/constants/image_const.dart';
import 'package:di360_flutter/feature/support/model/chat_message_model.dart';
import 'package:di360_flutter/feature/support/view_model/support_view_model.dart';
import 'package:di360_flutter/feature/support/widgets/attachment_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SupportMessengerView extends StatefulWidget {
  const SupportMessengerView({Key? key}) : super(key: key);

  @override
  State<SupportMessengerView> createState() => _TicketChatScreenState();
}

class _TicketChatScreenState extends State<SupportMessengerView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _formatTime(DateTime dt) => DateFormat('hh:mm a').format(dt);
  String _formatDate(DateTime dt) => DateFormat('dd MMM yyyy').format(dt);

  @override
  Widget build(BuildContext context) {
    final supportVM = Provider.of<SupportViewModel>(context);
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
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey, // placeholder color
              ),
            ),
            const SizedBox(width: 12),

            // Name + Ticket no
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "Ticket No : DS21000",
                  style: TextStyle(
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
            Text(
              _formatDate(DateTime.now()),
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                itemCount: supportVM.messages.length,
                itemBuilder: (context, index) {
                  final msg = supportVM.messages[index];
                  if (msg.type == ChatMessageType.text) {
                    return _buildTextBubble(msg);
                  } else {
                    return _buildFileBubble(msg);
                  }
                },
              ),
            ),

            // Bottom input area
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                child: Row(
                  children: [
                    AttachmentPicker(
                      icon: ImageConst.addFeed,
                      onPick: (file) {
                        print("Picked file: ${file.name}");
                        // TODO: upload, show preview, etc
                      },
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
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
                                onSend(supportVM);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: SvgPicture.asset(
                                  ImageConst.addFeed,
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
  }

  Widget _buildTextBubble(ChatMessage msg) {
    final alignment =
        msg.isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor =
        msg.isMine ? const Color(0xFFFFF1E6) : Colors.grey.shade200;
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            msg.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!msg.isMine) const SizedBox(width: 4),
          if (!msg.isMine)
            CircleAvatar(radius: 20, backgroundColor: Colors.grey.shade300),
          if (!msg.isMine) const SizedBox(width: 8),
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
                        msg.text ?? '',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_formatTime(msg.timestamp),
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey[600])),
                          const SizedBox(width: 6),
                          if (msg.isMine)
                            const Icon(Icons.done_all,
                                size: 16, color: Colors.orange),
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

  Future<void> onSend(SupportViewModel supportVM) async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      supportVM.messages.add(ChatMessage.text(
          text: text, isMine: true, timestamp: DateTime.now()));
    });
    _controller.clear();

    await Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}