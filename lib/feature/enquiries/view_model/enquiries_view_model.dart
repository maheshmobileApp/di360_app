import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/enquiries/model/applicant_enquiry_res.dart';
import 'package:di360_flutter/feature/enquiries/model/enquiries_list_res.dart';
import 'package:di360_flutter/feature/enquiries/repository/enquiries_repo_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class EnquiriesViewModel extends ChangeNotifier {
  final EnquiriesRepoImpl repo = EnquiriesRepoImpl();
  EnquiriesListResData? enquiriesListData;
  ApplicantEnquiryData? applicantEnquiriesListData;

  Future<EnquiriesListResData?> getMyEnquiryJobData(
      BuildContext context) async {
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await repo.getMyEnquiryJobData(userId);
    if (res != null) {
      enquiriesListData = res;
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
    return res;
  }

  Future<ApplicantEnquiryData?> getApplicantEnquiryData(
      BuildContext context, String jobId) async {
    print("**********calling getApplicantEnquiryData**********");
    Loaders.circularShowLoader(context);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await repo.getApplicantEnquiryData(userId, jobId);
    if (res.jobEnquiries != null) {
      applicantEnquiriesListData = res;
      print("**********getApplicantEnquiryData${res.jobEnquiries?.first.enquiryDescription}**********");
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
    return res;
  }
  /******************Enquiry Messages****************/
}
