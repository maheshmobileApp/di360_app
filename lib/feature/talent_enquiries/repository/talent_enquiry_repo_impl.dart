import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/talent_enquiries/model/get_talent_enquiry_res.dart';
import 'package:di360_flutter/feature/talent_enquiries/repository/talent_enquiry_repository.dart';
import 'package:di360_flutter/feature/talent_listing/quary/get_talent_enquiry_query.dart';

class TalentEnquiryRepoImpl implements TalentEnquiryRepository {
  final HttpService _http = HttpService();
  @override
  Future<TalentEnquiryData> getTalentEnquiryData(variables) async {
    final res = await _http.query(getTalentEnquiryQuery, variables: variables);

    final data = TalentEnquiryData.fromJson(res);
    return data;
  }
}
