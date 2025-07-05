class JobApplicantsResponse {
  final List<JobApplicant> jobApplicants;

  JobApplicantsResponse({
    required this.jobApplicants,
  });

  factory JobApplicantsResponse.fromJson(Map<String, dynamic> json) {
    return JobApplicantsResponse(
      jobApplicants: (json['job_applicants'] as List<dynamic>?)
              ?.map(
                  (item) => JobApplicant.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }



}

class JobApplicant {
  final String id;
  final String dentalProfessionalId;

  JobApplicant({
    required this.id,
    required this.dentalProfessionalId,
  });

  factory JobApplicant.fromJson(Map<String, dynamic> json) {
    return JobApplicant(
      id: json['id'] as String? ?? '',
      dentalProfessionalId: json['dental_professional_id'] as String? ?? '',
    );
  }

}
