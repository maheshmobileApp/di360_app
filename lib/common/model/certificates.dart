class FileUpload {
  final String? url;
  final String? name;
  final String? type;
  final String? extension;

  FileUpload({
    this.url,
    this.name,
    this.type,
    this.extension,
  });

  factory FileUpload.fromJson(Map<String, dynamic> json) => FileUpload(
        url: json["url"],
        name: json["name"],
        type: json["type"],
        extension: json["extension"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
        "type": type,
        "extension": extension,
      };
}
