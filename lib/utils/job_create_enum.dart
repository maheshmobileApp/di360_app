enum JobCreateSteps {
  JOBINFO(0),
  LOGOANDBANNER(1),
  JOBLOCATION(2),
  OTHERINFO(3),
  PAY(4),
  OTHERLINKS(5);
  final int value;
  const JobCreateSteps(this.value);
}
