class Attachment {
  final String url;
  final String name;
  final String type;

  Attachment({
    required this.url,
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'type': type,
    };
  }

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
