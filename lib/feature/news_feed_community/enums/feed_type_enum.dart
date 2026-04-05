enum FeedType {
  learnhub('LEARNHUB'),
  catalogue('CATALOGUE'),
  jobs('JOBS'),
  newsfeed('NEWSFEED'),
  profile('PROFILE'),
  directory('DIRECTORY'),
  talents('TALENTS'),
  banners('BANNERS'),
  campaign('CAMPAIGN'),
  course('COURSE'),
  joinCommunity('JOIN-COMMUNITY');

  const FeedType(this.value);

  final String value;

  static FeedType? fromString(String? value) {
    if (value == null) return null;

    for (FeedType type in FeedType.values) {
      if (type.value == value.toUpperCase()) {
        return type;
      }
    }
    return null;
  }

  @override
  String toString() => value;
}
