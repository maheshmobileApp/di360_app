import 'package:di360_flutter/common/constants/local_storage_const.dart';
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
import 'package:di360_flutter/utils/loader.dart';
import 'package:di360_flutter/utils/user_role_enum.dart';
import 'package:flutter/material.dart';

class CommunityViewModel extends ChangeNotifier {
  final CommunityRepoImpl repo = CommunityRepoImpl();

  CommunityMembersData? communityMembers;
  int _currentPage = 0;
  int _limitSize = 4;
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

  TextEditingController contactPhoneController = TextEditingController();

  bool editMode = false;
  bool contactEditMode = false;
  String updateContactId = "";
  String editCategoryId = "";

  void setUpdateContactId(String value) {
    updateContactId = value;
    notifyListeners();
  }

  List<String> phoneCodeList = ['AU (+61)', 'NZ (+64)'];
  String? selectedPhoneCode = "AU (+61)";
  void setPhoneCode(String value) {
    selectedPhoneCode = value;
    notifyListeners();
  }

  //***********************filters
  List<String> filterContactTypes = ["All", "Partner", "Member"];
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

  String selectedFilterContactType = "";

  void setSelectedFilterContactType(String value) {
    selectedFilterContactType = value;
    notifyListeners();
  }

  String selectedFilterState = "";
  void setSelectedFilterState(String value) {
    selectedFilterState = value;
    notifyListeners();
  }

  List<String> contactTypes = ["Partner", "Member"];
  String selectedContactType = "";
  void setSelectedContactType(String value) {
    selectedContactType = value;
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
    Loaders.circularShowLoader(context);
    if (loadMore) {
      if (isLoadingMore || !hasMoreData) return;
      isLoadingMore = true;
      _currentPage++;
    } else {
      _currentPage = 0;
      hasMoreData = true;
    }

    notifyListeners();

    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await repo.getJoinRequest(
        id, listingStatus ?? "", _limitSize, _currentPage * _limitSize);

    if (loadMore) {
      communityMembers?.communityMembers?.addAll(res.communityMembers ?? []);
      isLoadingMore = false;
    } else {
      communityMembers = res;
    }

    hasMoreData = (res.communityMembers?.length ?? 0) >= _limitSize;
    Loaders.circularHideLoader(context);
    notifyListeners();
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
    categoryController.text = "";
    getNewsFeedCategories(context);
    notifyListeners();
  }

  Future<void> addCategory(BuildContext context) async {
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
    categoryController.text = "";
    getNewsFeedCategories(context);
    notifyListeners();
  }

  DirectoryData? directoryData;

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
      await getNewsFeedCategories(context);
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

  Future<void> getNewsFeedCategories(BuildContext context,
      [String? newsFeedId]) async {
    Loaders.circularShowLoader(context);
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final variables = {
      "communityId": (type == UserRole.professional.value) ? newsFeedId : communityId
    };
    final res = await repo.getNewsFeedCategories(variables);
    newsFeedCategoriesData = res;
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

    if (selectedFilterContactType == "Partner") {
      whereClause["contact_type"] = {"_eq": "PARTNER"};
    } else if (selectedFilterContactType == "Member") {
      whereClause["contact_type"] = {"_eq": "MEMBER"};
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
      final companyName =
          await LocalStorage.getStringVal(LocalStorageConst.businessName);

      final phoneCode = selectedPhoneCode == "AU (+61)" ? "+61" : "+64";

      final variables = {
        "fields": {
          "contact_name": contactNameController.text,
          "email": contactEmailController.text,
          "phone": "${phoneCode}${contactPhoneController.text}",
          "company_name": companyName,
          "state": selectedState,
          "contact_type":
              selectedContactType == "Member" ? "MEMBER" : "PARTNER",
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
        navigationService.goBack();
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
      final companyName =
          await LocalStorage.getStringVal(LocalStorageConst.businessName);

      final phoneCode = selectedPhoneCode == "AU (+61)" ? "+61" : "+64";

      final variables = {
        "id": contactId,
        "fields": {
          "contact_name": contactNameController.text,
          "email": contactEmailController.text,
          "phone": "${phoneCode}${contactPhoneController.text}",
          "company_name": companyName,
          "state": selectedState,
          "contact_type":
              selectedContactType == "Member" ? "MEMBER" : "PARTNER",
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
    selectedState = data?.state ?? "";
    selectedContactType = data?.contactType == "MEMBER" ? "Member" : "Partner";
    contactEmailController.text = data?.email ?? "";
    final phone = data?.phone ?? "";
    contactPhoneController.text = phone.substring(3);
  }

  clearContactDetails() {
    contactNameController.text = "";
    selectedState = "";
    selectedContactType = "";
    contactEmailController.text = "";
    contactPhoneController.text = "";
    contactEditMode = false;
  }
}
