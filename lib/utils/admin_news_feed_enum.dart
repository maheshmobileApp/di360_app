enum AdminNewsFeedStatus {
  pending('PENDING'),
  published('PUBLISHED'),
  unPublished('UNPUBLISHED'),
  publishedStatus('Published'),
  unpublishedStatus('Unpublished'),
  pendingStatus('Pending Approval');

  const AdminNewsFeedStatus(this.value);

  final String value;

  static AdminNewsFeedStatus? fromString(String? value) {
    if (value == null) return null;

    for (AdminNewsFeedStatus role in AdminNewsFeedStatus.values) {
      if (role.value == value) {
        return role;
      }
    }
    return null;
  }

  @override
  String toString() => value;
}
