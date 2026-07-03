import 'package:di360_flutter/common/constants/constant_data.dart';
import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/common/routes/route_list.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/community/model/contacts_res.dart';
import 'package:di360_flutter/feature/community/model/get_community_members.dart';
import 'package:di360_flutter/feature/community/model/get_directory_res.dart';
import 'package:di360_flutter/feature/community/model/get_joined_community_members.dart';
import 'package:di360_flutter/feature/community/model/get_new_feed_categories.dart';
import 'package:di360_flutter/feature/community/model/get_partnership_members.dart';
import 'package:di360_flutter/feature/community/repository/community_repo_impl.dart';
import 'package:di360_flutter/services/navigation_services.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'dart:math';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class CommunityViewModel extends ChangeNotifier {
  final CommunityRepoImpl repo = CommunityRepoImpl();

   CommunityViewModel() {
    searchController.addListener(notifyListeners);
  }

  CommunityMembersData? communityMembers;
  int _currentPage = 0;
  int _limitSize = 10;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  PartnershipMembersData? partnershipMembers;
  int _partnershipCurrentPage = 0;
  bool isLoadingMorePartnership = false;
  bool hasMorePartnershipData = true;
  String selectedStatus = "All";
  TextEditingController membershipLinkController = TextEditingController();
  TextEditingController partnershipLinkController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController contactEmailController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController contactPhoneController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  bool editMode = false;
  bool isCategorySubmitting = false;
  bool contactEditMode = false;
  String updateContactId = "";
  String editCategoryId = "";
  DirectoryData? directoryData;
  bool searchBarOpen = false;

  void setUpdateContactId(String value) {
    updateContactId = value;
    notifyListeners();
  }

  void setSearchBar(bool val) {
    searchBarOpen = val;
    notifyListeners();
  }

  List<String> phoneCodeList = ConstantData.phoneCodeList;
  String? selectedPhoneCode = "AU (+61)";
  void setPhoneCode(String value) {
    selectedPhoneCode = value;
    notifyListeners();
  }

  //***********************filters
  List<String> filterContactTypes = [
    "All",
    "Partner",
    "Member",
    "Practice Owners",
    "Lab",
    "Dental Specialist",
    "Supplies",
    "Educators"
  ];
  List<String> filterStates = [
    "All",
    "New South Wales",
    "Victoria",
    "Queensland",
    "South Australia",
    "Western Australia",
    "Tasmania",
    "Northern Territory",
    "Australian Capital Territory"
  ];

  final List<Map<String, String>> filterStatesList = [
    {"name": 'New South Wales', "short": 'NSW'},
    {"name": 'Victoria', "short": 'VIC'},
    {"name": 'Queensland', "short": 'QLD'},
    {"name": 'South Australia', "short": 'SA'},
    {"name": 'Western Australia', "short": 'WA'},
    {"name": 'Tasmania', "short": 'TAS'},
    {"name": 'Northern Territory', "short": 'NT'},
    {"name": 'Australian Capital Territory', "short": 'ACT'},
  ];

  String selectedFilterContactType = "";
  bool appliedContactFilter = false;

  void setSelectedFilterContactType(String value) {
    selectedFilterContactType = value;
    notifyListeners();
  }

  void updateAppliedContactFilter(bool value) {
    appliedContactFilter = value;
    notifyListeners();
  }

  String selectedFilterState = "";
  void setSelectedFilterState(String value) {
    selectedFilterState = value;
    notifyListeners();
  }

  final List<Map<String, String>> contactTypes = [
    {"label": "Partner", "value": "PARTNER"},
    {"label": "Member", "value": "MEMBER"},
    {"label": "Practice Owners", "value": "PRACTICE_OWNERS"},
    {"label": "Lab", "value": "LAB"},
    {"label": "Dental Specialist", "value": "DENTAL_SPECIALIST"},
    {"label": "Supplies", "value": "SUPPLIES"},
    {"label": "Educators", "value": "EDUCATORS"},
  ];
  String selectedContactType = "";
  bool companyNameView = false;

  void updateCompanyNameView(bool value) {
    companyNameView = value;
    notifyListeners();
  }

  void setSelectedContactType(String value) {
    selectedContactType = value;
    updateCompanyNameView(true);
    if (value == "MEMBER") {
      companyNameController.clear();
      updateCompanyNameView(false);
    }
    notifyListeners();
  }

  List<String> states = [
    "New South Wales",
    "Victoria",
    "Queensland",
    "South Australia",
    "Western Australia",
    "Tasmania",
    "Northern Territory",
    "Australian Capital Territory"
  ];
  String selectedState = "";
  void setSelectedState(String value) {
    selectedState = value;
    notifyListeners();
  }

  final List<String> statuses = [
    'All',
    'Registered',
    'Pending',
    'Approved',
    'Rejected',
  ];

  String? listingStatus = "";

  void changeStatus(String status, BuildContext context) {
    selectedStatus = status;
    if (status == 'All') {
      listingStatus = "ALL";
    } else if (status == 'Registered') {
      listingStatus = 'REGISTERED';
    } else if (status == 'Pending') {
      listingStatus = "PENDING";
    } else if (status == 'Approved') {
      listingStatus = 'APPROVED';
    } else if (status == 'Rejected') {
      listingStatus = 'REJECTED';
    }

    getJoinRequest(context);
    getPartnershipRequest();
    notifyListeners();
    //INACTIVE
  }

  void updateEditMode(bool value) {
    editMode = value;
    notifyListeners();
  }

  void updateContactEditMode(bool value) {
    contactEditMode = value;
    notifyListeners();
  }

  void updateEditCategoryId(String value) {
    editCategoryId = value;
    notifyListeners();
  }

  //GET JOIN REQUEST
  Future<void> getJoinRequest(BuildContext context,
      {bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMore || !hasMoreData) return;
      isLoadingMore = true;
      _currentPage++;
    } else {
      _currentPage = 0;
      hasMoreData = true;
      Loaders.circularShowLoader(context);
    }

    notifyListeners();

    try {
      final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
      final res = await repo.getJoinRequest(
          id, listingStatus ?? "", _limitSize, _currentPage * _limitSize);

      if (loadMore) {
        communityMembers?.communityMembers?.addAll(res.communityMembers ?? []);
      } else {
        communityMembers = res;
      }

      hasMoreData = (res.communityMembers?.length ?? 0) >= _limitSize;
    } catch (e) {
      if (loadMore) {
        isLoadingMore = false;
        _currentPage = max(0, _currentPage - 1);
      }
      rethrow;
    } finally {
      if (loadMore) {
        isLoadingMore = false;
      } else {
        Loaders.circularHideLoader(context);
      }
      notifyListeners();
    }
  }

  Future<void> getPartnershipRequest({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMorePartnership || !hasMorePartnershipData) return;
      isLoadingMorePartnership = true;
      _partnershipCurrentPage++;
    } else {
      _partnershipCurrentPage = 0;
      hasMorePartnershipData = true;
    }

    notifyListeners();

    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await repo.getPartnershipRequest(id, listingStatus ?? "",
        _limitSize, _partnershipCurrentPage * _limitSize);

    if (loadMore) {
      partnershipMembers?.partnershipMembers
          ?.addAll(res.partnershipMembers ?? []);
      isLoadingMorePartnership = false;
    } else {
      partnershipMembers = res;
    }

    hasMorePartnershipData =
        (res.partnershipMembers?.length ?? 0) >= _limitSize;
    notifyListeners();
  }

  String membershipLink = "";

  //GET MEMBERSHIP LINK---------------------------------------------------------------
  Future<void> getMembershipLink(BuildContext context) async {
    Loaders.circularShowLoader(context);

    try {
      final communityId =
          await LocalStorage.getStringVal(LocalStorageConst.communityId);

      final variables = {
        "value": communityId,
      };

      final res = await repo.getMembershipLink(variables);

      final directoryList = res.directories ?? [];

      if (directoryList.isNotEmpty) {
        membershipLink = directoryList.first.membershipLink ?? "";
      } else {
        membershipLink = "";
      }
    } catch (e) {
      membershipLink = "";
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  String partnershipLink = "";

  //GET PARTNERSHIP LINK---------------------------------------------------------------

  Future<void> getPartnershipLink(BuildContext context) async {
    Loaders.circularShowLoader(context);

    try {
      final communityId =
          await LocalStorage.getStringVal(LocalStorageConst.communityId);

      final variables = {
        "value": communityId,
      };

      final res = await repo.getPartnershipLink(variables);

      final directoryList = res.directories ?? [];

      if (directoryList.isNotEmpty) {
        partnershipLink = directoryList.first.partnershipLink ?? "";
      } else {
        partnershipLink = "";
      }
    } catch (e) {
      partnershipLink = "";
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  Future<void> updateCategory(BuildContext context, String id) async {
    if (isCategorySubmitting) return;
    isCategorySubmitting = true;
    notifyListeners();
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final createdBy = await LocalStorage.getStringVal(LocalStorageConst.type);
    final variables = {
      "id": id,
      "fields": {
        "category_name": categoryController.text,
        "created_by": createdBy,
        "created_by_user_id": userId,
        "community_id": communityId
      }
    };
    final res = await repo.updateCategory(variables);
    if (res != null) {
      scaffoldMessenger("Category updated Sucessfully");
    }
    await getNewsFeedCategoriesByCommunity(context);
    navigationService.goBack();
    categoryController.text = "";
    isCategorySubmitting = false;
    notifyListeners();
  }

  Future<void> addCategory(BuildContext context) async {
    if (isCategorySubmitting) return;
    isCategorySubmitting = true;
    notifyListeners();
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final userId = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final createdBy = await LocalStorage.getStringVal(LocalStorageConst.type);
    final variables = {
      "fields": {
        "category_name": categoryController.text,
        "created_by": createdBy,
        "created_by_user_id": userId,
        "community_id": communityId
      }
    };
    final res = await repo.addCategory(variables);
    if (res != null) {
      scaffoldMessenger("Category added Sucessfully");
    }
    await getNewsFeedCategoriesByCommunity(context);
    navigationService.goBack();
    categoryController.text = "";
    isCategorySubmitting = false;
    notifyListeners();
  }

  //GET DIRECTORY---------------------------------------------------------------
  Future<void> getDirectory() async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final variables = {
      "where": {
        "dental_supplier_id": {"_eq": id}
      }
    };
    final res = await repo.getDirectory(variables);
    directoryData = res;
    notifyListeners();
  }

  //Delete Category---------------------------------------------------------------

  Future<void> deleteCategory(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);
    final variables = {"id": id};
    final res = await repo.deleteCategory(variables);
    if (res != null) {
      await getNewsFeedCategoriesByCommunity(context);
      Loaders.circularHideLoader(context);
      scaffoldMessenger("Category deleted Sucessfully");
    }
    notifyListeners();
  }

  //UPDATE MEMBERSHIP LINK
  Future<void> updateMembershipLink(BuildContext context, String id) async {
    final variables = {
      "id": id,
      "fields": {"membership_link": membershipLinkController.text}
    };
    final res = await repo.updateMembershipLink(variables);
    if (res != null) {
      scaffoldMessenger("Registration link updated Sucessfully");
    }
    membershipLinkController.text = "";
    getMembershipLink(context);
    notifyListeners();
  }

  //UPDATE PARTNERSHIP LINK
  Future<void> updatePartnershipLink(BuildContext context, String id) async {
    final variables = {
      "id": id,
      "fields": {"partnership_link": partnershipLinkController.text}
    };
    final res = await repo.updatePartnershipLink(variables);
    if (res != null) {
      scaffoldMessenger("Registration link updated Sucessfully");
      partnershipLinkController.text = "";
      getPartnershipLink(context);
    }

    notifyListeners();
  }

  String? selectedCategoryId;

  void updateSelectedCategory(String? categoryId) {
    selectedCategoryId = categoryId;
    notifyListeners();
  }

  bool applyCatageories = false;

  void updateApplyCatageories(bool val) {
    applyCatageories = val;
    notifyListeners();
  }

  NewsFeedCategoriesData? newsFeedCategoriesData;
  NewsFeedCategoriesData? newsFeedCategoriesByCommunityData;
  NewsFeedCategoriesData? filterCatgoriesData;

  Future<void> getNewsFeedCategoriesByCommunity(BuildContext context,
      {String? type}) async {
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final variables = {
      "communityId": communityId,
    };
    final res = await repo.getNewsFeedCategoriesByCommunity(variables);
    newsFeedCategoriesByCommunityData = res;
  }

  Future<void> getNewsFeedCategories(BuildContext context,
      {String? type}) async {
    Loaders.circularShowLoader(context);
    print("**************getNewsFeedCategories Calling");
    final professionTypeId =
        await LocalStorage.getStringVal(LocalStorageConst.professionId);
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final variables = {
      "where": {
        "_and": [
          {
            "community_id": {"_is_null": true}
          },
          if (professionTypeId.isNotEmpty)
            {
              "_or": [
                {
                  "access_rules": {
                    "directory_category_id": {"_eq": professionTypeId}
                  }
                }
              ]
            }
        ]
      },
      "limit": 10,
      "offset": 0
    };
    final communityVariables = {
      "communityId": communityId,
      "limit": 10,
      "offset": 0
    };
    print("Variables for news feed categories: $communityVariables");
    final res = await repo.getNewsFeedCategories(
        type == "Community" ? communityVariables : variables, type ?? "");
    newsFeedCategoriesData = res;
    filterCatgoriesData = NewsFeedCategoriesData(
      newsfeedCategories: List.from(res.newsfeedCategories ?? []),
    );
    filterCatgoriesData?.newsfeedCategories
        ?.insert(0, NewsfeedCategories(id: '1', categoryName: 'Catalogue'));
    filterCatgoriesData?.newsfeedCategories
        ?.insert(1, NewsfeedCategories(id: '2', categoryName: 'Jobs'));
    filterCatgoriesData?.newsfeedCategories
        ?.insert(2, NewsfeedCategories(id: '3', categoryName: 'Learning Hub'));
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  /*--------------------------------------------------------------------*/

  Future<void> approveJoinRequest(
      String id, String status, BuildContext context) async {
    Loaders.circularShowLoader(context);

    final variables = {
      "id": id,
      "fields": {"status": status}
    };
    final res = await repo.approveJoinRequest(variables);
    if (res != null) {
      (status == "APPROVED")
          ? scaffoldMessenger("Member has been Approved Sucessfully")
          : scaffoldMessenger("Member has been Rejected Sucessfully");
    }
    getJoinRequest(context);
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  Future<void> approvePartnershipRequest(
      String id, String status, BuildContext context) async {
    Loaders.circularShowLoader(context);

    final variables = {
      "id": id,
      "fields": {"status": status}
    };

    final res = await repo.approvePartnershipRequest(variables);
    if (res != null) {
      (status == "APPROVED")
          ? scaffoldMessenger("Member has been Approved Sucessfully")
          : scaffoldMessenger("Member has been Rejected Sucessfully");
    }
    getPartnershipRequest();
    Loaders.circularHideLoader(context);
    notifyListeners();
  }

  //get joined community members

  GetJoinedCommunityMembersData? getJoinedCommunityMembersData;
  bool professionalMode = false;
  void changeProfessionalMode(bool value) {
    professionalMode = value;
    notifyListeners();
  }

  Future<void> getJoinedCommunityMembersRes(BuildContext context) async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final variables = {"member_id": id};
    final res = await repo.getJoinedCommunityMembers(variables);
    getJoinedCommunityMembersData = res;
    print("Joined Community Members: ${res.communityMembers?.length}");
    notifyListeners();
  }

  ContactsData? contactsRes;
  int _contactsOffset = 0;
  bool _hasMoreContacts = true;
  bool _isLoadingMoreContacts = false;

  bool get hasMoreContacts => _hasMoreContacts;
  bool get isLoadingMoreContacts => _isLoadingMoreContacts;

  Future<void> getContacts(BuildContext context,
      {bool loadMore = false}) async {
    if (loadMore) {
      if (_isLoadingMoreContacts || !_hasMoreContacts) return;
      _isLoadingMoreContacts = true;
    } else {
      Loaders.circularShowLoader(context);
      _contactsOffset = 0;
      _hasMoreContacts = true;
      contactsRes = null;
    }

    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);

    Map<String, dynamic> whereClause = {
      "created_by_id": {"_eq": id}
    };

    if (searchController.text.isNotEmpty) {
      whereClause["_or"] = [
        {
          "contact_name": {"_ilike": "%${searchController.text}%"}
        },
        {
          "email": {"_ilike": "%${searchController.text}%"}
        },
        {
          "phone": {"_ilike": "%${searchController.text}%"}
        },
        {
          "company_name": {"_ilike": "%${searchController.text}%"}
        }
      ];
    }

    if (selectedFilterContactType.isNotEmpty &&
        selectedFilterContactType != "All") {
      final match = contactTypes.firstWhere(
        (e) => e["label"] == selectedFilterContactType,
        orElse: () => {},
      );
      if (match["value"] != null) {
        whereClause["contact_type"] = {"_eq": match["value"]};
      }
    }

    if (selectedFilterState.isNotEmpty) {
      final match = filterStatesList.firstWhere(
        (e) => e["name"] == selectedFilterState,
        orElse: () => {},
      );
      if (match["short"] != null) {
        whereClause["state"] = {"_eq": match["short"]};
      }
    }

    final variables = {
      "where": whereClause,
      "limit": _limitSize,
      "offset": _contactsOffset
    };
    final res = await repo.getContacts(variables);

    if (res.partnersContactBook != null) {
      if (loadMore) {
        contactsRes?.partnersContactBook?.addAll(res.partnersContactBook!);
      } else {
        contactsRes = res;
      }
      _hasMoreContacts = (res.partnersContactBook?.length ?? 0) == _limitSize;
      _contactsOffset += res.partnersContactBook?.length ?? 0;
    }

    if (loadMore) {
      _isLoadingMoreContacts = false;
    } else {
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }

  Future<void> addContact(BuildContext context) async {
    Loaders.circularShowLoader(context);

    try {
      final id = await LocalStorage.getStringVal(LocalStorageConst.userId);

      final phoneCode = selectedPhoneCode == "AU (+61)" ? "+61" : "+64";

      final variables = {
        "fields": {
          "contact_name": contactNameController.text,
          "email": contactEmailController.text,
          "phone": "${phoneCode}${contactPhoneController.text}",
          "company_name": selectedContactType == "MEMBER"
              ? null
              : companyNameController.text,
          "state": selectedState,
          "contact_type": selectedContactType,
          "created_by_id": id
        }
      };
      final res = await repo.addContact(variables);
      if (res != null && res is Map && res.containsKey('_error')) {
        Loaders.circularHideLoader(context);
        final err = res['_error']?.toString() ?? 'Error adding contact';
        if (err.contains('unique_createdby_email')) {
          scaffoldMessenger("Contact with this email already exists");
        } else if (err.contains('unique_createdby_phone')) {
          scaffoldMessenger("Contact with this phone number already exists");
        } else if (err.toLowerCase().contains('uniqueness violation')) {
          scaffoldMessenger("Contact already exists");
        } else {
          scaffoldMessenger(err);
        }
        return;
      }

      if (res != null && res.containsKey('insert_partners_contact_book_one')) {
        await getContacts(context);
        navigationService.replaceWith(RouteList.contactView);
        Loaders.circularHideLoader(context);
        clearContactDetails();

        scaffoldMessenger("Contact added successfully");
      } else {
        Loaders.circularHideLoader(context);
        scaffoldMessenger("Failed to add contact");
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      final msg = e.toString();
      if (msg.contains('unique_createdby_email')) {
        scaffoldMessenger("Contact with this email already exists");
      } else if (msg.contains('unique_createdby_phone')) {
        scaffoldMessenger("Contact with this phone number already exists");
      } else if (msg.toLowerCase().contains('uniqueness violation')) {
        scaffoldMessenger("Contact already exists");
      } else {
        scaffoldMessenger("Error adding contact");
      }
    }
    notifyListeners();
  }

  Future<void> updateContact(BuildContext context, String contactId) async {
    Loaders.circularShowLoader(context);

    try {
      final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
      // final companyName =
      //     await LocalStorage.getStringVal(LocalStorageConst.businessName);

      final phoneCode = selectedPhoneCode == "AU (+61)" ? "+61" : "+64";

      final variables = {
        "id": contactId,
        "fields": {
          "contact_name": contactNameController.text,
          "email": contactEmailController.text,
          "phone": "${phoneCode}${contactPhoneController.text}",
          "company_name": selectedContactType == "MEMBER"
              ? null
              : companyNameController.text,
          "state": selectedState,
          "contact_type": selectedContactType,
          "created_by_id": id
        }
      };
      final res = await repo.updateContact(variables);

      if (res != null && res is Map && res.containsKey('_error')) {
        Loaders.circularHideLoader(context);
        final err = res['_error']?.toString() ?? 'Error updating contact';
        if (err.contains('unique_createdby_email')) {
          scaffoldMessenger("Contact with this email already exists");
        } else if (err.contains('unique_createdby_phone')) {
          scaffoldMessenger("Contact with this phone number already exists");
        } else if (err.toLowerCase().contains('uniqueness violation')) {
          scaffoldMessenger("Contact already exists");
        } else {
          scaffoldMessenger(err);
        }
        return;
      }

      if (res != null &&
          res.containsKey('update_partners_contact_book_by_pk')) {
        await getContacts(context);
        navigationService.goBack();
        Loaders.circularHideLoader(context);
        clearContactDetails();

        scaffoldMessenger("Contact updated successfully");
      } else {
        Loaders.circularHideLoader(context);
        scaffoldMessenger("Failed to add contact");
      }
    } catch (e) {
      Loaders.circularHideLoader(context);
      if (e.toString().contains('unique_createdby_email')) {
        scaffoldMessenger("Contact with this email already exists");
      } else if (e.toString().contains('unique_createdby_phone')) {
        scaffoldMessenger("Contact with this phone number already exists");
      } else if (e.toString().contains('Uniqueness violation')) {
        scaffoldMessenger("Contact already exists");
      } else {
        scaffoldMessenger("Error adding contact");
      }
    }
    notifyListeners();
  }

  Future<void> deleteContact(BuildContext context, String id) async {
    Loaders.circularShowLoader(context);

    final variables = {"id": id};
    final res = await repo.deleteContact(variables);
    if (res.deletePartnersContactBookByPk?.id != null) {
      await getContacts(context);
      navigationService.goBack();
      Loaders.circularHideLoader(context);

      scaffoldMessenger("Contact deleted sucessfully");
    } else {
      scaffoldMessenger("Something went wrong");
    }
    notifyListeners();
  }

  setContactDetails(PartnersContactBook? data) {
    contactNameController.text = data?.contactName ?? "";
    companyNameController.text = data?.companyName ?? "";
    selectedState = data?.state ?? "";
    selectedContactType = data?.contactType ?? "";
    contactEmailController.text = data?.email ?? "";
    final phone = data?.phone ?? "";
    if (phone.startsWith('+61')) {
      selectedPhoneCode = 'AU (+61)';
      contactPhoneController.text = phone.substring(3);
    } else if (phone.startsWith('+64')) {
      selectedPhoneCode = 'NZ (+64)';
      contactPhoneController.text = phone.substring(3);
    } else {
      selectedPhoneCode = 'AU (+61)';
      contactPhoneController.text = phone.replaceAll(RegExp(r'[^0-9]'), '');
    }
  }

  setContactDetailsFromPartners(PartnershipMembers? data) {
    contactNameController.text = data?.contactName ?? "";
    companyNameController.text = data?.companyName ?? "";
    selectedState = data?.state ?? "";
    contactEmailController.text = data?.email ?? "";
    final phone = data?.phone ?? "";
    if (phone.startsWith('+61')) {
      selectedPhoneCode = 'AU (+61)';
      contactPhoneController.text = phone.substring(3);
    } else if (phone.startsWith('+64')) {
      selectedPhoneCode = 'NZ (+64)';
      contactPhoneController.text = phone.substring(3);
    } else {
      selectedPhoneCode = 'AU (+61)';
      contactPhoneController.text = phone.replaceAll(RegExp(r'[^0-9]'), '');
    }
  }

  clearContactDetails() {
    contactNameController.text = "";
    companyNameController.text = "";
    selectedState = "";
    selectedContactType = "";
    contactEmailController.text = "";
    contactPhoneController.text = "";
    contactEditMode = false;
  }
}
