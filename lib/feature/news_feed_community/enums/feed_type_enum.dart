enum FeedType {
  LEARNHUB,
  CATALOGUE,
  JOBS,
  DEFAULT;

  static FeedType fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'LEARNHUB':
        return FeedType.LEARNHUB;
      case 'CATALOGUE':
        return FeedType.CATALOGUE;
      case 'JOBS':
        return FeedType.JOBS;
      default:
        return FeedType.DEFAULT;
    }
  }
}
