class FilterCategory {
  final String id;
  final String name;
  final List<FilterCategory> children;

  const FilterCategory({
    required this.id,
    required this.name,
    this.children = const [],
  });
}