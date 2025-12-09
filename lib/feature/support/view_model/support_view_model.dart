import 'package:di360_flutter/feature/support/model/chat_message_model.dart';
import 'package:flutter/material.dart';

class SupportViewModel extends ChangeNotifier {
  String selectedTab = "Open";

  void setSelectedTab(String tab) {
    selectedTab = tab;
    notifyListeners();
  }

  TextEditingController reasonController = TextEditingController();
  TextEditingController courseNameController = TextEditingController();

   final List<ChatMessage> messages = [
    ChatMessage.text(
      text: 'Hi 👋',
      isMine: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    ChatMessage.text(
      text: 'I have an issue with auto renewal',
      isMine: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
    ),
    ChatMessage.text(
      text: "I'm happy to assist you",
      isMine: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
    ),
    ChatMessage.file(
      fileName: 'My documents.Pdf',
      fileSize: '487 KB',
      filePath: '/mnt/data/bdf76386-c9b3-4739-a299-b0568483773b.png',
      isMine: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
    ),
  ];
}
