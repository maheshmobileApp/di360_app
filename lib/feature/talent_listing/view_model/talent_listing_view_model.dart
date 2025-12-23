import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/get_hiring_talent_list_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_messages_res.dart';
import 'package:di360_flutter/feature/talent_listing/repository/talent_listing_repo_impl.dart';
import 'package:di360_flutter/feature/talent_listing/repository/talent_listing_repository.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class TalentListingViewModel extends ChangeNotifier {
  final TalentListingRepository repo = TalentListingRepoImpl();
  final List<String> roleOptions = [
    "Surgeon",
    "Dentist",
    "Dental Hygienist",
    "Dental Prosthetist",
    "Dental Specialist",
  ];
  final List<String> employmentTypeOptions = [
    "Contractor",
    "Temporary Contractor",
    "Locum",
    "Full Time",
    "Part time",
  ];
  final List<String> StatusOptions = ["APPROVE", "CANCELLED", "PENDING"];
  String? selectedRole;
  String? selectedEmploymentType;
  String? selectedState;
  JobProfileEnquiriesResList? talentEnquiryData;
  bool isLoading = false;
  TalentsMessageResData? talentMessages;
  TextEditingController messageController = TextEditingController();

  bool editMessage = false;
  bool removeIcon = false;

  void setRemoveIcon(bool value) {
    editMessage = value;
    notifyListeners();
  }

  void setEditMessage(bool value) {
    editMessage = value;
    notifyListeners();
  }

  void setRole(String val) {
    selectedRole = val;
    notifyListeners();
  }

  void setEmploymentType(String val) {
    selectedEmploymentType = val;
    notifyListeners();
  }

  void setState(String val) {
    listingStatus = val;
    selectedState = val;
    notifyListeners();
  }

  void clearSelections() {
    listingStatus = "";
    selectedRole = null;
    selectedEmploymentType = null;
    selectedState = null;
    notifyListeners();
  }

  // Status filtering
  String selectedStatus = 'All';
  final List<String> statuses = [
    'All',
    'Pending',
    'Interested',
    'Not Interested',
    'Cancelled'
  ];

  // Status counts
  int? AllTalentCount = 0;
  int? PendingCount = 0;
  int? ApprovalCount = 0;
  int? RejectedCount = 0;
  int? DraftCount = 0;
  int? ExpireCount = 0;
  int? InterestedCount = 0;
  int? NotInterestedCount = 0;
  int? CancelledCount = 0;

  Map<String, int?> get statusCountMap => {
        'All': AllTalentCount,
        'Pending': PendingCount,
        'Interested': InterestedCount,
        'Not Interested': NotInterestedCount,
        'Cancelled': CancelledCount,
      };

  String listingStatus = '';
  HiringTalentList? myTalentListingList;
  void changeStatus(String status) {
    selectedStatus = status;
    switch (status) {
      case 'All':
        listingStatus = '';
        break;
      case 'Pending':
        listingStatus = 'PENDING';
        break;
      case 'Approve':
        listingStatus = 'APPROVE';
        break;
      case 'Reject':
        listingStatus = 'REJECT';
        break;
      case 'Draft':
        listingStatus = 'DRAFT';
        break;
      case 'Expire':
        listingStatus = 'EXPIRE';
        break;
      case 'Interested':
        listingStatus = 'APPROVE';
      case 'Not Interested':
        listingStatus = 'REJECT';
      case 'Cancelled':
        listingStatus = 'CANCELLED';
      default:
        listingStatus = "";
    }
    getMyTalentListingData();
  }

  Future<void> fetchTalentStatusCounts() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    try {
      final variables = {
        "where": {
          "_and": [
            {
              "enquiry_from": {"_eq": userId}
            },
            {
              "job_profiles": {
                "admin_status": {
                  "_in": ["REJECT", "APPROVE", "PENDING", "DRAFT", "EXPIRE"]
                }
              }
            }
          ]
        }
      };
      final res = await repo.getTalentEnquiryCounts(variables);
      final data = res.data;
      AllTalentCount = data?.total?.aggregate?.count ?? 0;
      PendingCount = data?.pending?.aggregate?.count ?? 0;
      ApprovalCount = data?.approved?.aggregate?.count ?? 0;
      RejectedCount = data?.rejected?.aggregate?.count ?? 0;
      DraftCount = data?.draft?.aggregate?.count ?? 0;
      ExpireCount = data?.expired?.aggregate?.count ?? 0;
      notifyListeners();
    } catch (e, st) {
      print('Error in fetchTalentStatusCounts: $e\n$st');
      AllTalentCount = 0;
      PendingCount = 0;
      ApprovalCount = 0;
      RejectedCount = 0;
      DraftCount = 0;
      ExpireCount = 0;
      notifyListeners();
    }
  }

  Future<void> fetchTalentListingStatusCounts() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    try {
      final variables = {
        "where": {
          "dental_supplier_id": {"_eq": userId}
        }
      };
      print("***************************variables: $variables");
      final res = await repo.getTalentListingStatusCounts(variables);
      final data = res;
      AllTalentCount = data.all?.aggregate?.count ?? 0;
      PendingCount = data.pending?.aggregate?.count ?? 0;
      InterestedCount = data.approve?.aggregate?.count ?? 0;
      NotInterestedCount = data.rejected?.aggregate?.count ?? 0;
      CancelledCount = data.cancelled?.aggregate?.count ?? 0;
      notifyListeners();
    } catch (e, st) {
      print('Error in fetchTalentListingStatusCounts: $e\n$st');
      AllTalentCount = 0;
      PendingCount = 0;
      InterestedCount = 0;
      NotInterestedCount = 0;
      CancelledCount = 0;
      notifyListeners();
    }
  }

  Future<void> getMyTalentListingData() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    print("talents calling");

    final List<Map<String, dynamic>> whereConditions = [
      {
        "dental_supplier_id": {"_eq": userId}
      }
    ];

    if (listingStatus != "" && listingStatus.isNotEmpty) {
      whereConditions.add({
        "hiring_status": {"_eq": listingStatus}
      });
    }

    if (selectedRole != null && selectedRole!.isNotEmpty) {
      whereConditions.add({
        "job_profiles": {
          "profession_type": {"_ilike": "%$selectedRole%"}
        }
      });
    }

    if (selectedEmploymentType != null && selectedEmploymentType!.isNotEmpty) {
      whereConditions.add({
        "job_profiles": {
          "work_type": {"_contains": selectedEmploymentType}
        }
      });
    }

    final variables = {
      "where": {"_and": whereConditions},
      "limit": 10,
      "offset": 0
    };
    try {
      await fetchTalentListingStatusCounts();
      final res = await repo.getMyTalentListing(variables);
      myTalentListingList = res;
      notifyListeners();
    } catch (e, st) {
      print("Error fetching talent listing: $e\n$st");
      myTalentListingList = null;
      notifyListeners();
    }
  }

  void printSelectedItems() {
    debugPrint("Selected Role: $selectedRole");
    debugPrint("Selected Employment Type: $selectedEmploymentType");
    debugPrint("Selected Status: $selectedStatus");
  }

  Future<JobProfileEnquiriesResList?> getTalentEnquiry(
      BuildContext context, String talentId) async {
    Loaders.circularShowLoader(context);
    final res = await repo.getTalentEnquiry(talentId);
    if (res != null) {
      talentEnquiryData = res;
      print("***********************talent enquiries data: $talentId");
      print("***********************talent enquiries data: $talentEnquiryData");
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
    return res;
  }

  Future<TalentsMessageResData?> fetchTalentMessages(String talentId) async {
    print("**********************************fetch talent message calling");
    try {
      isLoading = true;
      final res = await repo.fetchTalentMessages(talentId);
      if (res != null) {
        talentMessages = res;
      }
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
      return talentMessages;
    }
  }

  String newmessage = "";
  String editMessageId = "";

  void setEditMessageDetails(String id, String message) {
    editMessageId = id;
    newmessage = message;
    notifyListeners();
  }

  Future<void> updateTalentMessage(
      BuildContext context, String talentId) async {
    print("update talent message calling");

    try {
      isLoading = true;

      final res =
          await repo.updateTalentMessage(editMessageId, messageController.text);
      if (res != null) {
        setEditMessage(false);
        await fetchTalentMessages(talentId);
        scaffoldMessenger("Message updated successfully");
      }
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTalentMessage(
      BuildContext context, String messageId, String applicantId) async {
    try {
      isLoading = true;
      final variables = {"id": messageId, "deleted_status": true};

      final res = await repo.deleteTalentMessage(variables);
      if (res != null) {
        setEditMessage(false);
        await fetchTalentMessages(applicantId);
        scaffoldMessenger("Message deleted successfully");
      }
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> sendTalentMessage(
      BuildContext context,
      String talentMessageId,
      String talentId,
      String message,
      String? typeName) async {
    print("send talent message calling");
    try {
      Loaders.circularShowLoader(context);
      final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);

      final variables = {
        "object": {
          "message": message,
          "talent_message_id_to": talentMessageId,
          "message_from": userId,
          "talent_id": talentId
        }
      };

      final res = await repo.sendTalentMessage(variables);

      if (res != null) {
        scaffoldMessenger("Message sent successfully");
        messageController.clear();

        fetchTalentMessages(talentId);
      } else {
        scaffoldMessenger("Failed to send message");
      }
    } catch (e) {
      scaffoldMessenger("Error: $e");
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  /**************Talent Listing********************* */
  List<JobProfiles> talentPreviewData = [];
  Future<void> getTalentPreviewData(
      BuildContext context, String profileId, String professionType) async {
    final variables = {
      "profession_type": professionType,
      "limit": 10,
      "offset": 0,
      "excludeId": profileId
    };
    final res = await repo.getTalentPreviewData(variables);
    if (res.isNotEmpty) {
      talentPreviewData = res;
    } else {}
    notifyListeners();
  }

  Future<void> updateTalentListingStatus(
      BuildContext context, String talentId) async {
    final variables = {"id": talentId, "status": "CANCELLED"};
    final res = await repo.updateTalentListing(variables);
    if (res.isNotEmpty) {
      scaffoldMessenger("Talent Cancelled Successfully");
    } else {}
    notifyListeners();
  }
}
