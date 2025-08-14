import 'package:di360_flutter/feature/talent_listing/model/talent_profile_response.dart';
import 'package:di360_flutter/feature/talent_listing/repository/talent_listing_repository.dart';
import 'package:di360_flutter/feature/talent_listing/repository/talent_listing_repo_impl.dart';
import 'package:flutter/material.dart';

class TalentListingViewModel extends ChangeNotifier {
  
final TalentListingRepository repo = TalentListingRepoImpl();

List<TalentProfile>? talentProfiles;

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
  final List<String> statuses = [
    'All',
    'Pending',
    'Approval',
    'Rejected',
    'Cancelled',
    'Enquiry',
  ];
  // Selected status
  String selectedStatuscount = 'All';

  String? selectedRole;
  String? selectedEmploymentType;
  String? selectedState;
 // Map of counts for each status (mocked here)
  final Map<String, int> statusCountMap = {
    'All': 10,
    'Pending': 2,
    'Approval': 3,
    'Rejected': 1,
    'Cancelled': 2,
    'Enquiry': 2,
  };
 Future<void> fetchTalentProfiles() async {
  try {
    talentProfiles = await repo.getTalentListings();
    notifyListeners();
  } catch (e) {
    debugPrint("Failed to load profiles: $e");
  }
}
 void changeStatus(String status, BuildContext context) {
     selectedStatuscount = status;
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
    selectedState = val;
    notifyListeners();
  }

  void clearSelections() {
    selectedRole = null;
    selectedEmploymentType = null;
     selectedState = null;
    notifyListeners();
  }

  void printSelectedItems() {
    debugPrint("Selected Role: \$selectedRole");
    debugPrint("Selected Employment Type: \$selectedEmploymentType");
    debugPrint("Selected Status: \$selectedState");
  }
}
