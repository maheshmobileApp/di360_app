import 'package:di360_flutter/feature/enquiries/model/applicant_enquiry_res.dart';
import 'package:di360_flutter/feature/enquiries/model/enquiries_list_res.dart';
import 'package:di360_flutter/feature/enquiries/model/get_enquiries_messages_res.dart';
import 'package:di360_flutter/feature/job_seek/model/job.dart';

abstract class EnquiriesRepository {
  Future<EnquiriesListResData> getMyEnquiryJobData(dynamic variables);
  Future<ApplicantEnquiryData> getApplicantEnquiryData(
      String enquiryId, String jobId);
  Future<EnquiriesMessagesData> fetchEnquiriesMessages(dynamic variables);
  Future<List<Jobs>> getJobEnquiryDetails(dynamic variables);
  Future<dynamic> sendApplicantMessage(dynamic variables);
  Future<dynamic> updateApplicantMessage(dynamic variables);
  Future<dynamic> deleteApplicantMessage(dynamic variables);
}
