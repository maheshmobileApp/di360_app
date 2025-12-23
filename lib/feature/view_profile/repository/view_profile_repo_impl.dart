import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/view_profile/model/practice_view_profile_res.dart';
import 'package:di360_flutter/feature/view_profile/model/professional_view_profile_res.dart';
import 'package:di360_flutter/feature/view_profile/model/view_profile_data.dart';
import 'package:di360_flutter/feature/view_profile/query/delete_account_querys.dart';
import 'package:di360_flutter/feature/view_profile/query/pratice_view_profile_query.dart';
import 'package:di360_flutter/feature/view_profile/query/professional_view_profile_query.dart';
import 'package:di360_flutter/feature/view_profile/query/update_profile_logo.dart';
import 'package:di360_flutter/feature/view_profile/query/update_profile_query.dart';
import 'package:di360_flutter/feature/view_profile/query/view_profile_query.dart';
import 'package:di360_flutter/feature/view_profile/repository/view_profile_repository.dart';

class ViewProfileRepoImpl extends ViewProfileRepository {
  final HttpService http = HttpService();

  @override
  Future<DentalSuppliersByPk?> getViewProfileData() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {"id": userId};
    final res = await http.query(viewProfileQuery, variables: variables);
    final parsed = profileViewData.fromJson(res);
    return parsed.dentalSuppliersByPk;
  }

  @override
  Future<dynamic> updateViewProfileData(Map<String, dynamic> data) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final res = await http.mutation(
        type == 'PRACTICE'
            ? updatePracticeViewProfileDataQuery
            : type == 'PROFESSIONAL'
                ? updateProfessionalProfileDataQuery
                : updateViewProfileDataQuery,
        data);
    return res;
  }

  @override
  Future uploadLogo(Map<String, dynamic> data) async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final res = await http.mutation(
        type == 'PRACTICE'
            ? updatePracticeProfileLogoQuery
            : type == 'PROFESSIONAL'
                ? updateProfessProfileLogoQuery
                : updateProfileLogoQuery,
        data);
    return res;
  }

  @override
  Future<DentalPracticesByPk?> getPracticeViewProfileData() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {"id": userId};
    final res =
        await http.query(practiceViewProfileQuery, variables: variables);
    final parsed = PracticeProfileData.fromJson(res);
    return parsed.dentalPracticesByPk;
  }

  @override
  Future<DentalProfessionalsByPk?> getProfessionalViewProfile() async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {"id": userId};
    final res =
        await http.query(professionalViewProfileQuery, variables: variables);
    final parsed = ProfessionalData.fromJson(res);
    return parsed.dentalProfessionalsByPk;
  }

  @override
  Future<dynamic> deleteAccount() async {
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await http.mutation(
        type == 'PRACTICE'
            ? deletePracticeAccountQuery
            : type == 'PROFESSIONAL'
                ? deleteProfessionalAccountQuery
                : deleteSupplierAccountQuery,
        {"id": userId});
    return res;
  }
}
