import 'package:di360_flutter/feature/campaign/model/get_campaign_details_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_campaign_list_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_contacts_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_states_by_groups_res.dart';

abstract class CampaignRepository {
  Future<CampaignListData?> getCampaignListData(dynamic variables);
  Future<StatesByGroupsData?> getStatesByGroups(dynamic variables);
  Future<dynamic> deleteCampaign(dynamic variables);
  Future<ContactsData> getContacts(dynamic variables);
  Future<dynamic> createCampaign(dynamic variables);
  Future<CampaignDetailsData> getCampaignDetails(dynamic variables);
}
