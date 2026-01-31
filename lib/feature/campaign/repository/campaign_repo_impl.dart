import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/campaign/model/get_campaign_details_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_campaign_list_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_contact_count_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_contacts_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_states_by_groups_res.dart';
import 'package:di360_flutter/feature/campaign/query/create_campaign_query.dart';
import 'package:di360_flutter/feature/campaign/query/delete_campaign_query.dart';
import 'package:di360_flutter/feature/campaign/query/get_campaign_details_query.dart';
import 'package:di360_flutter/feature/campaign/query/get_campaign_list_query.dart';
import 'package:di360_flutter/feature/campaign/query/get_contact_count_query.dart';
import 'package:di360_flutter/feature/campaign/query/get_contacts_query.dart';
import 'package:di360_flutter/feature/campaign/query/get_states_by_groups_query.dart';
import 'package:di360_flutter/feature/campaign/repository/campaign_repository.dart';

class CampaignRepoImpl extends CampaignRepository{
  final HttpService http = HttpService();
  @override
  Future<CampaignListData?> getCampaignListData(variables) async {
    print("*****************Calling getCamaign List");
    try {
      final res = await http.query(getCampaignListQuery, variables: variables);
      if (res != null) {
        final data = CampaignListData.fromJson(res);
        return data;
      }
      return null;
    } catch (e) {
      print("Error in getCampaignListData: $e");
      return null;
    }
  }

  @override
  Future<StatesByGroupsData?> getStatesByGroups(variables) async {
    try {
      final res = await http.query(getStatesByGroupsQuery, variables: variables);
      if (res != null) {
        final data = StatesByGroupsData.fromJson(res);
        return data;
      }
      return null;
    } catch (e) {
      print("Error in getStatesByGroups: $e");
      return null;
    }
  }
  
  @override
  Future deleteCampaign(variables) async {
    final res = await http.mutation(deleteCampaignQuery, variables);
    return res;
  }

  @override
  Future<ContactsData> getContacts(variables) async {
    final res = await http.query(getContactsQuery, variables:variables);
    final data = ContactsData.fromJson(res);
    return data;
  }
  
  @override
  Future createCampaign(variables) async {
    final res = await http.mutation(createCampaignQuery,variables);
    return res;
  }

  @override
  Future<CampaignDetailsData> getCampaignDetails(variables) async {
    final res = await http.query(getCampaignDetailsQuery,variables: variables);
    final data = CampaignDetailsData.fromJson(res);
    return data;
  }

  @override
  Future<ContactCountData> getContactCount(variables) async {
    final res = await http.query(getContactCountQuery,variables: variables);
    final data = ContactCountData.fromJson(res);
    return data;
  }

 

  
}