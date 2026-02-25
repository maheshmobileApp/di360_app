enum VisibilityType {
  PUBLIC,
  PRIVATE,
  FOLLOWERS;

  String get displayName {
    switch (this) {
      case VisibilityType.PUBLIC:
        return 'Public';
      case VisibilityType.PRIVATE:
        return 'Only Me';
      case VisibilityType.FOLLOWERS:
        return 'Followers';
    }
  }

  static VisibilityType? fromDisplayName(String? name) {
    if (name == null) return null;
    return VisibilityType.values.firstWhere(
      (e) => e.displayName == name,
      orElse: () => VisibilityType.PUBLIC,
    );
  }

  static VisibilityType? fromEnumName(String? name) {
    if (name == null) return null;
    try {
      return VisibilityType.values.firstWhere(
        (e) => e.name == name,
      );
    } catch (e) {
      return null;
    }
  }
}