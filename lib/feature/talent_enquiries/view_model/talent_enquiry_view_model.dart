import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/talent_enquiries/model/get_talent_enquiry_res.dart';
import 'package:di360_flutter/feature/talent_enquiries/repository/talent_enquiry_repo_impl.dart';
import 'package:di360_flutter/feature/talent_enquiries/repository/talent_enquiry_repository.dart';
import 'package:flutter/material.dart';

class TalentEnquiryViewModel extends ChangeNotifier {
  final TalentEnquiryRepository repo = TalentEnquiryRepoImpl();

  TalentEnquiryData? talentEnquiryData;
  Future<void> getCoursesListingData() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {
      "limit": 5,
      "offset": 0,
      "where": {
        "enquiry_from": {"_eq": userId}
      }
    };
    final res = await repo.getTalentEnquiryData(variables);
    if (res.talentEnquiries != null) {
      talentEnquiryData = res;
    }
    notifyListeners();
  }
}
