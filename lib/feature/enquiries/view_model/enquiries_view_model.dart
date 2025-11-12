import 'package:di360_flutter/feature/enquiries/model/enquiries_list_res.dart';
import 'package:di360_flutter/feature/enquiries/repository/enquiries_repo_impl.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class EnquiriesViewModel extends ChangeNotifier {
  final EnquiriesRepoImpl repo = EnquiriesRepoImpl();
  EnquiriesListResData? enquiriesListData;

  Future<EnquiriesListResData?> getMyEnquiryJobData(
      BuildContext context, String enquiryId) async {
    Loaders.circularShowLoader(context);
    final res = await repo.getMyEnquiryJobData(enquiryId);
    if (res != null) {
      enquiriesListData = res;
      Loaders.circularHideLoader(context);
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
    return res;
  }
}
