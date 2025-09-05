import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listings_model.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listing_count_res.dart';
import 'package:di360_flutter/feature/talent_listing/quary/get_talent_listing_quary.dart';
import 'package:di360_flutter/feature/talent_listing/quary/talent_status_count_quary.dart';
import 'package:di360_flutter/feature/talent_listing/repository/talent_listing_repository.dart';

class TalentListingRepoImpl implements TalentListingRepository {
  final HttpService _http = HttpService();

@override
@override
Future<List<JobProfiles>> getMyTalentListing(List<String>? listingStatus) async {
  final adminStatusList = (listingStatus == null || listingStatus.isEmpty)
      ? ["PENDING", "APPROVE", "REJECT"]
      : listingStatus;

  const int limit = 10;
  const int offset = 0;

  try {
    final listingData = await _http.query(
      getTalentListingQuery,
      variables: {
        "where": {
          "_and": [
            {
              "admin_status": {"_in": adminStatusList}
            },
            {
              "admin_status": {"_neq": "DRAFT"}
            }
          ]
        },
        "limit": limit,
        "offset": offset,
      },
    );

    print("Raw listingData: $listingData");
    final parsed = GetMyTalentListingData.fromJson(listingData);
    return parsed.jobProfiles ?? [];
  } catch (e, stack) {
    print("Error in getMyTalentListing: $e");
    print(stack);
    return [];
  }
}



  @override
Future<TalentListingCountRes> talentCounts() async {
  final raw = await _http.query(GetTalentStatusCountsQuery);
  final result = TalentListingCountRes.fromJson(raw); 
  print("Talent counts: ${result.toJson()}");
  return result;
}


}
