import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/campaign/model/get_campaign_list_res.dart';
import 'package:di360_flutter/feature/campaign/repository/campaign_repo_impl.dart';
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

  void setStateCondition(String condition){
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

  List<String> empOptions = [
    "Community members",
    "Contact-Partner",
    "Contact-Member"
  ];

  List<String> stateOptions = [
  ];
  List<String> sendOptions = [
  ];

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

  final List<String> _selectedEmploymentChips = [];
  List<String> get selectedEmploymentChips =>
      List.unmodifiable(_selectedEmploymentChips);
  void removeEmploymentTypeChip(String empType) {
    _selectedEmploymentChips.remove(empType);
    notifyListeners();
  }

  void addEmploymentTypeChip(String empType) {
    if (!_selectedEmploymentChips.contains(empType)) {
      _selectedEmploymentChips.add(empType);
      notifyListeners();
    }
  }

  final List<String> _selectedStateChips = [];
  List<String> get selectedStateChips =>
      List.unmodifiable(_selectedStateChips);
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
  List<String> get selectedSendChips =>
      List.unmodifiable(_selectedSendChips);
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

  Future<void> getCampaignListing() async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final variables = {"limit": 10, "offset": 0, "where": {}};
    final res = await repo.getCampaignListData(variables);
    if (res.smsCampaign?.length != 0) {
      campaignListData = res;
    }
    notifyListeners();
  }
}
