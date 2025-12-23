import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/get_hiring_talent_list_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/get_talent_listing_status_count_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listing_count_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_messages_res.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';

abstract class TalentListingRepository {
  Future<HiringTalentList> getMyTalentListing(dynamic variables);
  Future<TalentListingtCountResponse> getTalentEnquiryCounts(
      Map<String, dynamic> variables);
  Future<TalentListingStatusCount> getTalentListingStatusCounts(
      dynamic variables);
  Future<JobProfileEnquiriesResList> getTalentEnquiry(String talentId);
  Future<TalentsMessageResData> fetchTalentMessages(String talentId);
  Future<dynamic> sendTalentMessage(
      dynamic variables);
  Future<dynamic> updateTalentMessage(String Id, String message);
  Future<dynamic> deleteTalentMessage(dynamic variables);
  Future<List<JobProfiles>> getTalentPreviewData(dynamic variables);
  Future<dynamic> updateTalentListing(dynamic variables);
}
