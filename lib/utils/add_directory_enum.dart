enum AddDirectoryStep {
  Basic(0),
  Services(1),
  Certificates(2),
  Achievements(3),
  Documents(4),
  OurTeam(5),
  Partners(6),
  Gallery(7),
  //Appointments(8),
  Faqs(8),
  Testimonials(9),
  OtherInformation(10);
  final int value;
  const AddDirectoryStep(this.value);
}

enum ProfessAddDirectoryStep {
  Basic(0),
  Education(1),
  // Certificates(2),
  // Achievements(3),
  // Gallery(4),
  // Testimonials(5),
  OtherInformation(2);
  final int value;
  const ProfessAddDirectoryStep(this.value);
}
