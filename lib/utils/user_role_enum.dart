enum UserRole {
  admin('ADMIN'),
  professional('PROFESSIONAL'),
  supplier('SUPPLIER'),
  practice('PRACTICE');

  const UserRole(this.value);

  final String value;

  static UserRole? fromString(String? value) {
    if (value == null) return null;

    for (UserRole role in UserRole.values) {
      if (role.value == value) {
        return role;
      }
    }
    return null;
  }

  @override
  String toString() => value;
}
