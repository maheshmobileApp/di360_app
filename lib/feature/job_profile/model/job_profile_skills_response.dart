class JobProfileSkillsResponse {
  final List<JobSkill> jobSkills;

 JobProfileSkillsResponse({required this.jobSkills});

  factory JobProfileSkillsResponse.fromJson(Map<String, dynamic> json) {
    return JobProfileSkillsResponse(
      jobSkills: (json['job_skills'] as List<dynamic>? ?? [])
          .map((e) => JobSkill.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'job_skills': jobSkills.map((e) => e.toJson()).toList(),
      };
}

class JobSkill {
  final String id;
  final String name;
  final DateTime createdAt;

  JobSkill({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory JobSkill.fromJson(Map<String, dynamic> json) {
    return JobSkill(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt.toIso8601String(),
      };
}