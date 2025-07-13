class JobSeekFilterWorktypeRespon {
  final String id;
  final String employeeTypeName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String createdByUserId;

  JobSeekFilterWorktypeRespon({
    required this.id,
    required this.employeeTypeName,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.createdByUserId,
  });

  factory JobSeekFilterWorktypeRespon.fromJson(Map<String, dynamic> json) {
    return JobSeekFilterWorktypeRespon(
      id: json['id'] as String,
      employeeTypeName: json['employee_type_name'] as String,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      createdBy: json['created_by'] as String,
      createdByUserId: json['created_by_user_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_type_name': employeeTypeName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'created_by': createdBy,
      'created_by_user_id': createdByUserId,
    };
  }
}

class JobSeekFilterWorktypeListResponse {
  final List<JobSeekFilterWorktypeRespon> jobTypes;

  JobSeekFilterWorktypeListResponse({required this.jobTypes});

  factory JobSeekFilterWorktypeListResponse.fromJson(Map<String, dynamic> json) {
    final types = json['job_types'] as List<dynamic>;
    return JobSeekFilterWorktypeListResponse(
      jobTypes: types.map((e) => JobSeekFilterWorktypeRespon.fromJson(e)).toList(),
    );
  }
}
