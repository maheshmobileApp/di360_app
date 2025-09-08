import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/model/get_directories_res.dart';
import 'package:di360_flutter/feature/add_directors/querys/add_certificate_query.dart';
import 'package:di360_flutter/feature/add_directors/querys/add_services_query.dart';
import 'package:di360_flutter/feature/add_directors/querys/add_team_member_query.dart';
import 'package:di360_flutter/feature/add_directors/querys/get_business_type_query.dart';
import 'package:di360_flutter/feature/add_directors/querys/get_director_info_query.dart';
import 'package:di360_flutter/feature/add_directors/repository/add_director_repository.dart';

class AddDirectorRepositoryImpl extends AddDirectorRepository {
  final HttpService http = HttpService();

  @override
  Future<BusinessTypeData?> getBusinessTypes() async {
    final businessType =
        await http.query(getBusinessTypeQuery, variables: {"type": "PRACTICE"});
    final result = BusinessTypeData.fromJson(businessType);
    return result;
  }

  @override
  Future<List<GetDirectories>> getDirectoriesData() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res =
        await http.query(getDirectorInfoQuery, variables: {"id": userId});
    final result = GetDirectoriesData.fromJson(res);
    return result.directories ?? [];
  }

  @override
  Future<dynamic> addServices(dynamic variables) async {
    final res = await http.mutation(addServicesQuery, variables);
    return res;
  }

  @override
  Future<dynamic> addCertificates(dynamic variables) async {
    final res = await http.mutation(addCertificatesQuery, variables);
    return res;
  }

  @override
  Future<dynamic> addAchieve(dynamic variables) async {
    final res = await http.mutation(addAchievementsQuery, variables);
    return res;
  }

  @override
  Future<dynamic> addDocu(dynamic variables) async {
    final res = await http.mutation(addADocumentQuery, variables);
    return res;
  }

  @override
  Future<dynamic> addTeamMembers(dynamic variables) async {
    final res = await http.mutation(TeamMemberQuery, variables);
    return res;
  }
}
