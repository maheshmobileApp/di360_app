class UploadResponse {
  final String status;
  final String extension;
  final String fileId;
  final String mimeType;
  final String name;
  final int size;
  final String directory;
  final bool isPublic;
  final String url;

  UploadResponse({
    required this.status,
    required this.extension,
    required this.fileId,
    required this.mimeType,
    required this.name,
    required this.size,
    required this.directory,
    required this.isPublic,
    required this.url,
  });

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      status: json['status'] ?? '',
      extension: json['extension'] ?? '',
      fileId: json['file_id'] ?? '',
      mimeType: json['mime_type'] ?? '',
      name: json['name'] ?? '',
      size: json['size'] ?? 0,
      directory: json['directory'] ?? '',
      isPublic: json['isPublic'] ?? false,
      url: json['url'] ?? '',
    );
  }
}
