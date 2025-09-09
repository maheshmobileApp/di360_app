import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/model/get_directories_res.dart';

abstract class AddDirectorRepository {
  Future<BusinessTypeData?> getBusinessTypes();
  Future<List<GetDirectories>> getDirectoriesData();
  Future<dynamic> addServices(dynamic variables);
  Future<dynamic> addCertificates(dynamic variables);
  Future<dynamic> addAchieve(dynamic variables);
  Future<dynamic> addDocu(dynamic variables);
  Future<dynamic> addTeamMembers(dynamic variables);
  Future<dynamic> addBasicInfo(dynamic variables);
  Future<dynamic> updateBasicInfo(dynamic variables);
  Future<dynamic> addGallery(dynamic variables);
}