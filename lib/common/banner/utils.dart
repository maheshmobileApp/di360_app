List<int> getBannerIndices(int itemCount, int interval) {
  List<int> indices = [];
  for (int i = 0; i <= itemCount; i += interval) {
    indices.add(i);
  }
  return indices;
}

class BannerUtils {
  static const int bannerInterval = 5; // Insert banner after every 5 items

  static List<int> calculateBannerIndices(int itemCount) {
    return getBannerIndices(itemCount, bannerInterval);
  }
}