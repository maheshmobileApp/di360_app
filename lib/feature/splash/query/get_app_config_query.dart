const String getAppConfigQuery = r'''
query GetAppConfig($platform: String!) {
  app_config(
    where: { platform: { _eq: $platform } }
    limit: 1
  ) {
    id
    platform
    storeUrl
    message
    forceUpdate
    minSupportedVersion
    latestVersion
  }
}
''';
