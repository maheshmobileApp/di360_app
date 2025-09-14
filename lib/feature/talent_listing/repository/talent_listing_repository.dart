import 'package:di360_flutter/feature/talent_listing/model/talent_enquiry_listing_response.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listing_count_res.dart';


abstract class TalentListingRepository {
  Future<List<JobProfile>> getMyTalentListing(List<String>? listingStatus);
  Future<TalentListingtCountResponse> getTalentEnquiryCounts(Map<String, dynamic> variables);
}
