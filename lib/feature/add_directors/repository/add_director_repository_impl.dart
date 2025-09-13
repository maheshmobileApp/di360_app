import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/add_directors/model/get_business_type_res.dart';
import 'package:di360_flutter/feature/add_directors/model/get_directories_res.dart';
import 'package:di360_flutter/feature/add_directors/querys/add_basic_info_query.dart';
import 'package:di360_flutter/feature/add_directors/querys/add_certificate_query.dart';
import 'package:di360_flutter/feature/add_directors/querys/add_services_query.dart';
import 'package:di360_flutter/feature/add_directors/querys/add_team_member_query.dart';
import 'package:di360_flutter/feature/add_directors/querys/appoinment_timings_query.dart';
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
  
  @override
  Future<dynamic> addBasicInfo(dynamic variables) async {
    final res = await http.mutation(addBasicInfoQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> updateBasicInfo(dynamic variables) async {
    final res = await http.mutation(updateBasicInfoQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> addGallery(dynamic variables) async {
    final res = await http.mutation(addGalleryQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> addFaqs(dynamic variables) async {
    final res = await http.mutation(addFAQsQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> addTestimonials(dynamic variables) async {
    final res = await http.mutation(addTestimonialsQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> addLocation(dynamic variables) async {
    final res = await http.mutation(addLocationQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> updateService(dynamic variables) async {
    final res = await http.mutation(updateServiceQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> deleteService(dynamic variables) async {
    final res = await http.mutation(deleteServiceQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> updateCertificate(dynamic variables) async {
    final res = await http.mutation(updateCertificateQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> deleteCertificate(dynamic variables) async {
    final res = await http.mutation(deleteCertificateQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> updateAchieve(dynamic variables) async {
    final res = await http.mutation(updateAchievementQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> deleteAchieve(dynamic variables) async {
    final res = await http.mutation(deleteAchieveQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> updateDocu(dynamic variables) async {
    final res = await http.mutation(updateDocumentQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> deleteDocu(dynamic variables) async {
    final res = await http.mutation(deleteDocumentQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> updateOurTeam(dynamic variables) async {
    final res = await http.mutation(updateOurTeamQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> deleteOurTeam(dynamic variables) async {
    final res = await http.mutation(deleteOurTeamQuery, variables);
    return res;
  }

  @override
  Future<dynamic> updateGallery(dynamic variables) async {
    final res = await http.mutation(updateGalleryQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> updateFAQ(dynamic variables) async {
    final res = await http.mutation(updateFAQQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> deleteFaq(dynamic variables) async {
    final res = await http.mutation(deleteFAQQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> updateTestimonial(dynamic variables) async {
    final res = await http.mutation(updateTestimonialQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> deleteTestimonial(dynamic variables) async {
    final res = await http.mutation(deleteTestimonialQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> updateTimings(dynamic variables) async {
    final res = await http.mutation(updateTimingsQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> deleteTimings(dynamic variables) async {
    final res = await http.mutation(deleteTimingsQuery, variables);
    return res;
  }
  
  @override
  Future<dynamic> updateSocailUrl(dynamic variables) async {
    final res = await http.mutation(updateSocialQuery, variables);
    return res;
  }
}
