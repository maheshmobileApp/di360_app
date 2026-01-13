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
import 'package:webview_flutter/webview_flutter.dart';

class CampaignViewModel extends ChangeNotifier {
  final CampaignRepoImpl repo = CampaignRepoImpl();

  TextEditingController campaignNameController = TextEditingController();
  TextEditingController scheduleTimeController = TextEditingController();
  TextEditingController scheduleDateController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  WebViewController? messageHTMLController;

  void initializeHTMLController() {
    messageHTMLController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(_getEditorHtml());
  }

  String _getEditorHtml() => '''
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
  body { font-family: Arial, sans-serif; margin: 0; }
  .toolbar {
    padding: 8px;
    border-bottom: 1px solid #ddd;
    background: #f7f7f7;
  }
  button { margin-right: 6px; }
  #editor {
    padding: 12px;
    min-height: 300px;
    outline: none;
  }
</style>
</head>
<body>
<div class="toolbar">
  <button onclick="document.execCommand('bold')"><b>B</b></button>
  <button onclick="document.execCommand('italic')"><i>I</i></button>
  <button onclick="document.execCommand('underline')"><u>U</u></button>
  <button onclick="document.execCommand('insertUnorderedList')">• List</button>
  <button onclick="document.execCommand('insertOrderedList')">1. List</button>
</div>
<div id="editor" contenteditable="true">
  <p>Write your email...</p>
</div>
</body>
</html>
''';

  Future<String> getHTMLContent() async {
    if (messageHTMLController == null) return "";

    final htmlContent =
        await messageHTMLController!.runJavaScriptReturningResult(
      'document.getElementById("editor").innerHTML;',
    );

    final fullHtml = '''<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Email</title>
</head>
<body>
${htmlContent.toString().replaceAll('"', '')}
</body>
</html>''';

    return fullHtml;
  }

  TextEditingController emailSubjectController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  bool searchBarOpen = false;
  String htmlEmailMessage = "";

  void setHtmlEmailMessage(String subject) {
    htmlEmailMessage = subject;
    notifyListeners();
  }

  Map<String, dynamic> htmlEmailDesignJson = {};

  void setHtmlEmailDesign(Map<String, dynamic> subject) {
    htmlEmailDesignJson = subject;
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

  Future<void> getCampaignListing() async {
    try {
      final variables = {"limit": 10, "offset": 0, "where": {}};
      final res = await repo.getCampaignListData(variables);
      searchController.text = "";

      campaignListData = res;
      notifyListeners();
    } catch (e) {
      print("Error in getCampaignListing: $e");
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
      print("******************************${data?.scheduleTimezone}");
      selectedType = data?.messageChannel ?? "";
      _selectedStateChips = (data?.refineState?.cast<String>()) ?? [];
      _selectedGroupChips = (data?.groups?.cast<String>()) ?? [];
      selectStateCondition = data?.isRefinedByState == "yes" ? "Yes" : "No";
      _selectedSendChips = (data?.sendToNumbers?.cast<String>()) ?? [];
      recipientsCount = data?.recipientsCount.toString() ?? "0";

      notifyListeners();
    } catch (e) {
      print("Error in getCampaignListing: $e");
    }
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
    } catch (e) {
      print("Error in getCampaignListing: $e");
    }
  }

  Future<void> createCampaign(BuildContext context) async {
    print("*******************create campaign calling");
    Loaders.circularShowLoader(context);
    try {
      final variables = {
        "fields": {
          "from_email": null,
          "campaign_name": campaignNameController.text,
          "recipients_count": recipientsCount,
          "total_count": recipientsCount,
          "mobile_email_count": recipientsCount,
          "schedule_date": scheduleDateController.text,
          "schedule_time_local": scheduleTimeController.text,
          "schedule_timezone": selectedTimeZone,
          "email_design_json": htmlEmailDesignJson,
          "sms_segments_count": 1,
          "characters_used": selectedType == "SMS" ? messageController.text.length : 0,
          "is_repeating": "no",
          "is_refined_by_state": selectStateCondition == "Yes" ? "yes" : "no",
          "refine_state": selectedStateChips,
          "groups": selectedGroupChips,
          "message_text": selectedType == "SMS" ? messageController.text : htmlEmailMessage,
          "send_to_numbers": selectedSendChips,
          "send_to_emails": null,
          "status": "PENDING",
          "email_subject": emailSubjectController.text,
          "email_attachments": [],
          "message_channel": selectedType == "Email with PDF" ? "EMAIL_WITH_PDF" : selectedType == "Email" ? "EMAIL" : selectedType
        }
      };
    /*  final variables = {
        "fields": {
          "from_email": "yernagulamahesh@gmail.com",
          "campaign_name": "mail test",
          "recipients_count": 1,
          "total_count": 1,
          "mobile_email_count": 1,
          "schedule_date": "2026-01-08",
          "schedule_time_local": "20:57",
          "schedule_timezone": "Australia/Brisbane",
          "message_text":
              "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\n<head>\n<!--[if gte mso 9]>\n<xml>\n  <o:OfficeDocumentSettings>\n    <o:AllowPNG/>\n    <o:PixelsPerInch>96</o:PixelsPerInch>\n  </o:OfficeDocumentSettings>\n</xml>\n<![endif]-->\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n  <meta name=\"x-apple-disable-message-reformatting\">\n  <!--[if !mso]><!--><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><!--<![endif]-->\n  <title></title>\n  \n    <style type=\"text/css\">\n      \n      @media only screen and (min-width: 520px) {\n        .u-row {\n          width: 500px !important;\n        }\n\n        .u-row .u-col {\n          vertical-align: top;\n        }\n\n        \n            .u-row .u-col-100 {\n              width: 500px !important;\n            }\n          \n      }\n\n      @media only screen and (max-width: 520px) {\n        .u-row-container {\n          max-width: 100% !important;\n          padding-left: 0px !important;\n          padding-right: 0px !important;\n        }\n\n        .u-row {\n          width: 100% !important;\n        }\n\n        .u-row .u-col {\n          display: block !important;\n          width: 100% !important;\n          min-width: 320px !important;\n          max-width: 100% !important;\n        }\n\n        .u-row .u-col > div {\n          margin: 0 auto;\n        }\n\n\n}\n    \nbody{margin:0;padding:0}table,td,tr{border-collapse:collapse;vertical-align:top}.ie-container table,.mso-container table{table-layout:fixed}*{line-height:inherit}a[x-apple-data-detectors=true]{color:inherit!important;text-decoration:none!important}\n\n\ntable, td { color: #000000; } #u_body a { color: #0000ee; text-decoration: underline; }\n    </style>\n  \n  \n\n</head>\n\n<body class=\"clean-body u_body\" style=\"margin: 0;padding: 0;-webkit-text-size-adjust: 100%;background-color: #F7F8F9;color: #000000\">\n  <!--[if IE]><div class=\"ie-container\"><![endif]-->\n  <!--[if mso]><div class=\"mso-container\"><![endif]-->\n  <table role=\"presentation\" id=\"u_body\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;min-width: 320px;Margin: 0 auto;background-color: #F7F8F9;width:100%\" cellpadding=\"0\" cellspacing=\"0\">\n  <tbody>\n  <tr style=\"vertical-align: top\">\n    <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\n    <!--[if (mso)|(IE)]><table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" style=\"background-color: #F7F8F9;\"><![endif]-->\n    \n  \n  \n<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\n  <div class=\"u-row\" style=\"margin: 0 auto;min-width: 320px;max-width: 500px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\">\n    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\n      <!--[if (mso)|(IE)]><table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:500px;\"><tr style=\"background-color: transparent;\"><![endif]-->\n      \n<!--[if (mso)|(IE)]><td align=\"center\" width=\"500\" style=\"width: 500px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\" valign=\"top\"><![endif]-->\n<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 500px;display: table-cell;vertical-align: top;\">\n  <div style=\"height: 100%;width: 100% !important;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\">\n  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\"><!--<![endif]-->\n  \n<table style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n  <tbody>\n    <tr>\n      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n        \n  <!--[if mso]><style>.v-button {background: transparent !important;}</style><![endif]-->\n<div align=\"center\">\n  <!--[if mso]><v:roundrect xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:w=\"urn:schemas-microsoft-com:office:word\" href=\"\" style=\"height:37px; v-text-anchor:middle; width:110px;\" arcsize=\"11%\"  stroke=\"f\" fillcolor=\"#0879A1\"><w:anchorlock/><center style=\"color:#FFFFFF;\"><![endif]-->\n    <a href=\"\" target=\"_blank\" class=\"v-button\" style=\"box-sizing: border-box;display: inline-block;text-decoration: none;-webkit-text-size-adjust: none;text-align: center;color: #FFFFFF; background-color: #0879A1; border-radius: 4px;-webkit-border-radius: 4px; -moz-border-radius: 4px; width:auto; max-width:100%; overflow-wrap: break-word; word-break: break-word; word-wrap:break-word; mso-border-alt: none;font-size: 14px;\">\n      <span style=\"display:block;padding:10px 20px;line-height:120%;\"><span style=\"font-size: 14px; line-height: 16.8px;\">Button Text</span></span>\n    </a>\n    <!--[if mso]></center></v:roundrect><![endif]-->\n</div>\n\n      </td>\n    </tr>\n  </tbody>\n</table>\n\n<table style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n  <tbody>\n    <tr>\n      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n        \n  <!--[if mso]><table role=\"presentation\" width=\"100%\"><tr><td><![endif]-->\n    <h1 style=\"margin: 0px; line-height: 140%; text-align: left; word-wrap: break-word; font-size: 22px; font-weight: 400;\">Need to test mail compose field in mobile</h1>\n  <!--[if mso]></td></tr></table><![endif]-->\n\n      </td>\n    </tr>\n  </tbody>\n</table>\n\n  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\n  </div>\n</div>\n<!--[if (mso)|(IE)]></td><![endif]-->\n      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\n    </div>\n  </div>\n  </div>\n  \n\n\n    <!--[if (mso)|(IE)]></td></tr></table><![endif]-->\n    </td>\n  </tr>\n  </tbody>\n  </table>\n  <!--[if mso]></div><![endif]-->\n  <!--[if IE]></div><![endif]-->\n</body>\n\n</html>\n",
          "email_subject": "Mail testing",
          "email_design_json": {
            "counters": {
              "u_column": 1,
              "u_row": 1,
              "u_content_button": 1,
              "u_content_heading": 1
            },
            "body": {
              "id": "JM4hhuDcgw",
              "rows": [
                {
                  "id": "YVIYPQ49v-",
                  "cells": [1],
                  "columns": [
                    {
                      "id": "QMJLI3q7PV",
                      "contents": [
                        {
                          "id": "6nLqKHSIaO",
                          "type": "button",
                          "values": {
                            "text":
                                "<span style=\"font-size: 14px; line-height: 16.8px;\">Button Text</span>",
                            "href": {
                              "name": "web",
                              "values": {"href": "", "target": "_blank"}
                            },
                            "buttonColors": {
                              "color": "#FFFFFF",
                              "backgroundColor": "#0879A1",
                              "hoverColor": "#FFFFFF",
                              "hoverBackgroundColor": "#0879A1"
                            },
                            "size": {"autoWidth": true, "width": "100%"},
                            "fontSize": "14px",
                            "lineHeight": "120%",
                            "textAlign": "center",
                            "padding": "10px 20px",
                            "border": {},
                            "borderRadius": "4px",
                            "displayCondition": null,
                            "_styleGuide": null,
                            "containerPadding": "10px",
                            "anchor": "",
                            "_meta": {
                              "htmlID": "u_content_button_1",
                              "htmlClassNames": "u_content_button"
                            },
                            "selectable": true,
                            "draggable": true,
                            "duplicatable": true,
                            "deletable": true,
                            "hideable": true,
                            "locked": false,
                            "_languages": {},
                            "calculatedWidth": 110,
                            "calculatedHeight": 37
                          }
                        },
                        {
                          "id": "Cwn0OVP3c5",
                          "type": "heading",
                          "values": {
                            "text": "Need to test mail compose field in mobile",
                            "containerPadding": "10px",
                            "anchor": "",
                            "headingType": "h1",
                            "fontSize": "22px",
                            "textAlign": "left",
                            "lineHeight": "140%",
                            "linkStyle": {
                              "inherit": true,
                              "linkColor": "#0000ee",
                              "linkHoverColor": "#0000ee",
                              "linkUnderline": true,
                              "linkHoverUnderline": true
                            },
                            "displayCondition": null,
                            "_styleGuide": null,
                            "_meta": {
                              "htmlID": "u_content_heading_1",
                              "htmlClassNames": "u_content_heading"
                            },
                            "selectable": true,
                            "draggable": true,
                            "duplicatable": true,
                            "deletable": true,
                            "hideable": true,
                            "locked": false,
                            "_languages": {}
                          }
                        }
                      ],
                      "values": {
                        "backgroundColor": "",
                        "padding": "0px",
                        "border": {},
                        "borderRadius": "0px",
                        "_meta": {
                          "htmlID": "u_column_1",
                          "htmlClassNames": "u_column"
                        },
                        "deletable": true,
                        "locked": false
                      }
                    }
                  ],
                  "values": {
                    "displayCondition": null,
                    "columns": false,
                    "_styleGuide": null,
                    "backgroundColor": "",
                    "columnsBackgroundColor": "",
                    "backgroundImage": {
                      "url": "",
                      "fullWidth": true,
                      "repeat": "no-repeat",
                      "size": "custom",
                      "position": "center",
                      "customPosition": ["50%", "50%"]
                    },
                    "padding": "0px",
                    "anchor": "",
                    "hideDesktop": false,
                    "_meta": {"htmlID": "u_row_1", "htmlClassNames": "u_row"},
                    "selectable": true,
                    "draggable": true,
                    "duplicatable": true,
                    "deletable": true,
                    "hideable": true,
                    "locked": false
                  }
                }
              ],
              "headers": [],
              "footers": [],
              "values": {
                "_styleGuide": null,
                "popupPosition": "center",
                "popupDisplayDelay": 0,
                "popupWidth": "600px",
                "popupHeight": "auto",
                "borderRadius": "10px",
                "contentAlign": "center",
                "contentVerticalAlign": "center",
                "contentWidth": "500px",
                "fontFamily": {
                  "label": "Arial",
                  "value": "arial,helvetica,sans-serif"
                },
                "textColor": "#000000",
                "popupBackgroundColor": "#FFFFFF",
                "popupBackgroundImage": {
                  "url": "",
                  "fullWidth": true,
                  "repeat": "no-repeat",
                  "size": "cover",
                  "position": "center"
                },
                "popupOverlay_backgroundColor": "rgba(0, 0, 0, 0.1)",
                "popupCloseButton_position": "top-right",
                "popupCloseButton_backgroundColor": "#DDDDDD",
                "popupCloseButton_iconColor": "#000000",
                "popupCloseButton_borderRadius": "0px",
                "popupCloseButton_margin": "0px",
                "popupCloseButton_action": {
                  "name": "close_popup",
                  "attrs": {
                    "onClick":
                        "document.querySelector('.u-popup-container').style.display = 'none';"
                  }
                },
                "language": {},
                "backgroundColor": "#F7F8F9",
                "preheaderText": "",
                "linkStyle": {
                  "body": true,
                  "linkColor": "#0000ee",
                  "linkHoverColor": "#0000ee",
                  "linkUnderline": true,
                  "linkHoverUnderline": true
                },
                "backgroundImage": {
                  "url": "",
                  "fullWidth": true,
                  "repeat": "no-repeat",
                  "size": "custom",
                  "position": "center"
                },
                "_meta": {"htmlID": "u_body", "htmlClassNames": "u_body"}
              }
            },
            "schemaVersion": 21
          },
          "groups": ["Community members"],
          "is_refined_by_state": "yes",
          "refine_state": ["VIC"],
          "status": "PENDING",
          "message_channel": "EMAIL",
          "email_attachments": []
        }
      };*/
      print(
          "*****************************************create campaign: $variables");
      final res = await repo.createCampaign(variables);
      if (res != "") {
        await getCampaignListing();
        Loaders.circularHideLoader(context);
        scaffoldMessenger("Campaign successfully Created");

        navigationService.goBack();
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      print("Error in createCampaign: $e");
    }
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
    } catch (e) {
      print("Error in getContacts: $e");
    }
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
      if (res != null) {
        statesByGroups = res;
        stateOptions = statesByGroups?.campaignContacts
                ?.map((e) => e.state ?? '')
                .where((state) => state.isNotEmpty)
                .toList() ??
            [];
      }
      notifyListeners();
    } catch (e) {
      print("Error in getStatesByGroups: $e");
    }
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
    notifyListeners();
  }
}
