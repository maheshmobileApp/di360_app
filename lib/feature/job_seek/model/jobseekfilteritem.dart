
class FilterItem {
  final String name;
  final String id;
  bool isSelected;

  FilterItem({
    required this.name,
    required this.id,
    this.isSelected = false,
  });
}