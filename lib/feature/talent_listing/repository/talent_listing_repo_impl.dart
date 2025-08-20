
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_listings/quary/job_status_count_quary.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listings_response.dart'; 
import 'package:di360_flutter/feature/talent_listing/model/talent_status_count_model.dart';
import 'package:di360_flutter/feature/talent_listing/quary/get_talent_listing_quary.dart';
import 'package:di360_flutter/feature/talent_listing/repository/talent_listing_repository.dart';

class TalentListingRepoImpl implements TalentListingRepository {
  final HttpService _http = HttpService();

  @override
Future<List<TalentsListingDetails>?> getMyTalentListing(
    List<String>? listingStatus) async {
  final adminStatusList = listingStatus?.isEmpty == true
      ? ["PENDING", "APPROVAL", "REJECTED", "CANCELLED", "ENQUIRY"]
      : listingStatus;

  const int limit = 50;
  const int offset = 0;

  final listingData = await _http.query(
    getTalentListingQuery,
    variables: {
      "admin_status": adminStatusList,
      "limit": limit,
      "offset": offset,
    },
  );

  final parsed = TalentListing.fromJson(listingData['data'] ?? {});
  return parsed.jobProfiles ?? [];
}


  @override
  Future<TalentCountData> talentCounts() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final Map<String, dynamic> variables = {};

    if (type == "AdminStatus") {
      variables["admin_status"] = userId;
    }

    final data = await _http.query(getJobStatusCount, variables: variables);
    final result = TalentCountData.fromJson(data);
    print(result);
    return result;
  }
}

