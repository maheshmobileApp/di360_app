import 'package:di360_flutter/common/constants/local_storage_const.dart';
import 'package:di360_flutter/data/local_storage.dart';
import 'package:di360_flutter/feature/community/model/get_community_members.dart';
import 'package:di360_flutter/feature/community/model/get_directory_res.dart';
import 'package:di360_flutter/feature/community/model/get_joined_community_members.dart';
import 'package:di360_flutter/feature/community/model/get_new_feed_categories.dart';
import 'package:di360_flutter/feature/community/model/get_partnership_members.dart';
import 'package:di360_flutter/feature/community/repository/community_repo_impl.dart';
import 'package:di360_flutter/utils/alert_diaglog.dart';
import 'package:di360_flutter/utils/loader.dart';
import 'package:flutter/material.dart';

class CommunityViewModel extends ChangeNotifier {
  final CommunityRepoImpl repo = CommunityRepoImpl();

  CommunityMembersData? communityMembers;
  PartnershipMembersData? partnershipMembers;
  String selectedStatus = "All";
  TextEditingController membershipLinkController = TextEditingController();
  TextEditingController partnershipLinkController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  bool editMode = false;
  String editCategoryId = "";

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

    getJoinRequest();
    getPartnershipRequest();
    notifyListeners();
    //INACTIVE
  }

  void updateEditMode(bool value) {
    editMode = value;
    notifyListeners();
  }

  void updateEditCategoryId(String value) {
    editCategoryId = value;
    notifyListeners();
  }

  //GET JOIN REQUEST
  Future<void> getJoinRequest() async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await repo.getJoinRequest(id, listingStatus ?? "");
    if (res != null) {
      communityMembers = res;
      print("*********************communityMembers: ${communityMembers}");
    }
    notifyListeners();
  }

  //GET PARTNERSHIP REQUESTS
  Future<void> getPartnershipRequest() async {
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);
    final res = await repo.getPartnershipRequest(id, listingStatus ?? "");
    if (res != null) {
      partnershipMembers = res;
      print("*********************communityMembers: ${communityMembers}");
    }
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
      print("📌 variables: $variables");

      final res = await repo.getMembershipLink(variables);

      final directoryList = res.directories ?? [];

      if (directoryList.isNotEmpty) {
        membershipLink = directoryList.first.membershipLink ?? "";
      } else {
        membershipLink = "";
      }
    } catch (e, s) {
      print("❌ Error while fetching membership link: $e");
      print(s);

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
      print("📌 variables: $variables");

      final res = await repo.getPartnershipLink(variables);

      final directoryList = res.directories ?? [];

      if (directoryList.isNotEmpty) {
        partnershipLink = directoryList.first.partnershipLink ?? "";
      } else {
        partnershipLink = "";
      }
    } catch (e, s) {
      print("❌ Error while fetching membership link: $e");
      print(s);

      partnershipLink = "";
    } finally {
      Loaders.circularHideLoader(context);
      notifyListeners();
    }
  }

  Future<void> updateCategory(BuildContext context,String id) async {
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
    print("*********************variables: ${variables}");
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
    print("*********************Directory calling");
    final id = await LocalStorage.getStringVal(LocalStorageConst.userId);

    final variables = {
      "where": {
        "dental_supplier_id": {"_eq": id}
      }
    };
    final res = await repo.getDirectory(variables);
    if (res != null) {
      directoryData = res;
      print(res);
    }
    notifyListeners();
  }

  //Delete Category---------------------------------------------------------------

  Future<void> deleteCategory(BuildContext context,String id) async {
    Loaders.circularShowLoader(context);
    print("*********************Delete Category calling");
    final variables = {"id": id};
    print("*********************variables: ${variables}");
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
    print("*********************Update Membership Link calling");
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

  //UPDATE MEMBERSHIP LINK
  Future<void> updatePartnershipLink(BuildContext context, String id) async {
    final variables = {
      "id": id,
      "fields": {"partnership_link": partnershipLinkController.text}
    };
    final res = await repo.updatePartnershipLink(variables);
    if (res != null) {
      scaffoldMessenger("Registration link updated Sucessfully");
    }
    partnershipLinkController.text = "";
    getPartnershipLink(context);
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

  Future<void> getNewsFeedCategories(BuildContext context,[String? newsFeedId]) async {
    Loaders.circularShowLoader(context);
    final communityId =
        await LocalStorage.getStringVal(LocalStorageConst.communityId);
    final type = await LocalStorage.getStringVal(LocalStorageConst.type);
    final variables = {
      "communityId": (type == "PROFESSIONAL") ? newsFeedId : communityId
    };
    print("*********************variables: ${variables}");
    final res = await repo.getNewsFeedCategories(variables);
    if (res != null) {
      newsFeedCategoriesData = res;
      print("*********************All category fetched successfully");
    }
    Loaders.circularHideLoader(context);

    notifyListeners();
  }

  /*--------------------------------------------------------------------*/

  Future<void> approveJoinRequest(
      String id, String status, BuildContext context) async {
    print("*********************APPROVE calling");
    Loaders.circularShowLoader(context);

    final variables = {
      "id": id,
      "fields": {"status": status}
    };
    print("*********************variables: ${variables}");
    final res = await repo.approveJoinRequest(variables);
    print("*********************res: ${res}");
    if (res != null) {
      (status == "APPROVED")
          ? scaffoldMessenger("Member has been Approved Sucessfully")
          : scaffoldMessenger("Member has been Rejected Sucessfully");
    }
    getJoinRequest();
    Loaders.circularHideLoader(context);
    print("*********************All Reuqests calling");
    notifyListeners();
  }

  Future<void> approvePartnershipRequest(
      String id, String status, BuildContext context) async {
    print("*********************APPROVE calling");
    Loaders.circularShowLoader(context);

    final variables = {
      "id": id,
      "fields": {"status": status}
    };

    print("*********************variables: ${variables}");
    final res = await repo.approvePartnershipRequest(variables);
    print("*********************res: ${res}");
    if (res != null) {
      (status == "APPROVED")
          ? scaffoldMessenger("Member has been Approved Sucessfully")
          : scaffoldMessenger("Member has been Rejected Sucessfully");
    }
    getPartnershipRequest();
    Loaders.circularHideLoader(context);
    print("*********************All Reuqests calling");
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
    Loaders.circularShowLoader(context);

    final variables = {"member_id": id};
    final res = await repo.getJoinedCommunityMembers(variables);
    if (res != null) {
      getJoinedCommunityMembersData = res;
      Loaders.circularHideLoader(context);
    }
    notifyListeners();
  }
}
