abstract class NewsFeedRepository {
  Future<dynamic> getAllNewsFeed(int offset, int limit,
      {String? feedType, String? categoryType});
  Future<dynamic> hidePost(dynamic variables);
  Future<dynamic> blockUser(dynamic variables);
}
