import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/enquiries/model/applicant_enquiry_res.dart';
import 'package:di360_flutter/feature/enquiries/model/enquiries_list_res.dart';
import 'package:di360_flutter/feature/enquiries/model/get_enquiries_messages_res.dart';
import 'package:di360_flutter/feature/enquiries/query/enquiries_list_query.dart';
import 'package:di360_flutter/feature/enquiries/query/get_applicant_enquiry_query.dart';
import 'package:di360_flutter/feature/enquiries/query/get_enquiry_messages_query.dart';
import 'package:di360_flutter/feature/enquiries/repository/enquiries_repository.dart';

class EnquiriesRepoImpl extends EnquiriesRepository {
  final http = HttpService();

  @override
  Future<EnquiriesListResData> getMyEnquiryJobData(String enquiryId) async {
    final variables = {
      "limit": 5,
      "offset": 0,
      "where": {
        "enquiry_userid": {"_eq": enquiryId}
      }
    };
    final res = await http.query(enquiriesListQuery, variables: variables);
    final output = EnquiriesListResData.fromJson(res);
    return output;
  }

  @override
  Future<ApplicantEnquiryData> getApplicantEnquiryData(
      String enquiryId, String jobId) async {
    final variables = {
      "where": {
        "job_id": {"_eq": jobId},
        "enquiry_userid": {"_eq": enquiryId}
      }
    };
    print("**************************$variables");
    final res =
        await http.query(getApplicantEnquiryQuery, variables: variables);
    final output = ApplicantEnquiryData.fromJson(res);
    return output;
  }

  @override
  Future<EnquiriesMessagesData> fetchEnquiriesMessages(variables) async {
    print("***************$variables");
    final res =
        await http.query(getEnquiriesMessagesQuery, variables: variables);
    print("**************************$res");
    final data = EnquiriesMessagesData.fromJson(res);
    return data;
  }
}
