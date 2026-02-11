abstract class HomeRepository {
  Future<dynamic> getFollowerCount();
  Future<dynamic> getAllNewsFeed(int offset);
}