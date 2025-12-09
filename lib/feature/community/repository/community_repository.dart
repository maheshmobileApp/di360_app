import 'package:di360_flutter/feature/community/model/get_community_members.dart';
import 'package:di360_flutter/feature/community/model/get_directory_res.dart';
import 'package:di360_flutter/feature/community/model/get_joined_community_members.dart';
import 'package:di360_flutter/feature/community/model/get_membership_link.dart';
import 'package:di360_flutter/feature/community/model/get_new_feed_categories.dart';
import 'package:di360_flutter/feature/community/model/get_partnership_link.dart';
import 'package:di360_flutter/feature/community/model/get_partnership_members.dart';

abstract class CommunityRepository {
  Future<CommunityMembersData> getJoinRequest(
      String supplierId, String listingStatus);
  Future<PartnershipMembersData> getPartnershipRequest(
      String supplierId, String listingStatus);
  Future<dynamic> approveJoinRequest(dynamic variables);
   Future<dynamic> approvePartnershipRequest(dynamic variables);
  Future<MembershipLinkData> getMembershipLink(dynamic variables);
  Future<PartnershipLinkData> getPartnershipLink(dynamic variables);
  Future<dynamic> updateMembershipLink(dynamic variables);
  Future<dynamic> updatePartnershipLink(dynamic variables);
  Future<DirectoryData> getDirectory(dynamic variables);
  Future<NewsFeedCategoriesData> getNewsFeedCategories(dynamic variables);
  Future<dynamic> addCategory(dynamic variables);
  Future<dynamic> deleteCategory(dynamic variables);
  Future<dynamic> updateCategory(dynamic variables);
  Future<GetJoinedCommunityMembersData> getJoinedCommunityMembers(
      dynamic variables);
}
