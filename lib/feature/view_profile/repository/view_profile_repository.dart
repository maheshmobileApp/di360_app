import 'package:di360_flutter/feature/view_profile/model/practice_view_profile_res.dart';
import 'package:di360_flutter/feature/view_profile/model/professional_view_profile_res.dart';
import 'package:di360_flutter/feature/view_profile/model/view_profile_data.dart';

abstract class ViewProfileRepository {
  Future<DentalSuppliersByPk?> getViewProfileData();
  Future<dynamic> updateViewProfileData(
      Map<String, dynamic> data);
      Future<dynamic> uploadLogo(
      Map<String, dynamic> data);
  Future<DentalPracticesByPk?> getPracticeViewProfileData();
  Future<DentalProfessionalsByPk?> getProfessionalViewProfile();
  Future<dynamic> deleteAccount();
}
