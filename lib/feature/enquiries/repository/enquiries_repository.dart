import 'package:di360_flutter/feature/enquiries/model/applicant_enquiry_res.dart';
import 'package:di360_flutter/feature/enquiries/model/enquiries_list_res.dart';

abstract class EnquiriesRepository {
  Future<EnquiriesListResData> getMyEnquiryJobData(String enquiryId);
  Future<ApplicantEnquiryData> getApplicantEnquiryData(String enquiryId, String jobId);
}