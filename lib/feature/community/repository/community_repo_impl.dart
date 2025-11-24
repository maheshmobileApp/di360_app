import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/community/model/get_community_members.dart';
import 'package:di360_flutter/feature/community/model/get_directory_res.dart';
import 'package:di360_flutter/feature/community/model/get_membership_link.dart';
import 'package:di360_flutter/feature/community/model/get_new_feed_categories.dart';
import 'package:di360_flutter/feature/community/model/get_partnership_link.dart';
import 'package:di360_flutter/feature/community/model/get_partnership_members.dart';
import 'package:di360_flutter/feature/community/query/add_category_query.dart';
import 'package:di360_flutter/feature/community/query/approve_query.dart';
import 'package:di360_flutter/feature/community/query/delete_category_query.dart';
import 'package:di360_flutter/feature/community/query/get_directory_query.dart';
import 'package:di360_flutter/feature/community/query/get_join_requests_query.dart';
import 'package:di360_flutter/feature/community/query/get_membership_link_query.dart';
import 'package:di360_flutter/feature/community/query/get_news_feed_categories_query.dart';
import 'package:di360_flutter/feature/community/query/get_partnership_link_query.dart';
import 'package:di360_flutter/feature/community/query/get_partnership_requests_query.dart';
import 'package:di360_flutter/feature/community/query/update_category_query.dart';
import 'package:di360_flutter/feature/community/query/update_membership_link_query.dart';
import 'package:di360_flutter/feature/community/repository/community_repository.dart';

class CommunityRepoImpl extends CommunityRepository {
  final HttpService http = HttpService();
  @override
  Future<CommunityMembersData> getJoinRequest(
      String supplierId, String listingStatus) async {
    final Map<String, dynamic> whereCondition = {};

    // Always add supplier_id if provided
    if (supplierId.isNotEmpty) {
      whereCondition["supplier_id"] = {"_eq": supplierId};
    }

    // Handle different status conditions
    if (listingStatus == "REGISTERED") {
      whereCondition["is_registered"] = {"_eq": true};
    } else if (listingStatus == "PENDING") {
      whereCondition["status"] = {"_eq": "PENDING"};
    } else if (listingStatus == "APPROVED") {
      whereCondition["status"] = {"_eq": "APPROVED"};
    } else if (listingStatus == "REJECTED") {
      whereCondition["status"] = {"_eq": "REJECTED"};
    } else if (listingStatus == "ALL") {
      whereCondition["_or"] = [
        {
          "is_registered": {"_eq": true}
        },
        {
          "status": {
            "_in": ["PENDING", "APPROVED", "REJECTED"]
          }
        }
      ];
    }

    final payload = {
      "where": whereCondition,
      "limit": 100,
      "offset": 0,
    };

    final res = await http.query(getJoinRequestQuery, variables: payload);
    final data = CommunityMembersData.fromJson(res);
    return data;
  }

  @override
  Future approveJoinRequest(dynamic variables) async {
    final res = await http.mutation(approveQuery, variables);
    return res;
  }

  @override
  Future<PartnershipMembersData> getPartnershipRequest(
      String supplierId, String listingStatus) async {
    final Map<String, dynamic> whereCondition = {};

    // Always add supplier_id if provided
    if (supplierId.isNotEmpty) {
      whereCondition["supplier_id"] = {"_eq": supplierId};
    }

    // Handle different status conditions
    if (listingStatus == "REGISTERED") {
      whereCondition["is_registered"] = {"_eq": true};
    } else if (listingStatus == "PENDING") {
      whereCondition["status"] = {"_eq": "PENDING"};
    } else if (listingStatus == "APPROVED") {
      whereCondition["status"] = {"_eq": "APPROVED"};
    } else if (listingStatus == "REJECTED") {
      whereCondition["status"] = {"_eq": "REJECTED"};
    } else if (listingStatus == "ALL") {
      whereCondition["_or"] = [
        {
          "is_registered": {"_eq": true}
        },
        {
          "status": {
            "_in": ["PENDING", "APPROVED", "REJECTED"]
          }
        }
      ];
    }

    final payload = {
      "where": whereCondition,
      "limit": 100,
      "offset": 0,
    };

    final res =
        await http.query(getPartnershipRequestsQuery, variables: payload);
    final data = PartnershipMembersData.fromJson(res);
    return data;
  }

  @override
  Future<MembershipLinkData> getMembershipLink(variables) async {
    final res = await http.query(getMembershipQuery, variables: variables);
    final data = MembershipLinkData.fromJson(res);
    return data;
  }

  @override
  Future<PartnershipLinkData> getPartnershipLink(variables) async {
    final res = await http.query(getPartnershipQuery, variables: variables);
    final data = PartnershipLinkData.fromJson(res);
    return data;
  }
  
  @override
  Future updateMembershipLink(variables) async {
    final res = await http.mutation(updateMembershipLinkQuery,variables);
    return res;
  }

  @override
  Future updatePartnershipLink(variables) async {
    final res = await http.mutation(updateMembershipLinkQuery,variables);
    return res;
  }
  
  @override
  Future<DirectoryData> getDirectory(variables)  async {
    final res = await http.query(getDirectoryQuery,variables:variables);
    final data = DirectoryData.fromJson(res);
    return data;
    
  }

  @override
  Future<NewsFeedCategoriesData> getNewsFeedCategories(variables) async {
    final res = await http.query(getNewsFeedCategoriesQuery,variables:variables);
    final data = NewsFeedCategoriesData.fromJson(res);
    return data;
    
  }
  
  @override
  Future addCategory(variables) async {
    final res = await http.mutation(addCategoryQuery,variables);
    return res;
  }

  
  @override
  Future deleteCategory(variables) async {
    final res = await http.mutation(deleteCategoryQuery,variables);
    return res;
  }

  @override
  Future updateCategory(variables) async {
    final res = await http.mutation(updateCategoryQuery,variables);
    return res;
  }
}
