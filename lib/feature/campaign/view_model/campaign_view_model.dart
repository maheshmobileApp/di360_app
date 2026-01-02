import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/campaign/model/get_campaign_list_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_states_by_groups_res.dart';
import 'package:di360_flutter/feature/campaign/repository/campaign_repo_impl.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:di360_flutter/utils/date_utils.dart' as di360_date_utils;

class CampaignViewModel extends ChangeNotifier {
  final CampaignRepoImpl repo = CampaignRepoImpl();

  TextEditingController campaignNameController = TextEditingController();
  TextEditingController scheduleTimeController = TextEditingController();
  TextEditingController scheduleDateController = TextEditingController();
  String _formatDate(DateTime date) {
    return di360_date_utils.DateFormatUtils.formatToDayMonthYear(date);
  }

  String selectStateCondition = "";

  void setStateCondition(String condition) {
    selectStateCondition = condition;
    notifyListeners();
  }

  DateTime scheduledDate = DateTime.now();
  void setStartLocumDate(DateTime date) {
    scheduledDate = date;
    scheduleDateController.text =
        di360_date_utils.DateFormatUtils.formatToYyyyMmDd(date);
    notifyListeners();
  }

  List<String> groupOptions = [
    "Community members",
    "Contact-Partner",
    "Contact-Member"
  ];

  List<String> stateOptions = [];
  List<String> sendOptions = [];

  List<String> typeOptions = ["SMS", "Email", "HTML", "Email with PDF"];

  List<String> timeOptions = [
    "(UTC+10:00) Canberra,Melbourne, Sydney",
    "(UTC+10:00) Brisbane",
    "(UTC+09:00) Adelaide",
    "(UTC+08:00) Perth",
    "(UTC+10:00) Hobart",
    "(UTC+09:30) Darwin",
    "(UTC+12:00) Auckland",
    "(UTC+12:45) Chatham Islands",
    "(UTC+05:30) India Standard Time"
  ];

  String selectedTime = "";
  void setSelectedTime(String time) {
    selectedTime = time;
    notifyListeners();
  }

  String selectedType = "";
  void setSelectedType(String type) {
    selectedType = type;
    notifyListeners();
  }

  final List<String> _selectedGroupChips = [];
  List<String> get selectedGroupChips => List.unmodifiable(_selectedGroupChips);
  void removeGroupTypeChip(String empType) {
    _selectedGroupChips.remove(empType);
    notifyListeners();
  }

  void addGroupTypeChip(String empType) {
    if (!_selectedGroupChips.contains(empType)) {
      _selectedGroupChips.add(empType);
      notifyListeners();
    }
  }

  final List<String> _selectedStateChips = [];
  List<String> get selectedStateChips => List.unmodifiable(_selectedStateChips);
  void removeStateTypeChip(String empType) {
    _selectedStateChips.remove(empType);
    notifyListeners();
  }

  void addStateTypeChip(String empType) {
    if (!_selectedStateChips.contains(empType)) {
      _selectedStateChips.add(empType);
      notifyListeners();
    }
  }

  final List<String> _selectedSendChips = [];
  List<String> get selectedSendChips => List.unmodifiable(_selectedSendChips);
  void removeSendTypeChip(String empType) {
    _selectedSendChips.remove(empType);
    notifyListeners();
  }

  void addSendTypeChip(String empType) {
    if (!_selectedSendChips.contains(empType)) {
      _selectedSendChips.add(empType);
      notifyListeners();
    }
  }

  CampaignListData? campaignListData;
  StatesByGroupsData? statesByGroups;

  Future<void> getCampaignListing() async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {"limit": 10, "offset": 0, "where": {}};
    final res = await repo.getCampaignListData(variables);
    if (res.smsCampaign?.length != 0) {
      campaignListData = res;
    } else {
      campaignListData = res;
    }
    notifyListeners();
  }

  Future<void> deleteCampaign(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": id};
    final res = await repo.deleteCampaign(variables);
    if (res != null) {
      await getCampaignListing();
      Loaders.circularHideLoader(context);
      scaffoldMessenger("Campaign Deleted Successfully");
    }
    notifyListeners();
  }

  Future<void> getStatesByGroups() async {
    print("***********************getStatesByGroups");
    List<String> sourceList = [];
    List<String> contactTypeList = [];

    if (_selectedGroupChips.contains("Community members")) {
      sourceList.add("community_members");
    }

    if (_selectedGroupChips.contains("Contact-Partner") ||
        _selectedGroupChips.contains("Contact-Member")) {
      sourceList.add("partners_contact_book");
    }

    if (_selectedGroupChips.contains("Contact-Partner")) {
      contactTypeList.addAll(["PARTNER"]);
    }

    if (_selectedGroupChips.contains("Contact-Member")) {
      contactTypeList.addAll(["MEMBER"]);
    }

    final Map<String, dynamic> whereClause = {
      "source": {"_in": sourceList}
    };

    if (contactTypeList.isNotEmpty) {
      whereClause["contact_type"] = {"_in": contactTypeList};
    }

    final variables = {"where": whereClause};
    print("***********************variables $variables");

    final res = await repo.getStatesByGroups(variables);
    if (res.campaignContacts?.length != 0) {
      statesByGroups = res;
      stateOptions = statesByGroups?.campaignContacts
              ?.map((e) => e.state ?? '')
              .where((state) => state.isNotEmpty)
              .toList() ??
          [];
    } else {
      statesByGroups = res;
    }
    notifyListeners();
  }
}
