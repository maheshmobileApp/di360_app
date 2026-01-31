import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/team_members/model/get_sub_supplier_res.dart';
import 'package:di360_flutter/feature/team_members/model/get_team_members_res.dart';
import 'package:di360_flutter/feature/team_members/query/create_team_member_query.dart';
import 'package:di360_flutter/feature/team_members/query/delete_supplier_access_query.dart';
import 'package:di360_flutter/feature/team_members/query/delete_team_member_query.dart';
import 'package:di360_flutter/feature/team_members/query/get_sub_supplier_query.dart';
import 'package:di360_flutter/feature/team_members/query/get_team_members_query.dart';
import 'package:di360_flutter/feature/team_members/query/update_team_member_query.dart';
import 'package:di360_flutter/feature/team_members/repository/team_members_repository.dart';

class TeamMembersRepoImpl extends TeamMembersRepository{
  final HttpService http = HttpService();
  @override
  Future<TeamMembersData> getTeamMembers(variables) async {
    final res = await http.query(getTeamMembersQuery, variables: variables);
    final data = TeamMembersData.fromJson(res);
    return data;
  }
  
  @override
  Future createTeamMember(variables)  async {
    final res = await http.mutation(createTeamMemberQuery, variables);
    return res;
  }

   @override
  Future updateTeamMember(variables)  async {
    final res = await http.mutation(updateTeamMemberQuery, variables);
    return res;
  }

   
  @override
  Future deleteTeamMember(variables)  async {
    final res = await http.mutation(deleteTeamMemberQuery, variables);
    return res;
  }

   @override
  Future deleteSupplierAccess(variables)  async {
    final res = await http.mutation(deleteSupplierAccessQuery, variables);
    return res;
  }

  @override
  Future<SubSupplierData> getSubSupplier(variables)  async {
    final res = await http.query(getSubSupplierQuery,variables: variables);
    final data = SubSupplierData.fromJson(res);
    return data;
  }

  
}