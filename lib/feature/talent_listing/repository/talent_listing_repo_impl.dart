import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/get_hiring_talent_list_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/get_talent_listing_status_count_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/get_talent_preview_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listing_count_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_messages_res.dart';
import 'package:di360_flutter/feature/talent_listing/quary/delete_talent_message.dart';
import 'package:di360_flutter/feature/talent_listing/quary/get_talent_enquiry_query.dart';
import 'package:di360_flutter/feature/talent_listing/quary/get_talent_listing_quary.dart';
import 'package:di360_flutter/feature/talent_listing/quary/get_talent_listing_status_count.dart';
import 'package:di360_flutter/feature/talent_listing/quary/get_talent_preview_data.dart';
import 'package:di360_flutter/feature/talent_listing/quary/send_talent_message_query.dart';
import 'package:di360_flutter/feature/talent_listing/quary/talent_listing_messages_query.dart';
import 'package:di360_flutter/feature/talent_listing/quary/talent_status_count_quary.dart';
import 'package:di360_flutter/feature/talent_listing/quary/update_talent_listing_query.dart';
import 'package:di360_flutter/feature/talent_listing/quary/update_talent_query.dart';
import 'package:di360_flutter/feature/talent_listing/repository/talent_listing_repository.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';

class TalentListingRepoImpl implements TalentListingRepository {
  final HttpService _http = HttpService();
  @override
  Future<HiringTalentList> getMyTalentListing(dynamic variables) async {
    try {
      final response =
          await _http.query(getTalentListingQuery, variables: variables);
      final res = HiringTalentList.fromJson(response);
      return res;
    } catch (e, st) {
      print("Error in getMyTalentListing: $e\n$st");
      return HiringTalentList();
    }
  }

  @override
  Future<TalentListingtCountResponse> getTalentEnquiryCounts(
      Map<String, dynamic> variables) async {
    try {
      final raw = await _http.query(
        getTalentHiringCountByStatusQuery,
        variables: variables,
      );
      print("Raw talent enquiry counts: $raw");
      if (raw == null || raw.isEmpty) {
        throw Exception('Invalid response for talent counts');
      }
      final response = TalentListingtCountResponse.fromJson(raw);
      print("Talent enquiry counts parsed: ${response.toJson()}");
      return response;
    } catch (e, st) {
      print("Error fetching talent enquiry counts: $e\n$st");
      rethrow;
    }
  }

  @override
  Future<JobProfileEnquiriesResList> getTalentEnquiry(String talentId) async {
    final variables = {
      "where": {
        "talent_id": {"_eq": talentId},
      }
    };

    final response =
        await _http.query(getTalentEnquiryQuery, variables: variables);
    final output = JobProfileEnquiriesResList.fromJson(response);
    return output;
  }

  @override
  Future<TalentsMessageResData> fetchTalentMessages(String talentId) async {
    print("***********************talentId: $talentId");
    final data = await _http
        .query(talentListingMessagesQuery, variables: {"talent_id": talentId});

    final result = TalentsMessageResData.fromJson(data);
    return result;
  }

  @override
  Future<String?> sendTalentMessage(dynamic variables) async {
    try {
      final data = await _http.mutation(sendTalentMessageQuery, variables);
      return data['insert_talents_message_one']?['id'] as String?;
    } catch (e) {
      throw Exception("Failed to send message: $e");
    }
  }

  @override
  Future updateTalentMessage(String Id, String message) async {
    final variables = {
      "id": Id,
      "message": message,
      "updated_at": DateTime.now().toIso8601String()
    };
    final data = await _http.mutation(updateTalentMessageQuery, variables);

    return data;
  }

  @override
  Future deleteTalentMessage(dynamic variables) async {
    final data = await _http.mutation(deleteTalentMessageQuery, variables);

    return data;
  }

  @override
  Future<List<JobProfiles>> getTalentPreviewData(variables) async {
    final res =
        await _http.query(getTalentPreviewDataQuery, variables: variables);

    if (res != null && res['job_profiles'] != null) {
      final List<dynamic> jobProfilesList = res['job_profiles'];
      return jobProfilesList.map((json) => JobProfiles.fromJson(json)).toList();
    }
    return [];
  }

  @override
  Future<TalentListingStatusCount> getTalentListingStatusCounts(
      dynamic variables) async {
    final res = await _http.query(getTalentListingStatusCountsQuery,
        variables: variables);
    final data = TalentListingStatusCount.fromJson(res);
    return data;
  }

  @override
  Future updateTalentListing(variables) async {
    final res =
        await _http.query(updateTalentListingQuery, variables: variables);
    return res;
  }
}
