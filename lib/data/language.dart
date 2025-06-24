class Languages {
  const Languages._();

static const languages = [
    LanguageEntity(code: 'en', value: 'English'),
    LanguageEntity(code: "te", value: "Telugu"),
  ];
}

class LanguageEntity {
  final String code;
  final String value;

  const LanguageEntity({required this.code, required this.value});
}