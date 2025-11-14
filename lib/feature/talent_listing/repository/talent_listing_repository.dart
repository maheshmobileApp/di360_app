import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listing_count_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_messages_res.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';

abstract class TalentListingRepository {
  Future<List<JobProfiles>> getMyTalentListing(List<String>? listingStatus);
  Future<TalentListingtCountResponse> getTalentEnquiryCounts(Map<String, dynamic> variables);
  Future<JobProfileEnquiriesResList> getTalentEnquiry(String talentId);
  Future<TalentsMessageResData> fetchTalentMessages(String talentId);
}
