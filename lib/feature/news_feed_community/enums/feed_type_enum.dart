enum FeedType {
  learnhub('LEARNHUB'),
  catalogue('CATALOGUE'),
  jobs('JOBS'),
  newsfeed('NEWSFEED');

  const FeedType(this.value);

  final String value;

  static FeedType? fromString(String? value) {
    if (value == null) return null;

    for (FeedType type in FeedType.values) {
      if (type.value == value) {
        return type;
      }
    }
    return null;
  }

  @override
  String toString() => value;
}
