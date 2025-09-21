import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/talents/model/enquire_request.dart';
import '../../talents/model/job_profile.dart';
import 'package:di360_flutter/feature/talents/repository/talent_repo_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class TalentsViewModel extends ChangeNotifier {
  final TalentRepoImpl repo = TalentRepoImpl();
  String? enquiryData;

  TalentsViewModel();

  int? _expandedIndex;
  int? get expandedIndex => _expandedIndex;
  bool isShowBottomeActions = false;

  List<JobProfile> talentList = [];

  void toggleIndex(int index) {
    if (_expandedIndex == index) {
      _expandedIndex = null;
    } else {
      _expandedIndex = index;
    }
    notifyListeners();
  }

 isShowBottomeActionss(String professionalId) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    isShowBottomeActions = userId == professionalId;
    notifyListeners();// Suppliers,practice owener show the action button 

  }

  Future<void> fetchTalentProfiles(BuildContext context) async {
    Loaders.circularShowLoader(context);

    try {
      talentList = await repo.getTalentDetails();
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
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
