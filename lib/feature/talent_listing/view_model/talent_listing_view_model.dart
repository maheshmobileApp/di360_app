import 'package:di360_flutter/feature/talent_listing/model/talent_listings_model.dart';
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

  final List<String> statusOptions = [
    "CANCELLED",
    "ENQUIRY",
  ];

  // Selected filters
  String? selectedRole;
  String? selectedEmploymentType;
  String? selectedState;

  void setRole(String val) {
    selectedRole = val;
    notifyListeners();
  }

  void setEmploymentType(String val) {
    selectedEmploymentType = val;
    notifyListeners();
  }

  void setState(String val) {
    selectedState = val;
    notifyListeners();
  }

  void clearSelections() {
    selectedRole = null;
    selectedEmploymentType = null;
    selectedState = null;
    notifyListeners();
  }

  String selectedStatus = 'All';
  final List<String> statuses = [
    'All',
    'Pending',
    'Approval',
    'Rejected',
    'Cancelled',
    'Enquiry',
  ];

  int? AllTalentCount = 0;
  int? PendingCount = 0;
  int? ApprovalCount = 0;
  int? RejectedCount = 0;
  int? CancelledStatusCount = 0;
  int? EnquiryStatusCount = 0;

  Map<String, int?> get statusCountMap => {
        'All': AllTalentCount,
        'Pending': PendingCount,
        'Approval': ApprovalCount,
        'Rejected': RejectedCount,
        'Cancelled': CancelledStatusCount,
        'Enquiry': EnquiryStatusCount,
      };

  List<String>? listingStatus = [];
 List<TalentListingProfiles> myTalentListingList = [];

  void changeStatus(String status, BuildContext context) {
    selectedStatus = status;

    if (status == 'All') {
      listingStatus = [
        "PENDING",
        "APPROVAL",
        "REJECTED",
        "CANCELLED",
        "ENQUIRY",
      ];
    } else if (status == 'Pending') {
      listingStatus = ['PENDING'];
    } else if (status == 'Approval') {
      listingStatus = ["APPROVAL"];
    } else if (status == 'Rejected') {
      listingStatus = ['REJECTED'];
    } else if (status == 'Cancelled') {
      listingStatus = ['CANCELLED'];
    } else if (status == 'Enquiry') {
      listingStatus = ['ENQUIRY'];
    }

    getMyTalentListingData();
    notifyListeners();
  }

Future<void>  fetchTalentStatusCounts() async {
  final res = await repo.talentCounts();
  AllTalentCount = res.data?.all?.aggregate?.count ?? 0;
  PendingCount = res.data?.pending?.aggregate?.count ?? 0;
  ApprovalCount = res.data?.approved?.aggregate?.count ?? 0;
  RejectedCount = res.data?.rejected?.aggregate?.count ?? 0; 
  CancelledStatusCount = res.data?.cancelled?.aggregate?.count ?? 0;
  EnquiryStatusCount = res.data?.enquiry?.aggregate?.count ?? 0;

  notifyListeners();
}



  Future<void> getMyTalentListingData() async {
    final res = await repo.getMyTalentListing(listingStatus);
   fetchTalentStatusCounts();
    if (res != null) {
      myTalentListingList = res;
    }
    notifyListeners();
  }

  void printSelectedItems() {
    debugPrint("Selected Role: $selectedRole");
    debugPrint("Selected Employment Type: $selectedEmploymentType");
    debugPrint("Selected Status: $selectedState");
  }
}
