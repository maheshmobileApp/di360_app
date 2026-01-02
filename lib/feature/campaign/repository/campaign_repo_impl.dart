import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/campaign/model/get_campaign_list_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_states_by_groups_res.dart';
import 'package:di360_flutter/feature/campaign/query/delete_campaign_query.dart';
import 'package:di360_flutter/feature/campaign/query/get_campaign_list_query.dart';
import 'package:di360_flutter/feature/campaign/query/get_states_by_groups_query.dart';
import 'package:di360_flutter/feature/campaign/repository/campaign_repository.dart';

class CampaignRepoImpl extends CampaignRepository{
  final HttpService http = HttpService();
  @override
  Future<CampaignListData> getCampaignListData(variables) async {
    final res = await http.query(getCampaignListQuery, variables: variables);
    final data = CampaignListData.fromJson(res);
    return data;
  }

  @override
  Future<StatesByGroupsData> getStatesByGroups(variables) async {
    final res = await http.query(getStatesByGroupsQuery, variables: variables);
    final data = StatesByGroupsData.fromJson(res);
    return data;
  }
  
  @override
  Future deleteCampaign(variables) async {
    final res = await http.mutation(deleteCampaignQuery, variables);
    return res;
  }
  
}