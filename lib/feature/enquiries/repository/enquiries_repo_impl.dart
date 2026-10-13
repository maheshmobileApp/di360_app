import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/enquiries/model/applicant_enquiry_res.dart';
import 'package:di360_flutter/feature/enquiries/model/enquiries_list_res.dart';
import 'package:di360_flutter/feature/enquiries/model/get_enquiries_messages_res.dart';
import 'package:di360_flutter/feature/enquiries/query/enquiries_list_query.dart';
import 'package:di360_flutter/feature/enquiries/query/enquiry_message_delete_query.dart';
import 'package:di360_flutter/feature/enquiries/query/enquiry_message_query.dart';
import 'package:di360_flutter/feature/enquiries/query/enquiry_update_message_query.dart';
import 'package:di360_flutter/feature/enquiries/query/get_applicant_enquiry_query.dart';
import 'package:di360_flutter/feature/enquiries/query/get_enquiry_messages_query.dart';
import 'package:di360_flutter/feature/enquiries/query/get_job_enquiry_details.dart';
import 'package:di360_flutter/feature/enquiries/repository/enquiries_repository.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';

class EnquiriesRepoImpl extends EnquiriesRepository {
  final http = HttpService();

  @override
  Future<EnquiriesListResData> getMyEnquiryJobData(dynamic variables) async {
    final res = await http.query(enquiriesListQuery, variables: variables);
    final output = EnquiriesListResData.fromJson(res);
    return output;
  }

  @override
  Future<ApplicantEnquiryData> getApplicantEnquiryData(
      String enquiryId, String jobId) async {
    final variables = {
      "where": {
        "_and": [
          {
            "job_id": {"_eq": jobId}
          },
          {
            "enq_sender_id": {"_eq": enquiryId}
          }
        ]
      },
      "limit": 20
    };
    final res =
        await http.query(getApplicantEnquiryQuery, variables: variables);
    final output = ApplicantEnquiryData.fromJson(res);
    return output;
  }

  @override
  Future<EnquiriesMessagesData> fetchEnquiriesMessages(variables) async {
    final res =
        await http.query(getEnquiriesMessagesQuery, variables: variables);
    final data = EnquiriesMessagesData.fromJson(res);
    return data;
  }

  @override
  Future<List<Jobs>> getJobEnquiryDetails(variables) async {
    final res = await http.query(getJobDetailsQuery, variables: variables);
    final data =
        List<Jobs>.from((res['jobs'] as List).map((e) => Jobs.fromJson(e)));
    return data;
  }

  @override
  Future<dynamic> sendApplicantMessage(variables) async {
    final res = await http.mutation(EnquiryMessageQuery, variables);
    return res;
  }

  @override
  Future<dynamic> updateApplicantMessage(variables) async {
    final res = await http.mutation(EnquiryUpdateMessageQuery, variables);
    return res;
  }

  @override
  Future<dynamic> deleteApplicantMessage(variables) async {
    final res = await http.mutation(EnquiryMessageDeleteQuery, variables);
    return res;
  }
}
