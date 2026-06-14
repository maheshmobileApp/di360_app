import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/add_directors/querys/update_client_query.dart';
import 'package:di360_flutter/feature/add_directors/querys/update_record_query.dart';
import 'package:di360_flutter/feature/professional_add_director/querys/add_update_profes_basic_query.dart';
import 'package:di360_flutter/feature/professional_add_director/querys/update_view_profile_query.dart';
import 'package:di360_flutter/feature/professional_add_director/repositorys/add_profess_director_repository.dart';

class AddProfessDirectorRepositoryImpl extends AddProfessDirectorRepository {

  final http = HttpService();

  @override
  Future<dynamic> updateProfesBasicInfo(dynamic vari) async{
    final res = await http.mutation(updateBasicInfoQuery, vari);
    return res;
  }
  
 @override
  Future<dynamic> addProfesBasicInfo(dynamic vari) async{
    final res = await http.mutation(addProfessBasicInfoQuery, vari);
    return res;
  }
  
  @override
  Future<dynamic> updateProfesViewProfile(dynamic vari) async{
    final res = await http.mutation(updateViewProfileQuery, vari);
    return res;
  }

  @override
  Future<dynamic> updateClient(variables) async {
    final res = await http.mutation(updateClientQuery, variables);
    return res;
  }

  @override
  Future<dynamic> updateRecord(variables) async {
    final query = updateRecordProfessionalQuery;
    final res = await http.mutation(query, variables);
    return res;
  }
  
}