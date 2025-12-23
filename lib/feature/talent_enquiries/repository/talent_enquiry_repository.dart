import 'package:di360_flutter/feature/talent_enquiries/model/get_talent_enquiry_res.dart';

abstract class TalentEnquiryRepository {
  Future<TalentEnquiryData> getTalentEnquiryData(dynamic variables);
}
