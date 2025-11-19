class AppConfig {
  static final String hasuraBaseUrl = const String.fromEnvironment('NG_APP_HASURA_INTERNAL_URL');
  static final String serverBaseUrl = const String.fromEnvironment('NG_APP_SERVER_PATH');
}
