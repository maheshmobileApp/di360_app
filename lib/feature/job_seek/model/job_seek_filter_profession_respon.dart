class JobSeekFilterProfessionRespon {
  final String id;
  final String roleName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String createdByUserId;

  JobSeekFilterProfessionRespon({
    required this.id,
    required this.roleName,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.createdByUserId,
  });

  factory JobSeekFilterProfessionRespon.fromJson(Map<String, dynamic> json) {
    return JobSeekFilterProfessionRespon(
      id: json['id'] as String,
      roleName: json['role_name'] as String,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      createdBy: json['created_by'] as String,
      createdByUserId: json['created_by_user_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_name': roleName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'created_by': createdBy,
      'created_by_user_id': createdByUserId,
    };
  }
}

class JobSeekFilterProfessionListResponse {
  final List<JobSeekFilterProfessionRespon> jobsRoleList;

  JobSeekFilterProfessionListResponse({required this.jobsRoleList});

  factory JobSeekFilterProfessionListResponse.fromJson(Map<String, dynamic> json) {
    final roles = json['jobs_role_list'] as List<dynamic>;
    return JobSeekFilterProfessionListResponse(
      jobsRoleList: roles.map((e) => JobSeekFilterProfessionRespon.fromJson(e)).toList(),
    );
  }
}
