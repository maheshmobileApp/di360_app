class JobsTypesListRes {
  JobsTypesData? data;

  JobsTypesListRes({this.data});

  JobsTypesListRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new JobsTypesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class JobsTypesData {
  List<JobTypes>? jobTypes;

  JobsTypesData({this.jobTypes});

  JobsTypesData.fromJson(Map<String, dynamic> json) {
    if (json['job_types'] != null) {
      jobTypes = <JobTypes>[];
      json['job_types'].forEach((v) {
        jobTypes!.add(new JobTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobTypes != null) {
      data['job_types'] = this.jobTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobTypes {
  String? id;
  String? employeeTypeName;
  String? sTypename;

  JobTypes({this.id, this.employeeTypeName, this.sTypename});

  JobTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeTypeName = json['employee_type_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_type_name'] = this.employeeTypeName;
    data['__typename'] = this.sTypename;
    return data;
  }
}
