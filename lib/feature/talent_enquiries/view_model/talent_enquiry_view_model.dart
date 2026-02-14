import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/feature/talent_enquiries/model/get_talent_enquiry_res.dart';
import 'package:di360_flutter/feature/talent_enquiries/repository/talent_enquiry_repo_impl.dart';
import 'package:di360_flutter/feature/talent_enquiries/repository/talent_enquiry_repository.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';
import 'package:flutter/material.dart';

class TalentEnquiryViewModel extends ChangeNotifier {
  final TalentEnquiryRepository repo = TalentEnquiryRepoImpl();

  TalentEnquiryData? talentEnquiryData;
  int _talentEnquiryLimit = 10;
  int _talentEnquiryOffset = 0;
  bool isLoadingMoreEnquiries = false;
  bool hasMoreEnquiries = true;

  Future<void> getCoursesListingData({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMoreEnquiries || !hasMoreEnquiries) return;
      isLoadingMoreEnquiries = true;
    } else {
      _talentEnquiryOffset = 0;
      hasMoreEnquiries = true;
    }
    
    notifyListeners();
    
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "limit": _talentEnquiryLimit,
      "offset": _talentEnquiryOffset,
      "where": {
        "enquiry_from": {"_eq": userId}
      }
    };
    final res = await repo.getTalentEnquiryData(variables);
    
    if (loadMore) {
      talentEnquiryData?.talentEnquiries?.addAll(res.talentEnquiries ?? []);
      isLoadingMoreEnquiries = false;
    } else {
      talentEnquiryData = res;
    }
    
    hasMoreEnquiries = (res.talentEnquiries?.length ?? 0) >= _talentEnquiryLimit;
    _talentEnquiryOffset += res.talentEnquiries?.length ?? 0;
    notifyListeners();
  }

  List<JobProfiles> talentEnqPreviewData = [];
  Future<void> getTalentEnqPreviewData(
      BuildContext context, String talentId) async {
    final variables = {"id": talentId};
    final res = await repo.getTalentEnqPreviewData(variables);
    if (res.isNotEmpty) {
      talentEnqPreviewData = res;
    } else {}
    notifyListeners();
  }

  JobProfileEnquiriesResList? talentEnqMessages;
  Future<void> getEnqMessagesData(BuildContext context, String talentId) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "where": {
        "talent_id": {"_eq": talentId},
        "enquiry_from": {"_eq": userId}
      }
    };
    final res = await repo.getEnqMessagesData(variables);
    if (res.talentEnquiries?.isNotEmpty ??false) {
      talentEnqMessages = res;
    } else {}
    notifyListeners();
  }
}
