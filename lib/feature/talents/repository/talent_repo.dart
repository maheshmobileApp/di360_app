import 'package:di360_flutter/feature/talents/model/talents_model.dart';

abstract class TalentRepository {
  Future<List<JobProfile>> getTalentDetails();
  Future<bool> hireMe();
}