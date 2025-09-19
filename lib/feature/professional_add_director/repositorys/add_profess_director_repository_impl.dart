import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/professional_add_director/querys/add_update_profes_basic_query.dart';
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
  
}