import 'package:di360_flutter/feature/talents/model/talents_model.dart';

import 'package:di360_flutter/feature/talents/repository/talent_repo_impl.dart';
import 'package:flutter/material.dart';

class TalentsViewModel extends ChangeNotifier {
  final TalentRepoImpl repo = TalentRepoImpl();
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
}
