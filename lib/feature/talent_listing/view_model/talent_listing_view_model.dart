import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_enquiry_listing_response.dart';
//import 'package:di360_flutter/feature/talent_listing/model/talent_listing_response.dart';
import 'package:di360_flutter/feature/talent_listing/repository/talent_listing_repo_impl.dart';
import 'package:di360_flutter/feature/talent_listing/repository/talent_listing_repository.dart';
import 'package:flutter/material.dart';

class TalentListingViewModel extends ChangeNotifier {
  final TalentListingRepository repo = TalentListingRepoImpl();
  final List<String> roleOptions = [
    "Surgen",
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
  String? selectedRole;
  String? selectedEmploymentType;
  void setRole(String val) {
    selectedRole = val;
    notifyListeners();
  }
  void setEmploymentType(String val) {
    selectedEmploymentType = val;
    notifyListeners();
  }
  void clearSelections() {
    selectedRole = null;
    selectedEmploymentType = null;
    notifyListeners();
  }

  // Status filtering
  String selectedStatus = 'All';
  final List<String> statuses = [
    'All',
    'Pending',
    'Approve',
    'Draft',
    'Reject',
    'Expire',
  ];

  // Status counts
  int? AllTalentCount = 0;
  int? PendingCount = 0;
  int? ApprovalCount = 0;
  int? RejectedCount = 0;
  int? DraftCount = 0;
  int? ExpireCount = 0;

  Map<String, int?> get statusCountMap => {
        'All': AllTalentCount,
        'Pending': PendingCount,
        'Approve': ApprovalCount,
        'Reject': RejectedCount,
        'Draft': DraftCount,
        'Expire': ExpireCount,
      };

  List<String> listingStatus = [];
  List<JobProfile> myTalentListingList = [];
  void changeStatus(String status) {
    selectedStatus = status;
    switch (status) {
      case 'All':
        listingStatus = ["PENDING", "APPROVE", "REJECT", "EXPIRE", "DRAFT"];
        break;
      case 'Pending':
        listingStatus = ['PENDING'];
        break;
      case 'Approve':
        listingStatus = ['APPROVE'];
        break;
      case 'Reject':
        listingStatus = ['REJECT'];
        break;
      case 'Draft':
        listingStatus = ['DRAFT'];
        break;
      case 'Expire':
        listingStatus = ['EXPIRE'];
        break;
      default:
        listingStatus = ["PENDING", "APPROVE", "REJECT", "EXPIRE", "DRAFT"];
    }
    getMyTalentListingData();
  }
  Future<void> fetchTalentStatusCounts() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    try {
      final variables = {
        "where": {
          "_and": [
            {"enquiry_from": {"_eq": userId}},
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
      AllTalentCount = PendingCount = ApprovalCount =
          RejectedCount = DraftCount = ExpireCount = 0;
      notifyListeners();
    }
  }

  Future<void> getMyTalentListingData() async {
    try {
      final res = await repo.getMyTalentListing(listingStatus);
      await fetchTalentStatusCounts(); 
      myTalentListingList = res ?? [];
      notifyListeners();
    } catch (e, st) {
      print("Error fetching talent listing: $e\n$st");
      myTalentListingList = [];
      notifyListeners();
    }
  }
  void printSelectedItems() {
    debugPrint("Selected Role: $selectedRole");
    debugPrint("Selected Employment Type: $selectedEmploymentType");
    debugPrint("Selected Status: $selectedStatus"); 
  }
}
