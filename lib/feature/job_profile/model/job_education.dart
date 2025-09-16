class Education {
  final String qualification;
  final String institution;
  final String? finishDate;
  final String? expectedFinishDate;
  final String selectedQualification;
  final String courseHighlights;

  Education({
    required this.qualification,
    required this.institution,
    this.finishDate,
    this.expectedFinishDate,
    required this.selectedQualification,
    required this.courseHighlights,
  });
}



