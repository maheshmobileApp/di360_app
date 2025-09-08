class JobProfileUpdatedRespo {
  final UpdateJobProfilesByPk? updateJobProfilesByPk;

  JobProfileUpdatedRespo({this.updateJobProfilesByPk});

  factory JobProfileUpdatedRespo.fromJson(Map<String, dynamic> json) {
    return JobProfileUpdatedRespo(
      updateJobProfilesByPk: json['update_job_profiles_by_pk'] != null
          ? UpdateJobProfilesByPk.fromJson(json['update_job_profiles_by_pk'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'update_job_profiles_by_pk': updateJobProfilesByPk?.toJson(),
    };
  }
}

class UpdateJobProfilesByPk {
  final String? id;
  final String? activeStatus;

  UpdateJobProfilesByPk({this.id, this.activeStatus});

  factory UpdateJobProfilesByPk.fromJson(Map<String, dynamic> json) {
    return UpdateJobProfilesByPk(
      id: json['id'] as String?,
      activeStatus: json['active_status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active_status': activeStatus,
    };
  }
}
