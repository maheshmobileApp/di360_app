import 'package:di360_flutter/feature/campaign/model/get_campaign_list_res.dart';

abstract class CampaignRepository {

  Future<CampaignListData> getCampaignListData(dynamic variables);

}