import 'package:di360_flutter/feature/talent_listing/model/talent_listing_count_res.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';

abstract class TalentListingRepository {
  Future<List<JobProfiles>> getMyTalentListing(List<String>? listingStatus);
  Future<TalentListingtCountResponse> getTalentEnquiryCounts(Map<String, dynamic> variables);
}
