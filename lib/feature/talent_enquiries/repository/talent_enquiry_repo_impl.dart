import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/feature/talent_enquiries/model/get_talent_enquiries.dart';
import 'package:di360_flutter/feature/talent_enquiries/model/get_talent_enquiry_res.dart';
import 'package:di360_flutter/feature/talent_enquiries/query/get_talent_enq_messages_query.dart';
import 'package:di360_flutter/feature/talent_enquiries/query/get_talent_enq_preview_query.dart';
import 'package:di360_flutter/feature/talent_enquiries/repository/talent_enquiry_repository.dart';
import 'package:di360_flutter/feature/talent_listing/quary/get_talent_enquiry_query.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';

class TalentEnquiryRepoImpl implements TalentEnquiryRepository {
  final HttpService _http = HttpService();
  @override
  Future<TalentEnquiryData> getTalentEnquiryData(variables) async {
    final res = await _http.query(getTalentEnquiryQuery, variables: variables);

    final data = TalentEnquiryData.fromJson(res);
    return data;
  }

  @override
  Future<List<JobProfiles>> getTalentEnqPreviewData(variables) async {
    final res =
        await _http.query(getTalentEnqPreviewQuery, variables: variables);
    if (res != null && res['job_profiles'] != null) {
      final List<dynamic> jobProfilesList = res['job_profiles'];
      return jobProfilesList.map((json) => JobProfiles.fromJson(json)).toList();
    }
    return [];
  }
  
  @override
  Future<JobProfileEnquiriesResList> getEnqMessagesData(variables)async {
    final res = await _http.query(getTalentEnqMessagesQuery, variables: variables);

    final data = JobProfileEnquiriesResList.fromJson(res);
    return data;
  }
}
