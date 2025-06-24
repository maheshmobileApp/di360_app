import 'package:di360_flutter/feature/talents/model/talents_model.dart';

import 'package:di360_flutter/feature/talents/repository/talent_repo_impl.dart';
import 'package:flutter/material.dart';

class TalentsViewModel extends ChangeNotifier {
  final TalentRepoImpl repo = TalentRepoImpl();
  TalentsViewModel() {
    fetchTalentProfiles();
  }
  List<JobProfile> talentList = [];
  Future<void> fetchTalentProfiles() async {
    talentList = await repo.getTalentDetails();
    notifyListeners();
  }
}
