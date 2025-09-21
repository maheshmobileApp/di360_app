import 'package:di360_flutter/feature/job_seek/model/hire_me_request.dart';
import 'package:di360_flutter/feature/talents/model/enquire_request.dart';
import '../../talents/model/job_profile.dart';
abstract class TalentRepository {
  Future<List<JobProfile>> getTalentDetails();
Future<bool> hireMe(HireMeRequest request);
Future<bool> enquire(EnquiryRequest request);
}