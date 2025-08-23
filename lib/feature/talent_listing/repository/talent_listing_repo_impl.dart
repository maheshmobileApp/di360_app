import 'dart:convert';

import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listings_model.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listings_response.dart'; 
import 'package:di360_flutter/feature/talent_listing/model/talent_listing_count_res.dart';
import 'package:di360_flutter/feature/talent_listing/quary/get_talent_listing_quary.dart';
import 'package:di360_flutter/feature/talent_listing/quary/talent_status_count_quary.dart';
import 'package:di360_flutter/feature/talent_listing/repository/talent_listing_repository.dart';
import 'package:flutter/services.dart';

class TalentListingRepoImpl implements TalentListingRepository {
  final HttpService _http = HttpService();

  @override
Future<List<TalentsListingDetail>?> getMyTalentListing(
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

Future<List<TalentListingsProfile>> getMyTalentlistingStatic() async {
  final String response = await rootBundle.loadString('assets/talents.json');
  final data = json.decode(response) as List<dynamic>;
  return data.map((e) => TalentListingsProfile.fromJson(e)).toList();
}


 @override
   Future<TalentListingCountRes>talentCounts() async {
    final data = await _http .query(GetTalentStatusCountsQuery);
    final result = TalentListingCountRes.fromJson({"data": data});
    print("Talent counts: ${result.toJson()}");
    return result;
  }
  
}

