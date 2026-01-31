import 'package:di360_flutter/feature/team_members/model/get_sub_supplier_res.dart';
import 'package:di360_flutter/feature/team_members/model/get_team_members_res.dart';

abstract class TeamMembersRepository {
  Future<TeamMembersData> getTeamMembers(dynamic variables);
  Future<dynamic> createTeamMember(dynamic variables);
    Future<dynamic> updateTeamMember(dynamic variables);
  Future<dynamic> deleteTeamMember(dynamic variables);
  Future<dynamic> deleteSupplierAccess(dynamic variables);
  Future<SubSupplierData> getSubSupplier(dynamic variables);
}
