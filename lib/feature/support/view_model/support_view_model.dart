import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/support/model/chat_message_model.dart';
import 'package:di360_flutter/feature/support/model/get_support_request_res.dart';
import 'package:di360_flutter/feature/support/repository/support_repo_impl.dart';
import 'package:flutter/material.dart';

class SupportViewModel extends ChangeNotifier {
  final SupportRepoImpl repo = SupportRepoImpl();
  String selectedTab = "OPEN";

  void setSelectedTab(String tab) {
    selectedTab = tab;
    notifyListeners();
  }

  TextEditingController reasonController = TextEditingController();
  TextEditingController courseNameController = TextEditingController();

  SupportRequestsData? supportRequestsData;

  Future<void> getSupportRequests(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "andList": [
        {
          "_or": [
            {
              "dental_supplier_id": {
                "_eq": userId
              }
            },
            {
              "dental_practice_id": {
                "_eq": userId
              }
            },
            {
              "dental_professional_id": {
                "_eq": userId
              }
            }
          ]
        },
        {
          "status": {"_eq": selectedTab}
        }
      ],
      "limit": 10,
      "offset": 0
    };
    final res = await repo.getSupportRequests(variables);

    if (res != null) {
      supportRequestsData = res;
    }
    notifyListeners();
  }

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
