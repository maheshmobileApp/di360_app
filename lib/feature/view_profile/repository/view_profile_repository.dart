import 'package:di360_flutter/feature/view_profile/model/professional_view_profile_res.dart';
import 'package:di360_flutter/feature/view_profile/model/view_profile_data.dart';

abstract class ViewProfileRepository {
  Future<DentalSuppliersByPk?> getViewProfileData();
  Future<dynamic> updateViewProfileData(Map<String, dynamic> data);
  Future<dynamic> uploadLogo(Map<String, dynamic> data);
  Future<DentalSuppliersByPk?> getPracticeViewProfileData();
  Future<DentalProfessionalsByPk?> getProfessionalViewProfile();
  Future<dynamic> deleteAccount();
  Future<dynamic> insertDirectory(dynamic variables);
  Future<dynamic> updateDirectoryFromViewProfile(dynamic variable);
  Future<dynamic> updateClient(dynamic variables);
  Future<dynamic> updateRecord(dynamic variables);
}
