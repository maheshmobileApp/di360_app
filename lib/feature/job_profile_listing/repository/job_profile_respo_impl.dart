import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_talent_messages_response.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/request_count_res.dart';
import 'package:di360_flutter/feature/job_profile_listing/model/talent_messages_query.dart';
import 'package:di360_flutter/feature/job_profile_listing/quary/get_all_talents_request_query.dart';
import 'package:di360_flutter/feature/job_profile_listing/quary/get_my_enquiry_job_data.dart';
import 'package:di360_flutter/feature/job_profile_listing/quary/get_profile_enquiry_query.dart';
import 'package:di360_flutter/feature/job_profile_listing/quary/get_request_count_query.dart';
import 'package:di360_flutter/feature/job_profile_listing/quary/job_profile_deleted_quary.dart';
import 'package:di360_flutter/feature/job_profile_listing/quary/job_profile_quary.dart';
import 'package:di360_flutter/feature/job_profile_listing/quary/job_profile_updated.dart';
import 'package:di360_flutter/feature/job_profile_listing/quary/update_talent_request_status_query.dart';
import 'package:di360_flutter/feature/job_profile_listing/repository/job_profle_repository.dart';
import 'package:di360_flutter/feature/talent_listing/model/get_hiring_talent_list_res.dart';
import 'package:di360_flutter/feature/talent_listing/model/talent_messages_res.dart';
import 'package:di360_flutter/feature/talent_listing/quary/delete_talent_message.dart';
import 'package:di360_flutter/feature/talent_listing/quary/send_talent_message_query.dart';
import 'package:di360_flutter/feature/talent_listing/quary/update_talent_query.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';

class JobProfileRepoImpl implements JobProfileRepository {
  final HttpService http = HttpService();
  @override
  Future<List<JobProfiles>> getJobProfiles() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final response = await http.query(
      jobProfileListing,
      variables: {"dental_professional_id": userId},
    );
    final result = TalentsResData.fromJson(response);
    return result.jobProfiles ?? [];
  }

  @override
  Future<dynamic> updateJobProfile(String? id, String status) async {
    final jobProfileStatusData = await http.mutation(
      updateJobProfileStatus,
      {"id": id, "status": status},
    );
    return jobProfileStatusData;
  }

  @override
  Future<dynamic> removeJobProfile({required String jobProfileId}) async {
    final response = await http.mutation(
      deleteJobProfile,
      {'id': jobProfileId},
    );
    return response;
  }

  @override
  Future<JobProfileEnquiriesResList> getMyEnquiryJobData(
      String jobProfileId) async {
    final variables = {
      "limit": 5,
      "offset": 0,
      "where": {
        "talent_id": {"_eq": jobProfileId}
      }
    };
    final response =
        await http.query(getMyEnquiryJobDataQuery, variables: variables);
    final output = JobProfileEnquiriesResList.fromJson(response);

    return output;
  }

  @override
  Future<JobProfileEnquiriesResList> getJobProfileEnquiry(
      String profileId, String enquiryId) async {
    final variables = {
      "where": {
        "talent_id": {"_eq": profileId},
        "enq_sender_id": {"_eq": enquiryId}
      },
      "limit": 20
    };

    print("******************$variables");

    final response =
        await http.query(getProfileEnquiryQuery, variables: variables);
    final output = JobProfileEnquiriesResList.fromJson(response);
    return output;
  }

  @override
  Future<HiringTalentList> getAllTalentsRequest(variables) async {
    final response =
        await http.query(getAllTalentsRequestQuery, variables: variables);
    final output = HiringTalentList.fromJson(response);
    return output;
  }

  @override
  Future updateTalentListing(variables) async {
    final response =
        await http.mutation(updateTalentRequestStatusQuery, variables);
    return response;
  }

  @override
  Future<RequestCountData> getRequestCount(variables) async {
    final response =
        await http.query(getRequestCountQuery, variables: variables);
    return RequestCountData.fromJson(response);
  }

  @override
  Future<TalentsMessageResData> fetchTalentMessages(variables) async {
    final response =
        await http.query(jobTalentMessageListing, variables: variables);
    return TalentsMessageResData.fromJson(response);
  }

  @override
  Future<dynamic> deleteTalentMessage(variables) async {
    final res = await http.mutation(deleteTalentMessageQuery, variables);
    return res;
  }
  

  @override
  Future<dynamic> sendTalentMessage(variables) async {
    final res = await http.mutation(sendTalentMessageQuery, variables);
    return res;
  }
  

  @override
  Future<dynamic> updateTalentMessage(variables) async {
    final res = await http.mutation(updateTalentMessageQuery, variables);
    return res;
  }
}
