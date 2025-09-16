class Experience {
  final String jobTitle;
  final String company;
  final String? startMonth;
  final String? startYear;
  final String? endMonth;
  final String? endYear;
  final bool isStillWorking;
  final String description;

  Experience({
    required this.jobTitle,
    required this.company,
    this.startMonth,
    this.startYear,
    this.endMonth,
    this.endYear,
    this.isStillWorking = false,
    required this.description,
  });
}
