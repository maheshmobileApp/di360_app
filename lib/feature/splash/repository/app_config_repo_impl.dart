import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/splash/model/app_config_model.dart';
import 'package:di360_flutter/feature/splash/query/get_app_config_query.dart';
import 'package:di360_flutter/feature/splash/repository/app_config_repository.dart';

class AppConfigRepoImpl extends AppConfigRepository {
  final HttpService http = HttpService();

  @override
  Future<AppConfigModel?> getAppConfig(String platform) async {
    final response =
        await http.query(getAppConfigQuery, variables: {'platform': platform});

    if (response is! Map<String, dynamic>) {
      return null;
    }

    final configs = response['app_config'];
    if (configs is! List || configs.isEmpty) {
      return null;
    }

    final firstConfig = configs.first;
    if (firstConfig is! Map<String, dynamic>) {
      return null;
    }

    return AppConfigModel.fromJson(firstConfig);
  }
}
