import 'dart:convert';
import 'package:di360_flutter/feature/talent_listing/model/talent_profile_response.dart';
import 'package:di360_flutter/feature/talent_listing/repository/talent_listing_repository.dart';
import 'package:flutter/services.dart' show rootBundle;


class TalentListingRepoImpl implements TalentListingRepository {
  @override
  Future<List<TalentProfile>> getTalentListings() async {
    final String response = await rootBundle.loadString('assets/jobprofile.json');
    final data = json.decode(response);
    final TalentProfilesResponse = TalentProfileResponse.fromJson(data);
    return TalentProfilesResponse.jobProfiles;
  }
}
