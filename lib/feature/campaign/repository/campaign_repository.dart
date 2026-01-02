import 'package:di360_flutter/feature/campaign/model/get_campaign_list_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_states_by_groups_res.dart';

abstract class CampaignRepository {
  Future<CampaignListData> getCampaignListData(dynamic variables);
  Future<StatesByGroupsData> getStatesByGroups(dynamic variables);
  Future<dynamic> deleteCampaign(dynamic variables);
}
