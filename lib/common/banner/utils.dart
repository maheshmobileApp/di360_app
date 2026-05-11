List<int> getBannerIndices(int itemCount, int interval) {
  List<int> indices = [];
  for (int i = 0; i <= itemCount; i += interval) {
    indices.add(i);
  }
  return indices;
}

class BannerUtils {
  static const int bannerInterval = 6;

  static List<int> calculateBannerIndices(int itemCount) {
    return getBannerIndices(itemCount, bannerInterval);
  }
}