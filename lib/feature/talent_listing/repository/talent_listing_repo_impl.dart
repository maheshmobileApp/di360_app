import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_enquiry_listing_response.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_listing_count_res.dart';
import 'package:di360_flutter/feature/talent_listing/quary/get_talent_listing_quary.dart';
import 'package:di360_flutter/feature/talent_listing/quary/talent_status_count_quary.dart';
import 'package:di360_flutter/feature/talent_listing/repository/talent_listing_repository.dart';

class TalentListingRepoImpl implements TalentListingRepository {
  final HttpService _http = HttpService();

  @override
  Future<List<JobProfile>> getMyTalentListing(
      List<String>? listingStatus) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final adminStatusList = (listingStatus == null || listingStatus.isEmpty)
        ? ["REJECT", "APPROVE", "PENDING", "DRAFT", "EXPIRE"]
        : listingStatus;
    try {
      final response = await _http.query(
        getTalentListingQuery,
        variables: {
          "where": {
            "_and": [
              {
                "enquiry_from": {"_eq": userId}
              },
              {
                "job_profiles": {
                  "admin_status": {"_in": adminStatusList}
                }
              }
            ]
          }
        },
      );
      final enquiries = response['talent_enquiries'] as List<dynamic>;
      final profiles = enquiries
          .map((e) => TalentEnquiry.fromJson(e))
          .map((enquiry) => enquiry.jobProfile)
          .whereType<JobProfile>()
          .toList();
      return profiles;
    } catch (e, st) {
      print("Error in getMyTalentListing: $e\n$st");
      return [];
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
}
