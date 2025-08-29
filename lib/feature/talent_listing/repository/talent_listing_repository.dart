import 'package:di360_flutter/feature/talent_listing/model/talent_listings_model.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listing_count_res.dart';

abstract class TalentListingRepository {
  
  Future<List<TalentListingProfiles>?> getMyTalentListing(List<String>? listingStatus);
  Future<TalentListingCountRes> talentCounts();

}
