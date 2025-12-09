class ExistingFile {
  final String url;
  final String type;
  final String name;

  ExistingFile({required this.url, required this.type, required this.name});

  bool get isBase64Image => url.startsWith('data:image/');
}
