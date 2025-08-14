
import 'package:di360_flutter/feature/talent_listing/model/talent_listings_response.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_status_count_model.dart';

abstract class TalentListingRepository {
  Future<List<TalentsListingDetails>?> getMyTalentListing(List<String>? listingStatus);
  Future<TalentCountData> talentCounts();
}
