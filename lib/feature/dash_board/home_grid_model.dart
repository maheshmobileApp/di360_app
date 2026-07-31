
import 'package:di360_flutter/utils/permissions_enum.dart';

class HomeGridItem {
  final ModulePermission permission;
  final String title;
  final String image;

  const HomeGridItem({
    required this.permission,
    required this.title,
    required this.image,
  });
}