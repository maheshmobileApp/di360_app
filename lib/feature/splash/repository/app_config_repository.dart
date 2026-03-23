import 'package:di360_flutter/feature/splash/model/app_config_model.dart';

abstract class AppConfigRepository {
  Future<AppConfigModel?> getAppConfig(String platform);
}
