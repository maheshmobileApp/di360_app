
import 'package:di360_flutter/feature/talent_listing/model/talent_listings_model.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listings_response.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listing_count_res.dart';

abstract class TalentListingRepository {
  Future<List<TalentsListingDetail>?> getMyTalentListing(List<String>? listingStatus);
  Future<TalentListingCountRes> talentCounts();
  Future<List<TalentListingsProfile>> getMyTalentlistingStatic();
}
