class Education {
  final String qualification;
  final String institution;
  final String? finishDate;
  final String? expectedFinishDate;
  final String selectedQualification;
  final String courseHighlights;
  final bool? qualificationFinished;

  Education({
    required this.qualification,
    required this.institution,
    this.finishDate,
    this.expectedFinishDate,
    required this.selectedQualification,
    required this.courseHighlights,
    this.qualificationFinished,
  });
  factory Education.fromJson(Map<String, dynamic> json) {
    bool? qualificationFinished;
    if (json['qualificationFinished'] is bool) {
      qualificationFinished = json['qualificationFinished'];
    } else if (json['qualificationFinished'] is String) {
      qualificationFinished =
          json['qualificationFinished'].toLowerCase() == 'true';
    }
    return Education(
      finishDate: json['finishDate'],
      institution: json['institution'],
      qualification: json['qualification'],
      courseHighlights: json['courseHighlights'],
      qualificationFinished: qualificationFinished,
      selectedQualification: '',
    );
  }

  Map<String, dynamic> toJson() => {
        'finishDate': finishDate,
        'institution': institution,
        'qualification': qualification,
        'courseHighlights': courseHighlights,
        'qualificationFinished': qualificationFinished,
      };
}

