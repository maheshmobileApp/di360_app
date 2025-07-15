class JobSeekFilterModel {
  Where? where;

  JobSeekFilterModel({this.where});

  factory JobSeekFilterModel.fromJson(Map<String, dynamic> json) {
    return JobSeekFilterModel(
      where: json['where'] != null ? Where.fromJson(json['where']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (where != null) {
      data['where'] = where!.toJson();
    }
    return data;
  }
}

class Where {
  List<And>? andList;

  Where({this.andList});

  factory Where.fromJson(Map<String, dynamic> json) {
    return Where(
      andList: json['_and'] != null
          ? (json['_and'] as List).map((v) => And.fromJson(v)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_and': andList?.map((v) => v.toJson()).toList() ?? [],
    };
  }
}

class And {
  Status? status;
  JRole? jRole;
  TypeofEmployment? typeofEmployment;
  Status? yearsOfExperience;
  TypeofEmployment? availabilityDate;

  And({
    this.status,
    this.jRole,
    this.typeofEmployment,
    this.yearsOfExperience,
    this.availabilityDate,
  });

  factory And.fromJson(Map<String, dynamic> json) {
    return And(
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      jRole: json['j_role'] != null ? JRole.fromJson(json['j_role']) : null,
      typeofEmployment: json['TypeofEmployment'] != null
          ? TypeofEmployment.fromJson(json['TypeofEmployment'])
          : null,
      yearsOfExperience: json['years_of_experience'] != null
          ? Status.fromJson(json['years_of_experience'])
          : null,
      availabilityDate: json['availability_date'] != null
          ? TypeofEmployment.fromJson(json['availability_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (status != null) data['status'] = status!.toJson();
    if (jRole != null) data['j_role'] = jRole!.toJson();
    if (typeofEmployment != null) {
      data['TypeofEmployment'] = typeofEmployment!.toJson();
    }
    if (yearsOfExperience != null) {
      data['years_of_experience'] = yearsOfExperience!.toJson();
    }
    if (availabilityDate != null) {
      data['availability_date'] = availabilityDate!.toJson();
    }
    return data;
  }
}

class Status {
  String? sEq;

  Status({this.sEq});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(sEq: json['_eq']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_eq': sEq,
    };
  }
}

class JRole {
  List<String>? inList;

  JRole({this.inList});

  factory JRole.fromJson(Map<String, dynamic> json) {
    return JRole(
      inList: json['_in']?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_in': inList,
    };
  }
}

class TypeofEmployment {
  List<String>? hasKeysAny;

  TypeofEmployment({this.hasKeysAny});

  factory TypeofEmployment.fromJson(Map<String, dynamic> json) {
    return TypeofEmployment(
      hasKeysAny: json['_has_keys_any']?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_has_keys_any': hasKeysAny,
    };
  }
}
