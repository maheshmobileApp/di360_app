import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/talents/model/enquire_request.dart';
import 'package:di360_flutter/feature/talents/model/talents_model.dart';

import 'package:di360_flutter/feature/talents/repository/talent_repo_impl.dart';
import 'package:flutter/material.dart';

class TalentsViewModel extends ChangeNotifier {
  final TalentRepoImpl repo = TalentRepoImpl();
  String? enquiryData;
  TalentsViewModel() {
    fetchTalentProfiles();
  }

  int? _expandedIndex;

  int? get expandedIndex => _expandedIndex;

  void toggleIndex(int index) {
    if (_expandedIndex == index) {
      _expandedIndex = null;
    } else {
      _expandedIndex = index;
    }
    notifyListeners();
  }

  List<JobProfile> talentList = [];

  Future<void> fetchTalentProfiles() async {
    talentList = await repo.getTalentDetails();
    notifyListeners();
  }

  Future<bool> hireMe(HireMeRequest request) async {
    await repo.hireMe(request);
    return true;
  }

  Future<bool> enquire(EnquiryRequest request) async {
    await repo.enquire(request);
    return true;
  }

  void onChangeEnquireData(String data) {
    enquiryData = data;
  }
}
