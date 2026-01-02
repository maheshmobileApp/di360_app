import 'package:di360_flutter/feature/job_profile_listing/model/job_profile_enquiries_res.dart';
import 'package:di360_flutter/feature/talent_enquiries/model/get_talent_enquiries.dart';
import 'package:di360_flutter/feature/talent_enquiries/model/get_talent_enquiry_res.dart';
import 'package:di360_flutter/feature/talents/model/talents_res.dart';

abstract class TalentEnquiryRepository {
  Future<TalentEnquiryData> getTalentEnquiryData(dynamic variables);
  Future<List<JobProfiles>> getTalentEnqPreviewData(dynamic variables);
  Future<JobProfileEnquiriesResList> getEnqMessagesData(dynamic variables);

}
