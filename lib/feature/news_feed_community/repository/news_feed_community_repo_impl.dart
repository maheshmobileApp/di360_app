import 'package:di360_flutter/core/http_service.dart';
import 'package:di360_flutter/feature/news_feed_community/model/banner_url_res.dart';
import 'package:di360_flutter/feature/news_feed_community/model/get_feed_count_res.dart';
import 'package:di360_flutter/feature/news_feed_community/model/get_news_feed_community_res.dart';
import 'package:di360_flutter/feature/news_feed_community/model/update_news_feed_status.dart';
import 'package:di360_flutter/feature/news_feed_community/query/add_need_feed.dart';
import 'package:di360_flutter/feature/news_feed_community/query/community_like_query.dart';
import 'package:di360_flutter/feature/news_feed_community/query/community_unlike_query.dart';
import 'package:di360_flutter/feature/news_feed_community/query/delete_new_feed_community.dart';
import 'package:di360_flutter/feature/news_feed_community/query/filter_community_query.dart';
import 'package:di360_flutter/feature/news_feed_community/query/get_all_news_feeds_query.dart';
import 'package:di360_flutter/feature/news_feed_community/query/get_banner_url.dart';
import 'package:di360_flutter/feature/news_feed_community/query/get_supplier_feed_count_query.dart';
import 'package:di360_flutter/feature/news_feed_community/query/leave_community_query.dart';
import 'package:di360_flutter/feature/news_feed_community/query/update_new_feed_community.dart';
import 'package:di360_flutter/feature/news_feed_community/repository/news_feed_community_repository.dart';

class NewsFeedCommunityRepoImpl extends NewsFeedCommunityRepository {
  final HttpService http = HttpService();

  @override
  Future<NewsFeedCommunityData> getAllNewsFeeds(dynamic variables) async {
    print("-------------------getAllNewsFeeds Calling----------------");
    final res = await http.query(getAllNewsFeedQuery, variables: variables);
    final data = NewsFeedCommunityData.fromJson(res);

    return data;
  }

  @override
  Future communityLike(variables) async {
    final res = await http.mutation(communityLikeQuery, variables);
    return res;
  }

  @override
  Future communityUnLike(variables) async {
    final res = await http.mutation(communityUnlikeQuery, variables);
    return res;
  }

  @override
  Future<FeedCountData> feedCount(variables) async {
    final res = await http.query(getSupplierFeedCount, variables: variables);
    final data = FeedCountData.fromJson(res);
    return data;
  }

  @override
  Future updateNewsFeedStatus(variables) async {
    final res = await http.mutation(updateFeedStatusQuery, variables);
    return res;
  }

  @override
  Future addNewsFeed(variables) async {
    final res = await http.mutation(addNeedFeedQuery, variables);
    return res;
  }

  @override
  Future updateNewsFeedCommunity(variables) async {
    final res = await http.mutation(updateNewsFeedCommunityQuery, variables);
    return res;
  }

  @override
  Future deleteNewsFeedCommunity(variables) async {
    final res = await http.mutation(deleteNewsFeedCommunityQuery, variables);
    return res;
  }

  @override
  Future<BannerUrlData> getBannerUrl(variables) async {
    final res = await http.query(getBannerUrlQuery,variables: variables);
    final data = BannerUrlData.fromJson(res);
    return data;
  }
  
  @override
  Future leaveCommunity(variables) async {
    final res = await http.mutation(leaveCommunityQuery, variables);
    return res;
  }
  
  @override
  Future<NewsFeedCommunityData> filterNewsFeed(variables)  async {
    final res = await http.query(filterCommunityQuery, variables:variables);
    final data = NewsFeedCommunityData.fromJson(res);
    return data;
  }

  
  
}
