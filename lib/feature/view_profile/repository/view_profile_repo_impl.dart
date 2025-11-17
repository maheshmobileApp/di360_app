import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/view_profile/model/view_profile_data.dart';
import 'package:di360_flutter/feature/view_profile/query/update_profile_logo.dart';
import 'package:di360_flutter/feature/view_profile/query/update_profile_query.dart';
import 'package:di360_flutter/feature/view_profile/query/view_profile_query.dart';
import 'package:di360_flutter/feature/view_profile/repository/view_profile_repository.dart';

class ViewProfileRepoImpl extends ViewProfileRepository {
  final HttpService http = HttpService();

  @override
  Future<DentalSuppliersByPk?> getViewProfileData(
      String id, String userType) async {
    final variables = {"id": id};
    final res = await http.query(viewProfileQuery, variables: variables);
    final parsed = profileViewData.fromJson(res);
    print(parsed);
    return parsed.dentalSuppliersByPk;
  }

  @override
  Future<dynamic> updateViewProfileData(Map<String, dynamic> data) async {
    final res = await http.mutation(updateViewProfileDataQuery, data);
    return res;
  }
  
  @override
  Future uploadLogo(Map<String, dynamic> data) async {
    final res = await http.mutation(updateProfileLogoQuery, data);
    return res;
  }
}
