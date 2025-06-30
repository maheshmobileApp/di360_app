import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_seek/model/job_model.dart';
import 'package:di360_flutter/feature/job_seek/repository/job_seek_repo.dart';

import 'package:di360_flutter/feature/job_seek/repository/job_seek_repo_impl.dart';
import 'package:flutter/material.dart';

class JobSeekViewModel extends ChangeNotifier {
  final JobSeekRepository repo = JobSeekRepoImpl(); // 👈 Create repo here

  JobSeekViewModel() {
    fetchJobs();
  }
  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  // void setSelectedIndex(int index) {
  //   if (_selectedTabIndex != index) {
  //     _selectedTabIndex = index;
  //     notifyListeners();
  //   }
  // }

  bool isHidleFolatingButton = false;
  void toggleFloatingButtonVisibility() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    switch (type) {
      case "PROFESSIONAL":
        // professional will only see JOb ( cant see talents) no floating
        isHidleFolatingButton = true; // Dental Professional
        break;
      case "SUPPLIER":
        isHidleFolatingButton = false; // Dental Business Owner
        break;
      case "PRACTICE":
        isHidleFolatingButton = false; // Dental Practice Owner
        break;
      default:
        isHidleFolatingButton = true; //
    }
    //Dental Professional
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }
  // Dummy Data

  List<Jobs> jobs = [];
  Future<void> fetchJobs() async {
    var jobData = await repo.getPopularJobs();
    jobs = jobData.jobs ?? [];
    notifyListeners();
  }
}
