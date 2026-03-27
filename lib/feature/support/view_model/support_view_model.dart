import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/support/model/chat_message_model.dart';
import 'package:di360_flutter/feature/support/model/get_support_messages_res.dart';
import 'package:di360_flutter/feature/support/model/get_support_request_reasons_res.dart';
import 'package:di360_flutter/feature/support/model/get_support_requests_res.dart';
import 'package:di360_flutter/feature/support/repository/support_repo_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SupportViewModel extends ChangeNotifier {
  final HttpService _http = HttpService();
  final SupportRepoImpl repo = SupportRepoImpl();
  String selectedTab = "Open";
  String? selectedReason;
  String? selectedReasonId;
  List<String> requestReasons = [];
  GetSupportRequestReasonData? supportRequestReasonsList;
  bool showViewMore = false;

  void setShowMore(bool value) {
    showViewMore = value;
    notifyListeners();
  }

  void setSelectedTab(String tab) {
    selectedTab = tab;
    notifyListeners();
  }

  TextEditingController reasonController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool searchBarOpen = false;

  void setSearchBar(bool value) {
    searchBarOpen = value;
    notifyListeners();
  }

  void setSelectedReason(String? reason) {
    selectedReason = reason;
    notifyListeners();
  }

  SupportRequestsData? supportRequestsData;
  GetSupportRequestReasonData? supportRequestReasonsData;
  SupportMessagesData? supportMessagesData;

  int _supportLimit = 10;
  int _supportOffset = 0;

  Future<void> getSupportRequests(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "andList": [
        {
          "_or": [
            {
              "dental_supplier_id": {"_eq": userId}
            },
            {
              "dental_practice_id": {"_eq": userId}
            },
            {
              "dental_professional_id": {"_eq": userId}
            }
          ]
        },
        if (searchController.text.isNotEmpty && searchBarOpen)
          {
            "support_request_number": {"_eq": searchController.text}
          },
        {
          "status": {"_eq": selectedTab == "Open" ? "OPEN" : "CLOSED"}
        }
      ],
      "limit": _supportLimit,
      "offset": _supportOffset
    };
    final res = await repo.getSupportRequests(variables);
    Loaders.circularHideLoader(context);

    if (res.supportRequests != null) {
      supportRequestsData = res;
    }
    notifyListeners();
  }

  Future<void> getSupportRequestsReasons() async {
    print("********************getSupportRequestsReasons calling");
    final variables = {};
    final res = await repo.getSupportRequestsReasons(variables);

    if (res.supportRequestReasons != null) {
      supportRequestReasonsData = res;
      requestReasons = res.supportRequestReasons!
          .map((e) => e.name ?? '')
          .where((name) => name.isNotEmpty)
          .toList();
    }
    notifyListeners();
  }

  Future<void> getSupportMessages(String requestId) async {
    final variables = {"supportRequestId": requestId};
    final res = await repo.getSupportMessages(variables);

    if (res.supportRequestsConversations != null) {
      supportMessagesData = res;
    }
    notifyListeners();
  }

  List uploadedAttachment = [];

  Future<void> sendMessage(BuildContext context, String requestId) async {
    Loaders.circularShowLoader(context);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    for (var element in selectedFiles) {
      var value = await _http.uploadImage(element.path);
      print("resp from upload $value");
      if (value != null) {
        uploadedFiles.add(value);
      }
    }

    final variables = {
      "conversation": {
        "support_request_id": requestId,
        "support_request_number": 0,
        "sender_id": userId,
        "sender_type": type,
        "message": messageController.text,
        "attachments": uploadedFiles,
        "created_at": DateTime.now().toIso8601String()
      }
    };
    final res = await repo.insertMessage(variables);

    if (res != null) {
      Loaders.circularHideLoader(context);
      getSupportMessages(requestId);
      messageController.clear();
      selectedAttachments = null;
      uploadedFiles.clear();
      selectedFiles.clear();
    }
    notifyListeners();
  }

  List uploadedFiles = [];
  Future<void> sendSupportRequest(BuildContext context) async {
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    for (var element in selectedFiles) {
      var value = await _http.uploadImage(element.path);
      print("resp from upload $value");
      if (value != null) {
        uploadedFiles.add(value);
      }
    }
    final variables = {
      "support_request": {
        "reason": selectedReason,
        "message": descriptionController.text,
        "attachments": uploadedFiles,
        "type": "GENERAL",
        if (type == 'SUPPLIER') "dental_supplier_id": userId,
        if (type == 'PRACTICE') "dental_practice_id": userId,
        if (type == 'PROFESSIONAL') "dental_professional_id": userId,
      }
    };
    
    final res = await repo.sendSupportRequest(variables);

    if (res != null) {
      selectedFiles = [];

      await getSupportRequests(context);

      Loaders.circularHideLoader(context);
      scaffoldMessenger('Support request submitted successfully');
      navigationService.goBack();
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
  /***********************Image Upload*********************** */
  List existingImages = [];
  List<PlatformFile> selectedFiles = [];
  PlatformFile? selectedAttachments;

  void setSelectedAttachments(PlatformFile? file) {
    selectedAttachments = file;
    notifyListeners();
  }

  void removeExistingFile(int index) {
    existingImages.removeAt(index);
    notifyListeners();
  }

  void removeFile(int index) {
    selectedFiles.removeAt(index);
    notifyListeners();
  }

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      selectedFiles.addAll(result.files);
      notifyListeners();
    }
  }

  clearData() {
    reasonController.clear();
    selectedReason = null;
    descriptionController.clear();
    selectedFiles.clear();
    existingImages.clear();
    uploadedFiles.clear();
  }
}
