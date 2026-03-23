class AppConfigModel {
  final String id;
  final String platform;
  final String storeUrl;
  final String message;
  final bool forceUpdate;
  final String minSupportedVersion;
  final String latestVersion;

  AppConfigModel({
    required this.id,
    required this.platform,
    required this.storeUrl,
    required this.message,
    required this.forceUpdate,
    required this.minSupportedVersion,
    required this.latestVersion,
  });

  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    return AppConfigModel(
      id: json['id']?.toString() ?? '',
      platform: json['platform']?.toString() ?? '',
      storeUrl: json['storeUrl']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      forceUpdate: json['forceUpdate'] == true,
      minSupportedVersion: json['minSupportedVersion']?.toString() ?? '0.0.0',
      latestVersion: json['latestVersion']?.toString() ?? '0.0.0',
    );
  }
}
