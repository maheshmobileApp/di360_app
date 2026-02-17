import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/campaign/model/get_campaign_details_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_campaign_list_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_contact_count_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_contacts_res.dart';
import 'package:di360_flutter/feature/campaign/model/get_states_by_groups_res.dart';
import 'package:di360_flutter/feature/campaign/repository/campaign_repo_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:di360_flutter/utils/date_utils.dart' as di360_date_utils;

class CampaignViewModel extends ChangeNotifier {
  final CampaignRepoImpl repo = CampaignRepoImpl();

  TextEditingController campaignNameController = TextEditingController();
  TextEditingController scheduleTimeController = TextEditingController();
  TextEditingController scheduleDateController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  CampaignViewModel() {
    searchController.addListener(notifyListeners);
  }

  bool hasUnsavedChanges() {
    return campaignNameController.text.isNotEmpty ||
        scheduleTimeController.text.isNotEmpty ||
        scheduleDateController.text.isNotEmpty ||
        messageController.text.isNotEmpty ||
        _selectedGroupChips.isNotEmpty ||
        _selectedStateChips.isNotEmpty ||
        selectedType.isNotEmpty;
  }

  bool searchBarOpen = false;

  void setSearchBar(bool val) {
    searchBarOpen = val;
    notifyListeners();
  }

  void toggleSearchBar() {
    searchBarOpen = !searchBarOpen;
    if (!searchBarOpen) {
      searchController.clear();
    }
    notifyListeners();
  }

  String _formatDate(DateTime date) {
    return di360_date_utils.DateFormatUtils.formatToDayMonthYear(date);
  }

  String selectStateCondition = "No";
  bool repeatMode = false;
  bool smsFilterStatus = false;
  bool emailFilterStatus = false;
  bool htmlFilterStatus = false;
  bool emailWithPdfFilterStatus = false;

  void setRepeatMode(bool value) {
    repeatMode = value;
    notifyListeners();
  }

  void setSmsFilterStatus(bool value) {
    smsFilterStatus = value;
    notifyListeners();
  }

  void setEmailFilterStatus(bool value) {
    emailFilterStatus = value;
    notifyListeners();
  }

  void setHtmlFilterStatus(bool value) {
    htmlFilterStatus = value;
    notifyListeners();
  }

  void setEmailWithPdfFilterStatus(bool value) {
    emailWithPdfFilterStatus = value;
    notifyListeners();
  }

  void clearAllFilters() {
    smsFilterStatus = false;
    emailFilterStatus = false;
    htmlFilterStatus = false;
    emailWithPdfFilterStatus = false;
    notifyListeners();
  }

  List<SmsCampaign> get filteredCampaigns {
    var list = campaignListData?.smsCampaign ?? [];

    // Apply search filter
    if (searchController.text.isNotEmpty) {
      list = list
          .where((c) =>
              (c.campaignName
                      ?.toLowerCase()
                      .contains(searchController.text.toLowerCase()) ??
                  false) ||
              (c.messageChannel
                      ?.toLowerCase()
                      .contains(searchController.text.toLowerCase()) ??
                  false) ||
              (c.status
                      ?.toLowerCase()
                      .contains(searchController.text.toLowerCase()) ??
                  false))
          .toList();
    }

    // Apply channel filters
    bool hasChannelFilter = smsFilterStatus ||
        emailFilterStatus ||
        htmlFilterStatus ||
        emailWithPdfFilterStatus;
    if (hasChannelFilter) {
      list = list.where((c) {
        bool channelMatch = (smsFilterStatus && c.messageChannel == 'SMS') ||
            (emailFilterStatus && c.messageChannel == 'EMAIL') ||
            (htmlFilterStatus && c.messageChannel == 'HTML') ||
            (emailWithPdfFilterStatus && c.messageChannel == 'EMAIL_WITH_PDF');
        return channelMatch;
      }).toList();
    }

    return list;
  }

  void setStateCondition(String condition) {
    selectStateCondition = condition;
    notifyListeners();
  }

  DateTime scheduledDate = DateTime.now();
  void setScheduleDate(DateTime date) {
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

  Map<String, bool> filterOptions = {
    "SMS": false,
    "Email": false,
    "HTML": false,
    "Email with PDF": false,
  };

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

  String selectedTimeZone = "";
  void setSelectedTimeZone(String zone) {
    selectedTimeZone = zone;
    notifyListeners();
  }

  String selectedType = "";
  void setSelectedType(String type) async {
    selectedType = type;
    sendOptions = [];
    _selectedSendChips = [];
    notifyListeners();

    // Only call getContacts if groups are already selected
    if (_selectedGroupChips.isNotEmpty) {
      await getContacts();
    }
  }

  List<String> _selectedGroupChips = [];
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

  List<String> _selectedStateChips = [];
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

  List<String> _selectedSendChips = [];
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
  int _campaignOffset = 0;
  int _campaignLimit = 10;
  bool _hasMoreCampaigns = true;
  bool _isLoadingMoreCampaigns = false;

  bool get hasMoreCampaigns => _hasMoreCampaigns;
  bool get isLoadingMoreCampaigns => _isLoadingMoreCampaigns;

  Future<void> getCampaignListing({bool loadMore = false}) async {
    try {
      if (loadMore) {
        if (_isLoadingMoreCampaigns || !_hasMoreCampaigns) return;
        _isLoadingMoreCampaigns = true;
      } else {
        resetListingState();
        _campaignOffset = 0;
        _hasMoreCampaigns = true;
      }

      final variables = {
        "limit": _campaignLimit,
        "offset": _campaignOffset,
        "where": {}
      };
      final res = await repo.getCampaignListData(variables);

      if (!loadMore) {
        searchController.text = "";
      }

      if (res?.smsCampaign != null) {
        if (loadMore) {
          campaignListData?.smsCampaign?.addAll(res?.smsCampaign ?? []);
        } else {
          campaignListData = res;
        }
        _hasMoreCampaigns = (res?.smsCampaign?.length ?? 0) == _campaignLimit;
        _campaignOffset += res?.smsCampaign?.length ?? 0;
      }

      if (loadMore) {
        _isLoadingMoreCampaigns = false;
      }
      notifyListeners();
    } catch (e) {
      if (loadMore) {
        _isLoadingMoreCampaigns = false;
      }
    }
  }

  CampaignDetailsData? campaignDetails;

  Future<void> getCampaignDetails(String id) async {
    try {
      final variables = {"id": id};
      final res = await repo.getCampaignDetails(variables);

      campaignDetails = res;
      final data = campaignDetails?.smsCampaignByPk;
      campaignNameController.text = data?.campaignName ?? "";
      scheduleDateController.text = data?.scheduleDate ?? "";
      scheduleTimeController.text = "";
      selectedTimeZone = timeOptions.firstWhere(
        (element) => element.contains(data?.scheduleTimezone ?? ""),
        orElse: () => "",
      );
      selectedType = data?.messageChannel ?? "";
      _selectedStateChips = (data?.refineState?.cast<String>()) ?? [];
      _selectedGroupChips = (data?.groups?.cast<String>()) ?? [];
      selectStateCondition = data?.isRefinedByState == "yes" ? "Yes" : "No";
      _selectedSendChips = (data?.sendToNumbers?.cast<String>()) ?? [];
      recipientsCount = data?.recipientsCount.toString() ?? "0";

      notifyListeners();
    } catch (e) {}
  }

  ContactCountData? contactCountData;
  Future<void> getContactCount() async {
    try {
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

      if (selectedStateChips.isNotEmpty) {
        whereClause["state"] = {"_in": selectedStateChips};
      }

      final variables = {"where": whereClause};
      final res = await repo.getContactCount(variables);

      contactCountData = res;
      recipientsCount = contactCountData
              ?.campaignContactsAggregate?.aggregate?.count
              .toString() ??
          "0";

      notifyListeners();
    } catch (e) {}
  }

  Future<void> createCampaign(BuildContext context) async {
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final userEmail = await LocalStorage.getStringVal(LocalStorageConst.emailId);
    Loaders.circularShowLoader(context);
    try {
      String messageChannel = selectedType;
      if (selectedType == "Email") {
        messageChannel = "EMAIL";
      } else if (selectedType == "Email with PDF") {
        messageChannel = "EMAIL_WITH_PDF";
      }

      final variables = {
        "fields": {
          "from_email": userEmail,
          "created_by_id": userId,
          "campaign_name": campaignNameController.text,
          "recipients_count": recipientsCount,
          "total_count": recipientsCount,
          "mobile_email_count": recipientsCount,
          "schedule_date": scheduleDateController.text,
          "schedule_time_local": scheduleTimeController.text,
          "schedule_timezone": selectedTimeZone,
          "email_design_json": null,
          "sms_segments_count": 1,
          "characters_used": messageController.text.length,
          "is_repeating": "no",
          "is_refined_by_state": selectStateCondition == "Yes" ? "yes" : "no",
          "refine_state": selectedStateChips,
          "groups": selectedGroupChips,
          "message_text": messageController.text,
          "send_to_numbers": selectedSendChips,
          "send_to_emails": null,
          "status": "PENDING",
          "email_subject": null,
          "email_attachments": [],
          "message_channel": messageChannel
        }
      };
      print("Create Campaign Variables: $variables");
      final res = await repo.createCampaign(variables);
      if (res != "") {
        await getCampaignListing();
        Loaders.circularHideLoader(context);
        scaffoldMessenger("Campaign successfully Created");

        navigationService.goBack();
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {}
  }

  ContactsData? contactsData;
  String recipientsCount = "0";

  Future<void> getContacts() async {
    try {
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
      final res = await repo.getContacts(variables);
      contactsData = res;
      /* recipientsCount =
          contactsData?.campaignContacts?.length.toString() ?? "0";*/
      sendOptions = (selectedType == "SMS")
          ? contactsData?.campaignContacts
                  ?.map((e) => e.phone ?? '')
                  .where((phone) => phone.isNotEmpty)
                  .toList() ??
              []
          : contactsData?.campaignContacts
                  ?.map((e) => e.email ?? '')
                  .where((email) => email.isNotEmpty)
                  .toList() ??
              [];
      notifyListeners();
    } catch (e) {}
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
    try {
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

      final res = await repo.getStatesByGroups(variables);
      if (res != null) {
        statesByGroups = res;
        stateOptions = statesByGroups?.campaignContacts
                ?.map((e) => e.state ?? '')
                .where((state) => state.isNotEmpty)
                .toList() ??
            [];
      }
      notifyListeners();
    } catch (e) {}
  }

  void resetListingState() {
    setSearchBar(false);
    clearAllFilters();
  }

  clearFields() {
    campaignNameController.clear();
    scheduleDateController.clear();
    scheduleTimeController.clear();
    messageController.clear();
    selectedTimeZone = "";
    selectedType = "";
    _selectedStateChips = [];
    _selectedGroupChips = [];
    _selectedSendChips = [];
    recipientsCount = "0";
    selectStateCondition = "No";
    notifyListeners();
  }
}
