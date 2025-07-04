import 'dart:convert';

import 'package:di360_flutter/feature/job_create/model/resp/emp_types_model.dart';
import 'package:di360_flutter/feature/job_create/model/resp/job_roles_model.dart';
import 'package:di360_flutter/feature/job_create/repository/job_create_repository.dart';
import 'package:flutter/services.dart';

class JobCreateRepoImpl extends JobCreateRepository {
  @override
  Future<List<JobsRoleList>> getJobRoles() async {
    final response = await rootBundle.loadString('assets/roles.json');
    final data = json.decode(response);
    final model = GetJobRolesModel.fromJson(data); 
    return model.data?.jobsRoleList??[];
  }

  @override
  Future<List<JobTypes>> getEmpTypes() async {
    final response = await rootBundle.loadString('assets/job_type.json');
    final data = json.decode(response);
    final model = GetEmpTypesModel.fromJson(data); 
    return model.data?.jobTypes??[];
   
  }
}
