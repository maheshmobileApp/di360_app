enum AddDirectoryStep {
  Basic(0),
  Services(1),
  Certificates(2),
  Achievements(3),
  Documents(4),
  OurTeam(5),
  Gallery(6),
  Appointments(7),
  Faqs(8),
  Testimonials(9),
  OtherInformation(10);
  final int value;
  const AddDirectoryStep(this.value);
}

enum ProfessAddDirectoryStep {
  Basic(0),
  Education(1),
  Certificates(2),
  Achievements(3),
  Gallery(4),
  Testimonials(5),
  OtherInformation(6);
  final int value;
  const ProfessAddDirectoryStep(this.value);
}
