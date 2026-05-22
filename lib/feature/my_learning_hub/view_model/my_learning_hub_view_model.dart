import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:di360_flutter/common/validations/validate_mixin.dart';
import 'package:di360_flutter/feature/market_place_learning_hub/model_class/courses_response.dart';
import 'package:di360_flutter/feature/my_learning_hub/repository/my_learning_hub_repo_impl.dart';
import 'package:di360_flutter/services/download_notification_service.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyLearningHubViewModel extends ChangeNotifier with ValidationMixins {
  final MyLearningHubRepoImpl repo = MyLearningHubRepoImpl();

  List<CoursesListingDetails> myRegisteredCourses = [];
  bool searchBarOpen = false;
  final searchController = TextEditingController();

  int _myLearningHubLimit = 10;
  int _myLearningHubOffset = 0;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  bool isLoading = false;

  void setSearchBar(bool value) {
    searchBarOpen = value;
    notifyListeners();
  }

  Future<void> getCoursesWithMyRegistrations(
    BuildContext context, {
    bool loadMore = false,
    String? type,
    String? category,
    String? date,
  }) async {
    if (loadMore) {
      if (isLoadingMore || !hasMoreData) return;
      isLoadingMore = true;
      _myLearningHubOffset += _myLearningHubLimit;
    } else {
      _myLearningHubOffset = 0;
      hasMoreData = true;
      isLoading = true;
    }

    notifyListeners();

    final res = await repo.getCoursesWithMyRegistrations(
        searchController.text,
        _myLearningHubLimit,
        _myLearningHubOffset,
        type ?? '',
        category ?? '',
        date ?? '');

    if (res != null) {
      if (loadMore) {
        myRegisteredCourses.addAll(res);
        isLoadingMore = false;
      } else {
        myRegisteredCourses = res;
        isLoading = false;
      }
      hasMoreData = res.length >= _myLearningHubLimit;
    } else {
      isLoading = false;
      isLoadingMore = false;
    }

    notifyListeners();
  }

  Future<void> certificateDownload(
      BuildContext context, CoursesListingDetails course) async {
    Loaders.circularShowLoader(context);
    final variables = {
      "first_name": course.courseRegisteredUsers?.first.firstName ?? "",
      "last_name": course.courseRegisteredUsers?.first.lastName ?? "",
      "presenters":
          course.presenters?.map((e) => e.presentedByName as String).toList(),
      "course_name": course.courseName,
      "logo": course.dentalSupplier?.logo?.url ?? "",
      "company_name": course.companyName,
      "startDate": course.startDate,
      "endDate": course.endDate,
      "cpd_points": course.cpdPoints,
      "type": course.type,
      "completed_date": course.courseRegisteredUsers?.first.completedDate ?? ""
    };
    final res = await repo.certificateDownload(variables);
    Loaders.circularHideLoader(context);
    if (res != null && res is List<int>) {
      final certificateName = "${course.courseName}_certificate.pdf";
      final dir = await _getDownloadDir();
      final file = File('${dir.path}/${certificateName}');
      await file.writeAsBytes(res);
      await DownloadNotificationService.showDownloadNotification(
        fileName: certificateName,
        filePath: file.path,
      );

      scaffoldMessenger(
          "✅ Certificate Downloaded\n📁 Downloads > DentalInterface360 > Certificates");
    } else {
      print("Certificate download failed or invalid response");
    }
  }

  Future<Directory> _getDownloadDir() async {
    if (Platform.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt >= 29) {
        try {
          final dir = Directory(
              '/storage/emulated/0/Download/DentalInterface360/Certificates');
          if (!await dir.exists()) await dir.create(recursive: true);
          return dir;
        } catch (_) {
          final base = await getExternalStorageDirectory() ??
              await getApplicationDocumentsDirectory();
          final dir = Directory('${base.path}/DentalInterface360/Certificates');
          if (!await dir.exists()) await dir.create(recursive: true);
          return dir;
        }
      } else {
        final base = await getExternalStorageDirectory() ??
            await getApplicationDocumentsDirectory();
        final dir = Directory('${base.path}/DentalInterface360/Certificates');
        if (!await dir.exists()) await dir.create(recursive: true);
        return dir;
      }
    } else {
      return await getApplicationDocumentsDirectory();
    }
  }
}
